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
        String avatar = user.getAvatar();

        // 获取IP地址
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 当前请求request
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        // 判断用户是否有头像，如果没有头像设置默认头像
        avatar = StringUtils.hasText(avatar) ? minioUtil.getObjectNameFullPath(avatar) : UserConstant.USER_AVATAR;

        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setLastLoginIp(ipAddr);
        updateUser.setLastLoginIpAddress(ipRegion);
        userMapper.updateById(updateUser);

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);

        // 查找用户橘色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());
        List<String> permissions = new ArrayList<>();

        // 判断是否是 admin 如果是admin 赋予所有权限
        boolean isAdmin = CustomCheckIsAdmin.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = powerMapper.selectListByUserId(userId).stream().map(Power::getPowerCode).toList();
        }

        // 构建返回对象，设置用户需要内容
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setNickname(user.getNickName());
        loginVo.setAvatar(avatar);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setLastLoginIp(ipAddr);
        loginVo.setLastLoginIpAddress(ipRegion);
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);
        loginVo.setUpdateUser(userId);
        loginVo.setExpires(expires);

        // 将用户登录保存在用户登录日志表中
        UserLoginLog userLoginLog = new UserLoginLog();
        BeanUtils.copyProperties(user, userLoginLog);
        userLoginLog.setUserId(userId);
        userLoginLog.setIpAddress(ipAddr);
        userLoginLog.setIpRegion(ipRegion);
        userLoginLog.setToken(token);
        userLoginLog.setType("login");
        if (requestAttributes != null) {
            HttpServletRequest request = requestAttributes.getRequest();
            String userAgent = request.getHeader("User-Agent");
            userLoginLog.setUserAgent(userAgent);
        }
        userLoginLogMapper.insert(userLoginLog);

        // 将信息保存在Redis中
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(email), loginVo, readMeDay, TimeUnit.DAYS);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        return loginVo;
    }
}