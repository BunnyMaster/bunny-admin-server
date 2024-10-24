package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.RolePower;
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
     * * 根据角色id列表获取权限内容
     *
     * @param roleIds 角色id列表
     * @return 已选择的权限列表
     */
    List<Power> selectPowerListByRoleIds(List<Long> roleIds);
}
