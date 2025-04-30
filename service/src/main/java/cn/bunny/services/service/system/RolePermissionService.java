package cn.bunny.services.service.system;

import cn.bunny.services.domain.system.system.dto.AssignPowersToRoleDto;
import cn.bunny.services.domain.system.system.entity.RolePermission;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
public interface RolePermissionService extends IService<RolePermission> {

    /**
     * * 根据角色id获取权限内容
     *
     * @param id 角色id
     * @return 已选择的权限列表
     */
    List<String> getPermissionListByRoleId(Long id);

    /**
     * * 为角色分配权限
     *
     * @param powerIds 权限id
     */
    void addRolPermission(@Valid AssignPowersToRoleDto powerIds);
}
