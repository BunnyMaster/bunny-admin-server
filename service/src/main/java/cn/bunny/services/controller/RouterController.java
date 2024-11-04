package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.router.RouterAddDto;
import cn.bunny.dao.dto.system.router.RouterManageDto;
import cn.bunny.dao.dto.system.router.RouterUpdateByIdWithRankDto;
import cn.bunny.dao.dto.system.router.RouterUpdateDto;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.router.RouterManageVo;
import cn.bunny.dao.vo.system.router.UserRouterVo;
import cn.bunny.services.service.RouterService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

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
@RequestMapping("admin/router")
public class RouterController {

    @Autowired
    private RouterService routerService;

    @Operation(summary = "获取用户菜单", description = "获取用户菜单")
    @GetMapping("noManage/getRouterAsync")
    public Mono<Result<List<UserRouterVo>>> getRouterAsync() {
        List<UserRouterVo> voList = routerService.getRouterAsync();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "分页管理菜单列", description = "分页管理菜单列")
    @GetMapping("getMenusList/{page}/{limit}")
    public Mono<Result<PageResult<RouterManageVo>>> getMenusByPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            RouterManageDto dto) {
        Page<Router> pageParams = new Page<>(page, limit);
        PageResult<RouterManageVo> voPageResult = routerService.getMenusByPage(pageParams, dto);

        return Mono.just(Result.success(voPageResult));
    }

    @Operation(summary = "分页查询管理菜单列表", description = "分页查询管理菜单列表")
    @GetMapping("getMenusList")
    public Mono<Result<List<RouterManageVo>>> getMenusList(RouterManageDto dto) {
        List<RouterManageVo> voPageResult = routerService.getMenusList(dto);

        return Mono.just(Result.success(voPageResult));
    }

    @Operation(summary = "添加路由菜单", description = "添加路由菜单")
    @PostMapping("addMenu")
    public Mono<Result<String>> addMenu(@Valid @RequestBody RouterAddDto dto) {
        routerService.addMenu(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新路由菜单", description = "更新路由菜单")
    @PutMapping("updateMenu")
    public Mono<Result<String>> updateMenu(@Valid @RequestBody RouterUpdateDto dto) {
        routerService.updateMenu(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "快速更新菜单排序", description = "快速更新菜单排序")
    @PutMapping("updateMenuByIdWithRank")
    public Mono<Result<String>> updateMenuByIdWithRank(@Valid @RequestBody RouterUpdateByIdWithRankDto dto) {
        routerService.updateMenuByIdWithRank(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除路由菜单", description = "删除路由菜单")
    @DeleteMapping("deletedMenuByIds")
    public Mono<Result<String>> deletedMenuByIds(@RequestBody List<Long> ids) {
        routerService.deletedMenuByIds(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
