package cn.bunny.services.controller.system;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.services.aop.scanner.ControllerApiPermissionScanner;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.dto.power.PermissionAddDto;
import cn.bunny.services.domain.system.dto.power.PermissionDto;
import cn.bunny.services.domain.system.dto.power.PermissionUpdateBatchByParentIdDto;
import cn.bunny.services.domain.system.dto.power.PermissionUpdateDto;
import cn.bunny.services.domain.system.entity.Permission;
import cn.bunny.services.domain.system.vo.PermissionVo;
import cn.bunny.services.service.system.PermissionService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 * 权限 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Tag(name = "权限", description = "权限相关接口")
@PermissionTag(permission = "permission::all")
@RestController
@RequestMapping("api/permission")
public class PermissionController {

    @Resource
    private PermissionService permissionService;

    @Operation(summary = "分页查询权限", description = "分页查询权限")
    @PermissionTag(permission = "permission::page")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<PermissionVo>> getPermissionPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            PermissionDto dto) {
        Page<Permission> pageParams = new Page<>(page, limit);
        PageResult<PermissionVo> pageResult = permissionService.getPermissionPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加权限", description = "添加权限")
    @PermissionTag(permission = "permission::add")
    @PostMapping()
    public Result<String> addPermission(@Valid @RequestBody PermissionAddDto dto) {
        permissionService.addPermission(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新权限", description = "更新权限")
    @PermissionTag(permission = "permission::update")
    @PutMapping()
    public Result<String> updatePermission(@Valid @RequestBody PermissionUpdateDto dto) {
        permissionService.updatePermission(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除权限", description = "删除权限")
    @PermissionTag(permission = "permission::delete")
    @DeleteMapping()
    public Result<Object> deletePermission(@RequestBody List<Long> ids) {
        permissionService.deletePermission(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "导出权限", description = "导出权限为Excel")
    @PermissionTag(permission = "permission::update")
    @GetMapping("file/export")
    public ResponseEntity<byte[]> exportPermission(String type) {
        return permissionService.exportPermission(type);
    }

    @Operation(summary = "导入权限", description = "导入权限")
    @PermissionTag(permission = "permission::update")
    @PutMapping("file/import")
    public Result<String> importPermission(@RequestParam(value = "file") MultipartFile file, String type) {
        permissionService.importPermission(file, type);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "获取所有权限", description = "获取所有权限")
    @GetMapping("private/permissions")
    public Result<List<PermissionVo>> getPermissionList() {
        List<PermissionVo> voList = permissionService.getPermissionList();
        return Result.success(voList);
    }

    @Operation(summary = "获取系统API信息列表", description = "系统接口API信息列表")
    @GetMapping("private/system/apis")
    public Result<List<ScannerControllerInfoVo>> getSystemApiInfoList() {
        List<ScannerControllerInfoVo> list = ControllerApiPermissionScanner.scanControllerInfo();
        return Result.success(list);
    }

    @Operation(summary = "批量修改权限父级", description = "批量修改权限父级")
    @PermissionTag(permission = "permission::update")
    @PatchMapping("update/permissions/parent")
    public Result<String> updatePermissionListByParentId(@RequestBody @Valid PermissionUpdateBatchByParentIdDto dto) {
        permissionService.updatePermissionListByParentId(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "批量修改权", description = "批量修改权")
    @PermissionTag(permission = "permission::update")
    @PatchMapping("update/permissions/batch")
    public Result<String> updatePermissionBatch(@RequestBody List<PermissionUpdateDto> list) {
        permissionService.updatePermissionBatch(list);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
