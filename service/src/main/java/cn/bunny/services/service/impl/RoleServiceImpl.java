package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.rolePower.RoleAddDto;
import cn.bunny.dao.dto.system.rolePower.RoleDto;
import cn.bunny.dao.dto.system.rolePower.RoleUpdateDto;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.rolePower.RoleVo;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.service.RoleService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    /**
     * * 角色 服务实现类
     *
     * @param pageParams 角色分页查询page对象
     * @param dto        角色分页查询对象
     * @return 查询分页角色返回对象
     */
    @Override
    public PageResult<RoleVo> getRoleList(Page<Role> pageParams, RoleDto dto) {
        // 分页查询菜单图标
        IPage<Role> page = baseMapper.selectListByPage(pageParams, dto);

        List<RoleVo> voList = page.getRecords().stream().map(Role -> {
            RoleVo RoleVo = new RoleVo();
            BeanUtils.copyProperties(Role, RoleVo);
            return RoleVo;
        }).toList();

        return PageResult.<RoleVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加角色
     *
     * @param dto 角色添加
     */
    @Override
    public void addRole(@Valid RoleAddDto dto) {
        // 保存数据
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        save(role);
    }

    /**
     * 更新角色
     *
     * @param dto 角色更新
     */
    @Override
    public void updateRole(@Valid RoleUpdateDto dto) {
        // 更新内容
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        updateById(role);
    }

    /**
     * 删除|批量删除角色
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteRole(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 获取所有角色
     *
     * @return 所有角色列表
     */
    @Override
    public List<RoleVo> getAllRoles() {
        return list().stream().map(role -> {
            RoleVo roleVo = new RoleVo();
            BeanUtils.copyProperties(role, roleVo);
            return roleVo;
        }).toList();
    }
}
