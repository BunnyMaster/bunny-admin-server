package cn.bunny.services.controller.system;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.model.system.dto.RoleDto;
import cn.bunny.domain.model.system.entity.Role;
import cn.bunny.domain.model.system.vo.RoleVo;
import cn.bunny.services.service.system.RoleService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 * 角色 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Tag(name = "角色", description = "角色相关接口")
@PermissionTag(permission = "role:*")
@RestController
@RequestMapping("api/role")
public class RoleController {

    @Resource
    private RoleService roleService;

    @Operation(summary = "分页查询角色", description = "分页查询角色")
    @PermissionTag(permission = "role:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<RoleVo>> getRolePage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            RoleDto dto) {
        Page<Role> pageParams = new Page<>(page, limit);
        PageResult<RoleVo> pageResult = roleService.getRolePage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加角色", description = "添加角色")
    @PermissionTag(permission = "role:add")
    @PostMapping()
    public Result<Object> addRole(@Validated(ValidationGroups.Add.class) @RequestBody RoleDto dto) {
        roleService.addRole(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新角色", description = "更新角色")
    @PermissionTag(permission = "role:update")
    @PutMapping()
    public Result<Object> updateRole(@Validated(ValidationGroups.Update.class) @RequestBody RoleDto dto) {
        roleService.updateRole(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除角色", description = "删除角色")
    @PermissionTag(permission = "role:delete")
    @DeleteMapping()
    public Result<Object> deleteRole(@RequestBody List<Long> ids) {
        roleService.deleteRole(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "获取所有角色", description = "获取所有角色")
    @GetMapping("private/roleList")
    public Result<List<RoleVo>> roleList() {
        List<RoleVo> roleVoList = roleService.roleList();
        return Result.success(roleVoList);
    }

    @Operation(summary = "导出角色列表", description = "使用Excel导出导出角色列表")
    @PermissionTag(permission = "role:update")
    @GetMapping("file/export")
    public ResponseEntity<byte[]> exportByExcel() {
        return roleService.exportByExcel();
    }

    @Operation(summary = "更新角色列表", description = "使用Excel更新角色列表")
    @PermissionTag(permission = "role:update")
    @PutMapping("file/import")
    public Result<String> updateRoleByFile(MultipartFile file) {
        roleService.updateRoleByFile(file);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
