package cn.bunny.api.controller.system;

import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.system.dto.RouterDto;
import cn.bunny.domain.system.vo.router.RouterManageVo;
import cn.bunny.domain.system.vo.router.WebUserRouterVo;
import cn.bunny.system.service.RouterService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 系统菜单 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Tag(name = "路由菜单" , description = "系统路由相关接口" )
@PermissionTag(permission = "router:*" )
@RestController
@RequestMapping("api/router" )
public class RouterController {

    @Resource
    private RouterService routerService;

    @Operation(summary = "获取用户菜单" , description = "获取用户菜单" )
    @PermissionTag(permission = "router:query" )
    @GetMapping("private/router-async" )
    public Result<List<WebUserRouterVo>> routerAsync() {
        List<WebUserRouterVo> voList = routerService.routerAsync();
        return Result.success(voList);
    }

    @Operation(summary = "查询管理路由菜单" , description = "查询管理菜单列表" )
    @PermissionTag(permission = "router:query" )
    @GetMapping("routers" )
    public Result<List<RouterManageVo>> routerList() {
        List<RouterManageVo> voPageResult = routerService.routerList();
        return Result.success(voPageResult);
    }

    @Operation(summary = "添加路由菜单" , description = "添加路由菜单" )
    @PermissionTag(permission = "router:add" )
    @PostMapping()
    public Result<String> createRouter(@Validated({ValidationGroups.Add.class}) @RequestBody RouterDto dto) {
        routerService.createRouter(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新路由菜单" , description = "更新路由菜单" )
    @PermissionTag(permission = "router:update" )
    @PutMapping()
    public Result<String> updateRouter(@Validated({ValidationGroups.Update.class}) @RequestBody RouterDto dto) {
        routerService.updateRouter(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除路由菜单" , description = "删除路由菜单" )
    @PermissionTag(permission = "router:delete" )
    @DeleteMapping()
    public Result<String> deletedRouterByIds(@RequestBody List<Long> ids) {
        routerService.deletedRouterByIds(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
