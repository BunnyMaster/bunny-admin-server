package cn.bunny.services.factory;

import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ip.IpUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.constant.LocalDateTimeConstant;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.constant.UserConstant;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.mapper.UserLoginLogMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.security.custom.CustomCheckIsAdmin;
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
@Transactional
public class UserFactory {
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

    public LoginVo buildUserVo(AdminUser user, long readMeDay) {
        // 创建token
        Long userId = user.getId();
        String email = user.getEmail();
        String token = JwtHelper.createToken(userId, email, (int) readMeDay);

        // 获取IP地址
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 更新用户登录信息
        setUpdateUser(userId, ipAddr, ipRegion);

        // 将用户登录保存在用户登录日志表中
        userLoginLogMapper.insert(setUserLoginLog(user, token, ipAddr, ipRegion, "login"));

        // 设置用户返回信息
        LoginVo loginVo = setLoginVo(user, token, readMeDay, ipAddr, ipRegion);

        // 将信息保存在Redis中
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(email), loginVo, readMeDay, TimeUnit.DAYS);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        return loginVo;
    }


    /**
     * * 设置更新用户设置内容
     */
    public LoginVo setLoginVo(AdminUser user, String token, long readMeDay, String ipAddr, String ipRegion) {
        Long userId = user.getId();

        // 判断用户是否有头像，如果没有头像设置默认头像
        String avatar = user.getAvatar();
        avatar = StringUtils.hasText(avatar) ? minioUtil.getObjectNameFullPath(avatar) : UserConstant.USER_AVATAR;

        // 查找用户橘色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());
        List<String> permissions = new ArrayList<>();

        // 判断是否是 admin 如果是admin 赋予所有权限
        boolean isAdmin = CustomCheckIsAdmin.checkAdmin(roles, permissions, user);
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
        loginVo.setNickname(user.getNickName());
        loginVo.setAvatar(avatar);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setIpAddress(ipAddr);
        loginVo.setIpRegion(ipRegion);
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);
        loginVo.setUpdateUser(userId);
        loginVo.setExpires(expires);

        return loginVo;
    }

    /**
     * * 设置更新用户设置内容
     *
     * @param userId 用户ID
     */
    public void setUpdateUser(Long userId, String ipAddr, String ipRegion) {
        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setIpAddress(ipAddr);
        updateUser.setIpRegion(ipRegion);
        userMapper.updateById(updateUser);
    }

    /**
     * 检查用户头像是否合规
     *
     * @param avatar 头像字符串
     * @return 整理好的头像内容
     */
    public String checkUserAvatar(String avatar) {
        if (!StringUtils.hasText(avatar)) return null;
        String regex = "https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (!matcher.matches()) return null;

        // 匹配后返回内容
        return "/" + matcher.group(1);
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