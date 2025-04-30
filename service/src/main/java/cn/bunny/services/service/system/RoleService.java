package cn.bunny.services.service.system;

import cn.bunny.services.domain.system.system.dto.role.RoleAddDto;
import cn.bunny.services.domain.system.system.dto.role.RoleDto;
import cn.bunny.services.domain.system.system.dto.role.RoleUpdateDto;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.domain.system.system.vo.RoleVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

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
    PageResult<RoleVo> getRolePage(Page<Role> pageParams, RoleDto dto);

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
    List<RoleVo> roleList();

    /**
     * 使用Excel导出导出角色列表
     *
     * @return Excel
     */
    ResponseEntity<byte[]> exportByExcel();

    /**
     * 使用Excel更新角色列表
     *
     * @param file Excel文件
     */
    void updateRoleByFile(MultipartFile file);
}
