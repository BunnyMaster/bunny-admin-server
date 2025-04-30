package cn.bunny.services.controller.system;

import cn.bunny.services.domain.system.system.dto.AssignPowersToRoleDto;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.service.system.RolePermissionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Tag(name = "系统角色和权限", description = "角色和权限相关接口")
@RestController
@RequestMapping("api/rolePermission")
public class RolePermissionController {

    @Resource
    private RolePermissionService rolePermissionService;

    @Operation(summary = "根据角色id获取权限内容", description = "根据角色id获取权限内容", tags = "rolePermission::query")
    @GetMapping("private/getPermissionListByRoleId")
    public Result<List<String>> getPermissionListByRoleId(Long id) {
        List<String> voList = rolePermissionService.getPermissionListByRoleId(id);
        return Result.success(voList);
    }

    @Operation(summary = "为角色分配权限", description = "为角色分配权限", tags = "rolePermission::update")
    @PostMapping()
    public Result<String> addRolPermission(@Valid @RequestBody AssignPowersToRoleDto dto) {
        rolePermissionService.addRolPermission(dto);
        return Result.success();
    }
}
