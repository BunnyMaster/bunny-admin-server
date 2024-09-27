package cn.bunny.services.controller;

import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.vo.router.UserRouterVo;
import cn.bunny.services.service.RouterService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public Result<List<UserRouterVo>> getRouterAsync() {
        List<UserRouterVo> voList = routerService.getRouterAsync();
        return Result.success(voList);
    }
}
