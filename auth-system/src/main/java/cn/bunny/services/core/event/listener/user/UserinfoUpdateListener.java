package cn.bunny.services.core.event.listener.user;

import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.model.system.entity.RolePermission;
import cn.bunny.domain.model.system.entity.UserRole;
import cn.bunny.services.core.event.event.ClearAllUserCacheEvent;
import cn.bunny.services.core.event.event.UpdateUserinfoByPermissionIdsEvent;
import cn.bunny.services.core.event.event.UpdateUserinfoByRoleIdsEvent;
import cn.bunny.services.core.event.event.UpdateUserinfoByUserIdsEvent;
import cn.bunny.services.mapper.system.RolePermissionMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import cn.bunny.services.security.service.UserLoginVoBuilderCacheService;
import jakarta.annotation.Resource;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("UserinfoUpdateListener")
public class UserinfoUpdateListener extends AbstractUserInfoUpdateHandler {

    @Resource
    private UserLoginVoBuilderCacheService userLoginVoBuilderCacheService;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    /* 根据用户id更新用户信息，重新生成LoginVo对象 */
    @EventListener
    @Async
    public void handlerUpdateUserinfoByUserIds(UpdateUserinfoByUserIdsEvent event) {
        List<Long> userIds = event.getUserIds();
        processUserUpdate(userIds, user -> {
            userCacheCleaner.cleanAllUserCache(user.getUsername());
            userLoginVoBuilderCacheService.buildLoginUserVo(user, RedisUserConstant.REDIS_EXPIRATION_TIME);
        });
    }

    /* 根据角色id更新用户信息，重新生成LoginVo对象 */
    @EventListener
    @Async
    public void handlerUserinfoUpdateByRoleId(UpdateUserinfoByRoleIdsEvent event) {
        List<Long> roleIds = event.getRoleIds();
        List<UserRole> userRoles = userRoleMapper.selectListByRoleIds(roleIds);
        List<Long> userIds = userRoles.stream().map(UserRole::getUserId).toList();

        UpdateUserinfoByUserIdsEvent userIdsEvent = new UpdateUserinfoByUserIdsEvent(event.getSource(), userIds);
        handlerUpdateUserinfoByUserIds(userIdsEvent);
    }

    /* 根据角色id更新用户信息，重新生成LoginVo对象 */
    @EventListener
    @Async
    public void handlerUserinfoUpdateByPermissionId(UpdateUserinfoByPermissionIdsEvent event) {
        List<Long> permissionIds = event.getPermissionIds();
        List<RolePermission> rolePermissions = rolePermissionMapper.selectRolePermissionListByPermissionIds(permissionIds);
        List<Long> roleIds = rolePermissions.stream().map(RolePermission::getRoleId).toList();

        UpdateUserinfoByRoleIdsEvent roleIdsEvent = new UpdateUserinfoByRoleIdsEvent(event.getSource(), roleIds);
        handlerUserinfoUpdateByRoleId(roleIdsEvent);
    }

    /* 清除用户登录、角色、权限所有缓存 */
    @EventListener
    @Async
    public void handlerDeleteAllUserCache(ClearAllUserCacheEvent event) {
        userCacheCleaner.cleanAllUserCache(event.getKey());
    }
}
