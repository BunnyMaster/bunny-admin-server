package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.router.AssignRolesToRoutersDto;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.services.service.system.RouterRoleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
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
@Tag(name = "路由和角色", description = "路由和角色相关接口")
@RestController
@RequestMapping("api/routerRole")
public class RouterRoleController {

    @Autowired
    private RouterRoleService routerRoleService;

    @Operation(summary = "根据菜单id获取所有角色", description = "根据菜单id获取所有角色")
    @GetMapping("getRoleListByRouterId")
    public Result<List<String>> getRoleListByRouterId(Long routerId) {
        List<String> roleListByRouterId = routerRoleService.getRoleListByRouterId(routerId);
        return Result.success(roleListByRouterId);
    }

    @Operation(summary = "为菜单分配角色", description = "为菜单分配角色")
    @PostMapping("assignRolesToRouter")
    public Result<String> assignRolesToRouter(@RequestBody AssignRolesToRoutersDto dto) {
        routerRoleService.assignRolesToRouter(dto);
        return Result.success();
    }

    @Operation(summary = "批量为菜单添加角色", description = "批量为菜单添加角色")
    @PostMapping("assignAddBatchRolesToRouter")
    public Result<String> assignAddBatchRolesToRouter(@RequestBody AssignRolesToRoutersDto dto) {
        routerRoleService.assignAddBatchRolesToRouter(dto);
        return Result.success();
    }

    @Operation(summary = "清除选中菜单所有角色", description = "清除选中菜单所有角色")
    @DeleteMapping("clearAllRolesSelect")
    public Result<String> clearAllRolesSelect(@RequestBody List<Long> routerIds) {
        routerRoleService.clearAllRolesSelect(routerIds);
        return Result.success();
    }
}
