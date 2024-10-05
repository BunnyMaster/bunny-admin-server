package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.router.AssignRolesToRoutersDto;
import cn.bunny.dao.entity.system.RouterRole;
import cn.bunny.services.mapper.RouterRoleMapper;
import cn.bunny.services.service.RouterRoleService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
@Transactional
public class RouterRoleServiceImpl extends ServiceImpl<RouterRoleMapper, RouterRole> implements RouterRoleService {

    /**
     * * 根据路由id获取所有角色
     *
     * @param routerId 路由id
     * @return 角色列表
     */
    @Override
    public List<String> getRoleListByRouterId(Long routerId) {
        return list(Wrappers.<RouterRole>lambdaQuery().eq(RouterRole::getRouterId, routerId)).stream()
                .map(routerRole -> routerRole.getRoleId().toString()).toList();
    }

    /**
     * * 为菜单分配角色
     *
     * @param dto 路由分配角色
     */
    @Override
    public void assignRolesToRouter(AssignRolesToRoutersDto dto) {
        Long routerId = dto.getRouterId();
        List<Long> roleIds = dto.getRoleIds();

        // 删除这个用户下所有已经分配好的角色内容
        baseMapper.deleteBatchIdsWithPhysicsByRouterId(routerId);

        // 保存分配好的角色信息
        List<RouterRole> roleList = roleIds.stream().map(roleId -> {
            RouterRole routerRole = new RouterRole();
            routerRole.setRouterId(routerId);
            routerRole.setRoleId(roleId);
            return routerRole;
        }).toList();
        saveBatch(roleList);
    }
}
