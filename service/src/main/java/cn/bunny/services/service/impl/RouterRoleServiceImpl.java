package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.dto.system.router.AssignRolesToRoutersDto;
import cn.bunny.dao.entity.system.RouterRole;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.services.mapper.RouterRoleMapper;
import cn.bunny.services.service.RouterRoleService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
        List<Long> routerIds = dto.getRouterIds();
        List<Long> roleIds = dto.getRoleIds();

        // 删除这个路由下所有已经分配好的角色内容
        baseMapper.deleteBatchIdsByRouterIdsWithPhysics(routerIds);

        // 保存分配好的角色信息
        List<RouterRole> roleList = new ArrayList<>();
        for (Long roleId : roleIds) {
            List<RouterRole> list = routerIds.stream().map(routerId -> {
                RouterRole routerRole = new RouterRole();
                routerRole.setRouterId(routerId);
                routerRole.setRoleId(roleId);
                return routerRole;
            }).toList();

            roleList.addAll(list);
        }

        saveBatch(roleList);
    }

    /**
     * 清除选中菜单所有角色
     *
     * @param routerIds 路由id
     */
    @Override
    public void clearAllRolesSelect(List<Long> routerIds) {
        if (routerIds.isEmpty()) {
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }
        baseMapper.deleteBatchIdsByRouterIdsWithPhysics(routerIds);
    }

    /**
     * 批量为菜单添加角色
     * 查询所有满足角色id列表的路由
     * 将满足条件的路由提取出routerId列表
     * 并删除所有routerIds
     *
     * @param dto 路由分配角色
     */
    @Override
    public void assignAddBatchRolesToRouter(AssignRolesToRoutersDto dto) {
        // 查询所有满足角色id和路由Id相关
        LambdaQueryWrapper<RouterRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(RouterRole::getRoleId, dto.getRoleIds())
                .and(qw -> qw.in(RouterRole::getRouterId, dto.getRouterIds()));
        List<RouterRole> routerRoleList = list(wrapper);

        // 根据Id列表物理删除路由角色关系表
        List<Long> ids = routerRoleList.stream().map(RouterRole::getId).toList();
        if (!ids.isEmpty()) {
            baseMapper.deleteBatchIdsWithPhysics(ids);
        }

        // 保存分配好的角色信息
        List<RouterRole> roleList = new ArrayList<>();
        for (Long roleId : dto.getRoleIds()) {
            List<RouterRole> list = dto.getRouterIds().stream().map(routerId -> {
                RouterRole routerRole = new RouterRole();
                routerRole.setRouterId(routerId);
                routerRole.setRoleId(roleId);
                return routerRole;
            }).toList();

            roleList.addAll(list);
        }

        saveBatch(roleList);
    }
}
