package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.rolePower.role.RoleAddDto;
import cn.bunny.dao.dto.system.rolePower.role.RoleDto;
import cn.bunny.dao.dto.system.rolePower.role.RoleUpdateDto;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.rolePower.RoleVo;
import cn.bunny.services.service.RoleService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

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
@RestController
@RequestMapping("api/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Operation(summary = "分页查询角色", description = "分页查询角色")
    @GetMapping("getRoleList/{page}/{limit}")
    public Mono<Result<PageResult<RoleVo>>> getRoleList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            RoleDto dto) {
        Page<Role> pageParams = new Page<>(page, limit);
        PageResult<RoleVo> pageResult = roleService.getRoleList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有角色", description = "获取所有角色")
    @GetMapping("noManage/getAllRoles")
    public Mono<Result<List<RoleVo>>> getAllRoles() {
        List<RoleVo> roleVoList = roleService.getAllRoles();
        return Mono.just(Result.success(roleVoList));
    }

    @Operation(summary = "添加角色", description = "添加角色")
    @PostMapping("addRole")
    public Mono<Result<String>> addRole(@Valid @RequestBody RoleAddDto dto) {
        roleService.addRole(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新角色", description = "更新角色")
    @PutMapping("updateRole")
    public Mono<Result<String>> updateRole(@Valid @RequestBody RoleUpdateDto dto) {
        roleService.updateRole(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除角色", description = "删除角色")
    @DeleteMapping("deleteRole")
    public Mono<Result<String>> deleteRole(@RequestBody List<Long> ids) {
        roleService.deleteRole(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
