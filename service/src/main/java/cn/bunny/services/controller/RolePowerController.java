package cn.bunny.services.controller;

import cn.bunny.dao.pojo.result.Result;
import cn.bunny.services.service.RolePowerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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

    @Operation(summary = "根据角色id获取权限内容", description = "角色列表获取已选择的权限")
    @GetMapping("getPowerListByRoleId")
    public Mono<Result<List<String>>> getPowerListByRoleId(Long id) {
        List<String> voList = rolePowerService.getPowerListByRoleId(id);
        return Mono.just(Result.success(voList));
    }
}
