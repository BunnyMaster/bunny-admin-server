package cn.bunny.services.service.system;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.dto.PermissionDto;
import cn.bunny.services.domain.system.dto.PermissionUpdateBatchByParentIdDto;
import cn.bunny.services.domain.system.entity.Permission;
import cn.bunny.services.domain.system.vo.PermissionVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
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
    void createPermission(PermissionDto dto);

    /**
     * * 更新权限
     *
     * @param dto 更新表单
     */
    void updatePermission(PermissionDto dto);

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

    /**
     * 批量修改权限
     *
     * @param list 权限数组
     */
    void updatePermissionBatch(List<PermissionDto> list);
}
