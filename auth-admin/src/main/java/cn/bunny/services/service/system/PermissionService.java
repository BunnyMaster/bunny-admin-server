package cn.bunny.services.service.system;

import cn.bunny.domain.system.dto.power.PermissionAddDto;
import cn.bunny.domain.system.dto.power.PermissionDto;
import cn.bunny.domain.system.dto.power.PermissionUpdateBatchByParentIdDto;
import cn.bunny.domain.system.dto.power.PermissionUpdateDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PermissionVo;
import cn.bunny.domain.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 权限 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
public interface PermissionService extends IService<Permission> {

    /**
     * * 获取权限列表
     *
     * @return 权限返回列表
     */
    PageResult<PermissionVo> getPermissionPage(Page<Permission> pageParams, PermissionDto dto);

    /**
     * * 添加权限
     *
     * @param dto 添加表单
     */
    void addPermission(@Valid PermissionAddDto dto);

    /**
     * * 更新权限
     *
     * @param dto 更新表单
     */
    void updatePermission(@Valid PermissionUpdateDto dto);

    /**
     * * 删除|批量删除权限类型
     *
     * @param ids 删除id列表
     */
    void deletePermission(List<Long> ids);

    /**
     * * 获取所有权限
     *
     * @return 所有权限列表
     */
    List<PermissionVo> getPermissionList();

    /**
     * * 批量修改权限父级
     *
     * @param dto 批量修改权限表单
     */
    void updatePermissionListByParentId(PermissionUpdateBatchByParentIdDto dto);
}
