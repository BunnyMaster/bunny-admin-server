package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.RouterRole;
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
public interface RouterRoleMapper extends BaseMapper<RouterRole> {

    /**
     * 根据路由id删除所有角色和路由信息
     *
     * @param routerIds 路由id
     */
    void deleteBatchIdsByRouterIdsWithPhysics(List<Long> routerIds);

    /**
     * * 根据角色id列表删除角色和路由相关
     *
     * @param roleIds 角色id列表
     */
    void deleteBatchIdsByRoleIdsWithPhysics(List<Long> roleIds);
}
