package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.router.AssignRolesToRoutersDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.services.service.RouterRoleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

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
@RequestMapping("admin/routerRole")
public class RouterRoleController {

    @Autowired
    private RouterRoleService routerRoleService;

    @Operation(summary = "根据菜单id获取所有角色", description = "根据菜单id获取所有角色")
    @GetMapping("getRoleListByRouterId")
    public Mono<Result<List<String>>> getRoleListByRouterId(Long routerId) {
        List<String> roleListByRouterId = routerRoleService.getRoleListByRouterId(routerId);
        return Mono.just(Result.success(roleListByRouterId));
    }

    @Operation(summary = "为菜单分配角色", description = "为菜单分配角色")
    @PostMapping("assignRolesToRouter")
    public Mono<Result<String>> assignRolesToRouter(@RequestBody AssignRolesToRoutersDto dto) {
        routerRoleService.assignRolesToRouter(dto);
        return Mono.just(Result.success());
    }

    @Operation(summary = "清除选中菜单所有角色", description = "清除选中菜单所有角色")
    @DeleteMapping("clearAllRolesSelect")
    public Mono<Result<String>> clearAllRolesSelect(@RequestBody List<Long> routerIds) {
        routerRoleService.clearAllRolesSelect(routerIds);
        return Mono.just(Result.success());
    }
}
