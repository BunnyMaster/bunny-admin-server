package cn.bunny.services.service.system;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.system.dto.power.PermissionAddDto;
import cn.bunny.services.domain.system.system.dto.power.PermissionDto;
import cn.bunny.services.domain.system.system.dto.power.PermissionUpdateBatchByParentIdDto;
import cn.bunny.services.domain.system.system.dto.power.PermissionUpdateDto;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.domain.system.system.vo.PermissionVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

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

    /**
     * 导出权限为Excel
     *
     * @param type 导出类型
     * @return Excel 文件
     */
    ResponseEntity<byte[]> exportPermission(String type);

    /**
     * 导入权限
     *
     * @param file 导入的Excel
     * @param type 导出类型
     */
    void importPermission(MultipartFile file, String type);
}
