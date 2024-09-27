package cn.bunny.services.controller;

import cn.bunny.dao.dto.router.RouterManageDto;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.vo.router.RouterManageVo;
import cn.bunny.dao.vo.router.UserRouterVo;
import cn.bunny.services.service.RouterService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 系统菜单表 前端控制器
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
    @GetMapping("getRouterAsync")
    public Mono<Result<List<UserRouterVo>>> getRouterAsync() {
        List<UserRouterVo> voList = routerService.getRouterAsync();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "分页管理菜单列表", description = "分页管理菜单列表")
    @GetMapping("getMenusByPage/{page}/{limit}")
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

    @Operation(summary = "管理菜单列表", description = "管理菜单列表")
    @GetMapping("getMenus")
    public Mono<Result<List<RouterManageVo>>> getMenu(RouterManageDto dto) {
        List<RouterManageVo> voPageResult = routerService.getMenu(dto);

        return Mono.just(Result.success(voPageResult));
    }
}
