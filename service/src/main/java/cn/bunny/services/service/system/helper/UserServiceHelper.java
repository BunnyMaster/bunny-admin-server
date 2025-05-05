package cn.bunny.services.service.system.helper;

import cn.bunny.services.cache.UserCacheService;
import cn.bunny.services.domain.system.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.entity.RolePermission;
import cn.bunny.services.domain.system.system.entity.UserRole;
import cn.bunny.services.mapper.log.UserLoginLogMapper;
import cn.bunny.services.mapper.system.RolePermissionMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;

@Service
public class UserServiceHelper {

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private UserCacheService userCacheService;

    @Resource
    private UserLoginLogMapper userLoginLogMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    /**
     * 设置用户登录日志内容
     * <p>
     * 该方法用于将管理员用户信息复制到用户登录日志对象中，同时处理特殊字段映射关系。
     * <p>
     * 实现说明：
     * 1. 使用BeanUtils.copyProperties()复制属性时，会自动将AdminUser.id复制到UserLoginLog.id
     * 2. 由于UserLoginLog实际需要的是userId字段而非id字段，需要特殊处理：
     * - 先进行属性复制
     * - 然后将UserLoginLog.userId设置为AdminUser.id
     * - 最后将UserLoginLog.id显式设为null（避免自动生成的id被覆盖）
     *
     * @param user  管理员用户实体对象，包含用户基本信息
     * @param token 本次登录/退出的认证令牌
     * @param type  操作类型（LOGIN-登录/LOGOUT-退出）
     */
    public void setUserLoginLog(AdminUser user, String token, String type) {
        UserLoginLog userLoginLog = new UserLoginLog();
        BeanUtils.copyProperties(user, userLoginLog);
        userLoginLog.setUserId(user.getId());
        userLoginLog.setId(null);
        userLoginLog.setToken(token);
        userLoginLog.setType(type);

        // 当前请求request
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = requestAttributes.getRequest();

            // 获取User-Agent
            String userAgent = request.getHeader("User-Agent");
            userLoginLog.setUserAgent(userAgent);

            // 获取X-Requested-With
            String xRequestedWith = request.getHeader("X-Requested-With");
            userLoginLog.setXRequestedWith(xRequestedWith);
        }

        userLoginLogMapper.insert(userLoginLog);
    }

    /**
     * 处理角色更新事件
     *
     * @param roleIds 角色ID
     */
    @Async
    public void updateBatchUserRedisInfoByRoleId(List<Long> roleIds) {
        // 批量查询关联用户ID
        List<UserRole> userRoles = userRoleMapper.selectListByRoleIds(roleIds);
        List<Long> userIds = userRoles.stream().map(UserRole::getUserId).toList();
        userCacheService.updateUserRedisInfo(userIds);
    }

    /**
     * 处理权限更新事件
     *
     * @param permissionIds 权限ID
     */
    @Async
    public void updateBatchUserRedisInfoByPermissionId(List<Long> permissionIds) {
        // 批量查询关联用户ID
        List<RolePermission> rolePermissions = rolePermissionMapper.selectRolePermissionListByPermissionIds(permissionIds);
        List<Long> roleIds = rolePermissions.stream().map(RolePermission::getRoleId).toList();
        updateBatchUserRedisInfoByRoleId(roleIds);
    }

}
