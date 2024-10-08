package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.rolePower.AssignPowersToRoleDto;
import cn.bunny.dao.entity.system.RolePower;
import cn.bunny.services.mapper.RolePowerMapper;
import cn.bunny.services.service.RolePowerService;
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
public class RolePowerServiceImpl extends ServiceImpl<RolePowerMapper, RolePower> implements RolePowerService {

    /**
     * * 根据角色id获取权限内容
     *
     * @param id 角色id
     * @return 已选择的权限列表
     */
    @Override
    public List<String> getPowerListByRoleId(Long id) {
        List<RolePower> rolePowerList = baseMapper.selectPowerListByRoleId(id);
        return rolePowerList.stream().map(rolePower -> rolePower.getPowerId().toString()).toList();
    }

    /**
     * * 为角色分配权限
     *
     * @param dto 为角色分配权限表单
     */
    @Override
    public void assignPowersToRole(AssignPowersToRoleDto dto) {
        List<Long> powerIds = dto.getPowerIds();
        Long roleId = dto.getRoleId();

        // 删除所有权限
        baseMapper.deleteBatchPowerIdsWithPhysics(powerIds);

        // 保存分配数据
        List<RolePower> rolePowerList = powerIds.stream().map(powerId -> {
            RolePower rolePower = new RolePower();
            rolePower.setRoleId(roleId);
            rolePower.setPowerId(powerId);
            return rolePower;
        }).toList();

        saveBatch(rolePowerList);
    }
}
