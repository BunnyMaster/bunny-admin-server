package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.role.RoleAddDto;
import cn.bunny.domain.system.dto.role.RoleDto;
import cn.bunny.domain.system.dto.role.RoleUpdateDto;
import cn.bunny.domain.system.entity.Role;
import cn.bunny.domain.system.vo.RoleVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.system.RoleService;
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
 * 角色 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Tag(name = "系统角色", description = "角色相关接口")
@RestController
@RequestMapping("api/role")
public class RoleController {

    @Resource
    private RoleService roleService;

    @Operation(summary = "分页查询角色", description = "分页查询角色")
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

    @Operation(summary = "添加", description = "添加角色")
    @PostMapping()
    public Result<Object> addRole(@Valid @RequestBody RoleAddDto dto) {
        roleService.addRole(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新", description = "更新角色")
    @PutMapping()
    public Result<Object> updateRole(@Valid @RequestBody RoleUpdateDto dto) {
        roleService.updateRole(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除", description = "删除角色")
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
    @GetMapping("file/export")
    public ResponseEntity<byte[]> exportByExcel() {
        return roleService.exportByExcel();
    }

    @Operation(summary = "更新角色列表", description = "使用Excel更新角色列表")
    @PutMapping("file/import")
    public Result<String> updateRoleByFile(MultipartFile file) {
        roleService.updateRoleByFile(file);
        return Result.success();
    }
}
