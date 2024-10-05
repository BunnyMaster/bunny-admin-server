package cn.bunny.services.service;

import cn.bunny.dao.dto.system.rolePower.RoleAddDto;
import cn.bunny.dao.dto.system.rolePower.RoleDto;
import cn.bunny.dao.dto.system.rolePower.RoleUpdateDto;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.rolePower.RoleVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 角色 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
public interface RoleService extends IService<Role> {

    /**
     * * 获取角色列表
     *
     * @return 角色返回列表
     */
    PageResult<RoleVo> getRoleList(Page<Role> pageParams, RoleDto dto);

    /**
     * * 添加角色
     *
     * @param dto 添加表单
     */
    void addRole(@Valid RoleAddDto dto);

    /**
     * * 更新角色
     *
     * @param dto 更新表单
     */
    void updateRole(@Valid RoleUpdateDto dto);

    /**
     * * 删除|批量删除角色类型
     *
     * @param ids 删除id列表
     */
    void deleteRole(List<Long> ids);

    /**
     * * 获取所有角色
     *
     * @return 所有角色列表
     */
    List<RoleVo> getAllRoles();
}
