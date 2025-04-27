package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.power.PermissionAddDto;
import cn.bunny.domain.system.dto.power.PermissionDto;
import cn.bunny.domain.system.dto.power.PermissionUpdateBatchByParentIdDto;
import cn.bunny.domain.system.dto.power.PermissionUpdateDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PermissionVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
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
@Tag(name = "系统权限", description = "权限相关接口")
@RestController
@RequestMapping("api/permission")
public class PermissionController {

    @Resource
    private PermissionService permissionService;

    @Operation(summary = "分页查询", description = "分页查询权限")
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

    @Operation(summary = "添加", description = "添加权限")
    @PostMapping()
    public Result<String> addPermission(@Valid @RequestBody PermissionAddDto dto) {
        permissionService.addPermission(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新", description = "更新权限")
    @PutMapping()
    public Result<String> updatePermission(@Valid @RequestBody PermissionUpdateDto dto) {
        permissionService.updatePermission(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除", description = "删除权限")
    @DeleteMapping()
    public Result<Object> deletePermission(@RequestBody List<Long> ids) {
        permissionService.deletePermission(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "导出权限", description = "导出权限为Excel")
    @GetMapping("file/export")
    public ResponseEntity<byte[]> exportPermission() {
        return permissionService.exportPermission();
    }

    @Operation(summary = "导入权限", description = "导入权限")
    @PutMapping("file/import")
    public Result<String> importPermission(@RequestParam(value = "file") MultipartFile file) {
        permissionService.importPermission(file);
        return Result.success(ResultCodeEnum.SUCCESS);
    }

    @Operation(summary = "获取所有权限", description = "获取所有权限")
    @GetMapping("getPermissionList")
    public Result<List<PermissionVo>> getPermissionList() {
        List<PermissionVo> voList = permissionService.getPermissionList();
        return Result.success(voList);
    }

    @Operation(summary = "批量修改权限父级", description = "批量修改权限父级")
    @PutMapping("update/permissionListByParentId")
    public Result<String> updatePermissionListByParentId(@RequestBody @Valid PermissionUpdateBatchByParentIdDto dto) {
        permissionService.updatePermissionListByParentId(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
