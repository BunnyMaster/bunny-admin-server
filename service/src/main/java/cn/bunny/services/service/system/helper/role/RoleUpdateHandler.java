package cn.bunny.services.service.system.helper.role;

import cn.bunny.services.domain.system.system.entity.UserRole;
import cn.bunny.services.mapper.system.UserRoleMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.annotation.Resource;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 角色更新事件处理器
 *
 * <p><b>职责说明</b>：监听并处理角色变更事件，同步更新关联用户的权限信息</p>
 *
 * <p><b>处理流程</b>：</p>
 * <ol>
 *   <li>监听{@code RoleUpdatedEvent}事件</li>
 *   <li>查询关联该角色的所有用户ID</li>
 *   <li>通过{@code RoleHelper}批量更新用户Redis缓存</li>
 * </ol>
 *
 * <p><b>注意事项</b>：</p>
 * <ul>
 *   <li>使用异步处理（@{@link Async}）避免阻塞主线程</li>
 *   <li>仅处理直接关联的用户，不包含通过用户组等间接关联的情况</li>
 *   <li>更新操作采用批量处理提高效率</li>
 * </ul>
 */
@Component
public class RoleUpdateHandler {
    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private RoleHelper roleHelper;

    /**
     * 处理角色更新事件
     *
     * @param event 角色更新事件，包含变更的角色ID
     * @see RoleUpdatedEvent 角色更新事件定义
     * @see RoleHelper#updateUserRedisInfo 用户缓存更新方法
     */
    @Async
    @EventListener
    public void handleRoleUpdatedEvent(RoleUpdatedEvent event) {
        // 查询当前用户角色中角色id
        LambdaQueryWrapper<UserRole> lambdaQueryWrapper = Wrappers.<UserRole>lambdaQuery().eq(UserRole::getRoleId, event.getRoleId());

        // 批量查询关联用户ID
        List<UserRole> userRoles = userRoleMapper.selectList(lambdaQueryWrapper);
        List<Long> userIds = userRoles.stream().map(UserRole::getUserId).toList();
        roleHelper.updateUserRedisInfo(userIds);
    }
}