package cn.bunny.services.controller.system;

import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.system.dto.router.RouterAddDto;
import cn.bunny.services.domain.system.system.dto.router.RouterUpdateDto;
import cn.bunny.services.domain.system.system.vo.router.RouterManageVo;
import cn.bunny.services.domain.system.system.vo.router.WebUserRouterVo;
import cn.bunny.services.service.system.RouterService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
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
@Tag(name = "路由菜单", description = "系统路由相关接口")
@RestController
@RequestMapping("api/router")
public class RouterController {

    @Resource
    private RouterService routerService;

    @Operation(summary = "获取用户菜单", description = "获取用户菜单", tags = "router::query")
    @GetMapping("private/routerAsync")
    public Result<List<WebUserRouterVo>> routerAsync() {
        List<WebUserRouterVo> voList = routerService.routerAsync();
        return Result.success(voList);
    }

    @Operation(summary = "查询管理路由菜单", description = "查询管理菜单列表", tags = "router::query")
    @GetMapping("routerList")
    public Result<List<RouterManageVo>> routerList() {
        List<RouterManageVo> voPageResult = routerService.routerList();
        return Result.success(voPageResult);
    }

    @Operation(summary = "添加路由菜单", description = "添加路由菜单", tags = "router::add")
    @PostMapping()
    public Result<String> addRouter(@Valid @RequestBody RouterAddDto dto) {
        routerService.addRouter(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新路由菜单", description = "更新路由菜单", tags = "router::update")
    @PutMapping()
    public Result<String> updateRouter(@Valid @RequestBody RouterUpdateDto dto) {
        routerService.updateRouter(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除路由菜单", description = "删除路由菜单", tags = "router::delete")
    @DeleteMapping()
    public Result<String> deletedRouterByIds(@RequestBody List<Long> ids) {
        routerService.deletedRouterByIds(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
