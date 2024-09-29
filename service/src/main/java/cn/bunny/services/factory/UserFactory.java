package cn.bunny.services.factory;

import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ip.IpUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.constant.LocalDateTimeConstant;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.constant.UserConstant;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RoleMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

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
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private MinioUtil minioUtil;

    public LoginVo buildUserVo(AdminUser user, long readMeDay) {
        // 创建token
        Long userId = user.getId();
        String email = user.getEmail();
        String token = JwtHelper.createToken(userId, email, (int) readMeDay);
        String avatar = user.getAvatar();

        // 判断用户是否有头像，如果没有头像设置默认头像
        avatar = StringUtils.hasText(avatar) ? minioUtil.getObjectNameFullPath(avatar) : UserConstant.USER_AVATAR;

        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setLastLoginIp(IpUtil.getCurrentUserIpAddress().getRemoteAddr());
        updateUser.setLastLoginIpAddress(IpUtil.getCurrentUserIpAddress().getIpRegion());

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);

        // 查找用户橘色
        List<String> roles = roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList();
        List<String> permissions = new ArrayList<>();

        // 判断是否是 admin 如果是admin 赋予所有权限
        boolean isAdmin = roles.stream().anyMatch(role -> role.equals("admin"));
        if (isAdmin) {
            permissions.add("*");
            permissions.add("*::*");
            permissions.add("*::*::*");
        } else permissions = powerMapper.selectListByUserId(userId).stream().map(Power::getPowerCode).toList();

        // 构建返回对象，设置用户需要内容
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setNickname(user.getNickName());
        loginVo.setAvatar(avatar);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setLastLoginIp(IpUtil.getCurrentUserIpAddress().getRemoteAddr());
        loginVo.setLastLoginIpAddress(IpUtil.getCurrentUserIpAddress().getIpRegion());
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);
        loginVo.setUpdateUser(userId);
        loginVo.setExpires(expires);

        // 将信息保存在Redis中
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(email), loginVo, readMeDay, TimeUnit.DAYS);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        return loginVo;
    }
}