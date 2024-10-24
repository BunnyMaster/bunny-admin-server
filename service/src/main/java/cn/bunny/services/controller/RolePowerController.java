package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.rolePower.AssignPowersToRoleDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.services.service.RolePowerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
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
@Tag(name = "角色和权限", description = "角色和权限相关接口")
@RestController
@RequestMapping("admin/rolePower")
public class RolePowerController {

    @Autowired
    private RolePowerService rolePowerService;

    @Operation(summary = "根据角色id获取权限内容", description = "根据角色id获取权限内容")
    @GetMapping("noManage/getPowerListByRoleId")
    public Mono<Result<List<String>>> getPowerListByRoleId(Long id) {
        List<String> voList = rolePowerService.getPowerListByRoleId(id);
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "为角色分配权限", description = "为角色分配权限")
    @PostMapping("assignPowersToRole")
    public Result<String> assignPowersToRole(@Valid @RequestBody AssignPowersToRoleDto dto) {
        rolePowerService.assignPowersToRole(dto);
        return Result.success();
    }
}
