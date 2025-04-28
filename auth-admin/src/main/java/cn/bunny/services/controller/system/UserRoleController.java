package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.user.AssignRolesToUsersDto;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.services.service.system.UserRoleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
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
@Tag(name = "系统用户和角色", description = "用户和角色相关接口")
@RestController
@RequestMapping("api/userRole")
public class UserRoleController {

    @Resource
    private UserRoleService userRoleService;

    @Operation(summary = "根据用户id获取角色列", description = "根据用户id获取角色列")
    @GetMapping("private/getRoleListByUserId")
    public Result<List<String>> getRoleListByUserId(Long userId) {
        List<String> roleVoList = userRoleService.getRoleListByUserId(userId);
        return Result.success(roleVoList);
    }

    @Operation(summary = "为用户分配角色", description = "为用户分配角色", tags = "user::add")
    @PostMapping()
    public Result<String> addUserRole(@RequestBody AssignRolesToUsersDto dto) {
        userRoleService.addUserRole(dto);
        return Result.success();
    }
}
