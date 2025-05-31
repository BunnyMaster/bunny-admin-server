package cn.bunny.services.mapper.system;

import cn.bunny.domain.model.system.entity.RouterRole;
import cn.bunny.domain.model.system.views.ViewRouterRole;
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
     * 查看所有路由关联角色
     *
     * @return 路由角色关系视图列表
     */
    List<ViewRouterRole> selectRouterRoleList();

    /**
     * 根据【路由id】删除所有角色和路由信息
     *
     * @param ids 路由id
     */
    void deleteBatchIdsByRouterIds(List<Long> ids);

    /**
     * * 根据【角色id】列表删除角色和路由相关
     *
     * @param roleIds 角色id列表
     */
    void deleteBatchIdsByRoleIds(List<Long> roleIds);

}

