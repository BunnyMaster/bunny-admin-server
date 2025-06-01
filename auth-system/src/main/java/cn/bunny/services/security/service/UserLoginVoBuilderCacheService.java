package cn.bunny.services.security.service;

import cn.bunny.core.utils.JwtTokenUtil;
import cn.bunny.domain.common.constant.LocalDateTimeConstant;
import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.common.model.vo.LoginVo;
import cn.bunny.domain.model.system.entity.AdminUser;
import cn.bunny.domain.model.system.entity.Permission;
import cn.bunny.domain.model.system.entity.Role;
import cn.bunny.services.core.utils.RoleHelper;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import jakarta.annotation.Resource;
import lombok.Value;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class UserLoginVoBuilderCacheService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private PermissionMapper permissionMapper;

    public LoginVo buildLoginUserVo(AdminUser user, long readMeDay) {
        String username = user.getUsername();
        Long userId = user.getId();

        UserAuthInfo authInfo = getAuthInfo(userId, user);

        // 设置用户返回对象
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setPersonDescription(user.getSummary());
        loginVo.setRoles(authInfo.getRoles());
        loginVo.setPermissions(authInfo.getPermissions());

        // 使用用户名创建token
        String token = JwtTokenUtil.createToken(userId, username, (int) readMeDay);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setReadMeDay(readMeDay);

        // 计算过期时间，并格式化返回
        String expires = calculateExpires(readMeDay);
        loginVo.setExpires(expires);

        String loginInfoPrefix = RedisUserConstant.getUserLoginInfoPrefix(username);
        redisTemplate.opsForValue().set(loginInfoPrefix, loginVo, readMeDay, TimeUnit.DAYS);
        return loginVo;
    }

    private UserAuthInfo getAuthInfo(Long userId, AdminUser user) {
        // 用户角色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());

        // 判断是否是 admin 如果是admin 赋予所有权限
        List<String> permissions = new ArrayList<>();
        boolean isAdmin = RoleHelper.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = permissionMapper.selectListByUserId(userId).stream()
                    .map(Permission::getPowerCode)
                    .toList();
        }

        // 为这两个去重，在判断 checkAdmin 会重新赋值
        permissions = permissions.stream().distinct().toList();
        roles = roles.stream().distinct().toList();

        return new UserAuthInfo(roles, permissions);
    }

    private String calculateExpires(long readMeDay) {
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        return plusDay.format(dateTimeFormatter);
    }

    @Value
    private static class UserAuthInfo {
        List<String> roles;
        List<String> permissions;
    }
}
