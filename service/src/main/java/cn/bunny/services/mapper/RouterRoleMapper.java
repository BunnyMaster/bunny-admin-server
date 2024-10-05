package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.RouterRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

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
     * @param routerId 路由id
     */
    void deleteBatchIdsWithPhysicsByRouterId(Long routerId);
}
