package cn.bunny.system.core.event.listener;

import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.system.entity.RolePermission;
import cn.bunny.domain.system.entity.UserRole;
import cn.bunny.system.core.cache.UserLoginVoBuilderCacheService;
import cn.bunny.system.core.event.ClearAllUserCacheEvent;
import cn.bunny.system.core.event.UpdateUserinfoByPermissionIdsEvent;
import cn.bunny.system.core.event.UpdateUserinfoByRoleIdsEvent;
import cn.bunny.system.core.event.UpdateUserinfoByUserIdsEvent;
import cn.bunny.system.mapper.RolePermissionMapper;
import cn.bunny.system.mapper.UserRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("UserinfoUpdateListener" )
public class UserinfoUpdateListener extends AbstractUserInfoUpdateHandler {

    @Autowired
    private UserLoginVoBuilderCacheService userLoginVoBuilderCacheService;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
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
