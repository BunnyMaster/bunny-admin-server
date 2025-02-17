package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.user.AssignRolesToUsersDto;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.services.service.UserRoleService;
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
@Tag(name = "用户和角色", description = "用户和角色相关接口")
@RestController
@RequestMapping("api/userRole")
public class UserRoleController {

    @Autowired
    private UserRoleService userRoleService;

    @Operation(summary = "根据用户id获取角色列", description = "根据用户id获取角色列")
    @GetMapping("getRoleListByUserId")
    public Mono<Result<List<String>>> getRoleListByUserId(Long userId) {
        List<String> roleVoList = userRoleService.getRoleListByUserId(userId);
        return Mono.just(Result.success(roleVoList));
    }

    @Operation(summary = "为用户分配角色", description = "为用户分配角色")
    @PostMapping("assignRolesToUsers")
    public Mono<Result<String>> assignRolesToUsers(@RequestBody AssignRolesToUsersDto dto) {
        userRoleService.assignRolesToUsers(dto);
        return Mono.just(Result.success());
    }
}
