package cn.bunny.services.mapper.system;

import cn.bunny.dao.entity.system.RolePower;
import cn.bunny.dao.views.ViewRolePower;
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
public interface RolePowerMapper extends BaseMapper<RolePower> {

    /**
     * * 根据权限id列表删除角色权限相关
     *
     * @param powerIds 权限id列表
     */
    void deleteBatchPowerIdsWithPhysics(List<Long> powerIds);

    /**
     * * 根据角色id删除角色权限
     *
     * @param roleIds 角色
     */
    void deleteBatchRoleIdsWithPhysics(List<Long> roleIds);

    /**
     * * 根据角色id获取权限内容
     *
     * @param roleId 角色id
     * @return 已选择的权限列表
     */
    List<RolePower> selectPowerListByRoleId(Long roleId);

    /**
     * 查看所有角色关联的权限
     *
     * @return 角色权限关系视图
     */
    List<ViewRolePower> viewRolePowerWithAll();
}
