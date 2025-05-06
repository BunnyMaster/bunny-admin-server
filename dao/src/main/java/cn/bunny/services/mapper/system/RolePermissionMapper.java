package cn.bunny.services.mapper.system;

import cn.bunny.services.domain.system.system.entity.RolePermission;
import cn.bunny.services.domain.system.system.views.ViewRolePermission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface RolePermissionMapper extends BaseMapper<RolePermission> {

    /**
     * * 根据权限id列表删除角色权限相关
     *
     * @param permissionIds 权限id列表
     */
    void deleteBatchPowerIds(List<Long> permissionIds);

    /**
     * * 根据角色id删除角色权限
     *
     * @param roleIds 角色
     */
    void deleteBatchRoleIds(List<Long> roleIds);

    /**
     * * 根据角色id获取权限内容
     *
     * @param roleId 角色id
     * @return 已选择的权限列表
     */
    List<RolePermission> selectRolePermissionListByRoleId(Long roleId);

    /**
     * 查看所有角色关联的权限
     *
     * @return 角色权限关系视图
     */
    List<ViewRolePermission> viewRolePowerWithAll();

    /**
     * 根据权限id列表查询角色和权限
     *
     * @param permissionIds 权限id列表
     * @return List<RolePermission>
     */
    List<RolePermission> selectRolePermissionListByPermissionIds(List<Long> permissionIds);
}
