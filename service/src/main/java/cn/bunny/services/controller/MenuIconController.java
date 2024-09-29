package cn.bunny.services.controller;

import cn.bunny.dao.dto.menuIcon.MenuIconDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.vo.menuIcon.MenuIconVo;
import cn.bunny.services.service.MenuIconService;
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

/**
 * <p>
 * 系统菜单图标 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Tag(name = "菜单Icon", description = "菜单Icon相关接口")
@RestController
@RequestMapping("admin/menuIcon")
public class MenuIconController {

    @Autowired
    private MenuIconService menuIconService;

    @Operation(summary = "获取菜单Icon", description = "获取菜单Icon")
    @GetMapping("getMenuIconList/{page}/{limit}")
    public Mono<Result<PageResult<MenuIconVo>>> getMenuIconList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MenuIconDto dto) {
        Page<MenuIcon> pageParams = new Page<>(page, limit);
        PageResult<MenuIconVo> pageResult = menuIconService.getMenuIconList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }
}
