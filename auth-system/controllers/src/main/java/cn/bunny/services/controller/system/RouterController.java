package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.router.RouterAddDto;
import cn.bunny.domain.system.dto.router.RouterUpdateDto;
import cn.bunny.domain.system.vo.router.RouterManageVo;
import cn.bunny.domain.system.vo.router.WebUserRouterVo;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
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
@Tag(name = "系统路由", description = "系统路由相关接口")
@RestController
@RequestMapping("api/router")
public class RouterController {

    @Resource
    private RouterService routerService;

    @Operation(summary = "获取用户菜单", description = "获取用户菜单")
    @GetMapping("noManage/routerAsync")
    public Result<List<WebUserRouterVo>> routerAsync() {
        List<WebUserRouterVo> voList = routerService.routerAsync();
        return Result.success(voList);
    }

    @Operation(summary = "查询管理菜单列表", description = "查询管理菜单列表")
    @GetMapping("menuList")
    public Result<List<RouterManageVo>> menuList() {
        List<RouterManageVo> voPageResult = routerService.menuList();
        return Result.success(voPageResult);
    }

    @Operation(summary = "添加路由菜单", description = "添加路由菜单")
    @PostMapping("addMenu")
    public Result<Object> addMenu(@Valid @RequestBody RouterAddDto dto) {
        routerService.addMenu(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新路由菜单", description = "更新路由菜单")
    @PutMapping("updateMenu")
    public Result<Object> updateMenu(@Valid @RequestBody RouterUpdateDto dto) {
        routerService.updateMenu(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除路由菜单", description = "删除路由菜单")
    @DeleteMapping("deletedMenuByIds")
    public Result<Object> deletedMenuByIds(@RequestBody List<Long> ids) {
        routerService.deletedMenuByIds(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
