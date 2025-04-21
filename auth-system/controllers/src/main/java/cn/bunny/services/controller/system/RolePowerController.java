package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.AssignPowersToRoleDto;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.services.service.system.RolePowerService;
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
@Tag(name = "角色和权限", description = "角色和权限相关接口")
@RestController
@RequestMapping("api/rolePower")
public class RolePowerController {

    @Resource
    private RolePowerService rolePowerService;

    @Operation(summary = "根据角色id获取权限内容", description = "根据角色id获取权限内容")
    @GetMapping("noManage/getPowerListByRoleId")
    public Result<List<String>> getPowerListByRoleId(Long id) {
        List<String> voList = rolePowerService.getPowerListByRoleId(id);
        return Result.success(voList);
    }

    @Operation(summary = "为角色分配权限", description = "为角色分配权限")
    @PostMapping("assignPowersToRole")
    public Result<String> assignPowersToRole(@Valid @RequestBody AssignPowersToRoleDto dto) {
        rolePowerService.assignPowersToRole(dto);
        return Result.success();
    }
}
