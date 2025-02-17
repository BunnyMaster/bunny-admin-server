package cn.bunny.services.utils;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ip.IpUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.constant.LocalDateTimeConstant;
import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.constant.UserConstant;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.mapper.UserLoginLogMapper;
import cn.bunny.services.mapper.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class UserUtil {
    @Autowired
    private PowerMapper powerMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserLoginLogMapper userLoginLogMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private MinioUtil minioUtil;

    /**
     * 构建登录用户返回对象
     *
     * @param user      用户
     * @param readMeDay 保存登录信息时间
     * @return 登录信息
     */
    @Transactional(rollbackFor = AuthCustomerException.class)
    public LoginVo buildLoginUserVo(AdminUser user, long readMeDay) {
        Long userId = user.getId();
        String email = user.getEmail();
        String username = user.getUsername();

        // 使用用户名创建token
        String token = JwtHelper.createToken(userId, username, (int) readMeDay);

        // 获取IP地址并更新用户登录信息
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setIpAddress(ipAddr);
        updateUser.setIpRegion(ipRegion);
        userMapper.updateById(updateUser);

        // 将用户登录保存在用户登录日志表中
        userLoginLogMapper.insert(setUserLoginLog(user, token, ipAddr, ipRegion, "login"));

        // 设置用户返回信息
        LoginVo loginVo = setLoginVo(user, token, readMeDay, ipAddr, ipRegion);

        // 将信息保存在Redis中，一定要确保用户名是唯一的
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(username), loginVo, readMeDay, TimeUnit.DAYS);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        return loginVo;
    }

    /**
     * * 构建用户返回对象LoginVo
     *
     * @param user      用户对象
     * @param readMeDay 记住我时间
     */
    public void buildUserVo(AdminUser user, long readMeDay) {
        Long userId = user.getId();
        String username = user.getUsername();

        // 使用用户名创建token
        String token = JwtHelper.createToken(userId, username, (int) readMeDay);

        // 设置用户返回信息
        LoginVo loginVo = setLoginVo(user, token, readMeDay, user.getIpAddress(), user.getIpRegion());

        // 将信息保存在Redis中，一定要确保用户名是唯一的
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(username), loginVo, readMeDay, TimeUnit.DAYS);
    }


    /**
     * * 设置更新用户设置内容
     */
    public LoginVo setLoginVo(AdminUser user, String token, long readMeDay, String ipAddr, String ipRegion) {
        Long userId = user.getId();

        // 判断用户是否有头像，如果没有头像设置默认头像，并且用户头像不能和默认头像相同
        String avatar = checkGetUserAvatar(user.getAvatar());

        // 查找用户橘色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());
        List<String> permissions = new ArrayList<>();

        // 判断是否是 admin 如果是admin 赋予所有权限
        boolean isAdmin = RoleUtil.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = powerMapper.selectListByUserId(userId).stream().map(Power::getPowerCode).toList();
        }

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);

        // 构建返回对象，设置用户需要内容
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setNickname(user.getNickname());
        loginVo.setAvatar(avatar);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setIpAddress(ipAddr);
        loginVo.setIpRegion(ipRegion);
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);
        loginVo.setUpdateUser(userId);
        loginVo.setPersonDescription(user.getSummary());
        loginVo.setExpires(expires);
        loginVo.setReadMeDay(readMeDay);

        return loginVo;
    }

    /**
     * 检查用户头像是否合规
     *
     * @param avatar 头像字符串
     * @return 整理好的头像内容
     */
    public String checkPostUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (!matcher.matches()) return avatar;

        // 匹配后返回内容
        return "/" + matcher.group(1);
    }

    /**
     * 检查用户头像是否合规
     *
     * @param avatar 头像字符串
     * @return 整理好的头像内容
     */
    public String checkGetUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (matcher.matches()) return avatar;

        // 匹配后返回内容
        return minioUtil.getObjectNameFullPath(avatar);
    }


    /**
     * * 设置用户登录日志内容
     */
    public UserLoginLog setUserLoginLog(AdminUser user, String token, String ipAddr, String ipRegion, String type) {
        Long userId = user.getId();

        UserLoginLog userLoginLog = new UserLoginLog();
        userLoginLog.setUsername(user.getUsername());
        userLoginLog.setUserId(userId);
        userLoginLog.setIpAddress(ipAddr);
        userLoginLog.setIpRegion(ipRegion);
        userLoginLog.setToken(token);
        userLoginLog.setType(type);
        userLoginLog.setCreateUser(userId);
        userLoginLog.setUpdateUser(userId);
        userLoginLog.setCreateTime(LocalDateTime.now());
        userLoginLog.setUpdateTime(LocalDateTime.now());

        // 当前请求request
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (requestAttributes == null) return userLoginLog;
        HttpServletRequest request = requestAttributes.getRequest();

        // 获取User-Agent
        String userAgent = request.getHeader("User-Agent");
        userLoginLog.setUserAgent(userAgent);

        // 获取X-Requested-With
        String xRequestedWith = request.getHeader("X-Requested-With");
        userLoginLog.setXRequestedWith(xRequestedWith);

        return userLoginLog;
    }
}