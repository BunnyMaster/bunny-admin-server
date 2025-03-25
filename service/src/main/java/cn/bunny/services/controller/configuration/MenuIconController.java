package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.system.menuIcon.MenuIconAddDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconUpdateDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.MenuIconVo;
import cn.bunny.services.service.configuration.MenuIconService;
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
 * 系统菜单图标表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
@Tag(name = "系统菜单图标", description = "系统菜单图标相关接口")
@RestController
@RequestMapping("api/menuIcon")
public class MenuIconController {

    @Autowired
    private MenuIconService menuIconService;

    @Operation(summary = "分页查询系统菜单图标", description = "分页查询系统菜单图标")
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

    @Operation(summary = "获取查询图标名称列", description = "获取查询图标名称列")
    @GetMapping("noManage/getIconNameList")
    public Mono<Result<List<MenuIconVo>>> getIconNameList(String iconName) {
        List<MenuIconVo> voList = menuIconService.getIconNameList(iconName);
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加系统菜单图标", description = "添加系统菜单图标")
    @PostMapping("addMenuIcon")
    public Mono<Result<String>> addMenuIcon(@Valid @RequestBody MenuIconAddDto dto) {
        menuIconService.addMenuIcon(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新系统菜单图标", description = "更新系统菜单图标")
    @PutMapping("updateMenuIcon")
    public Mono<Result<String>> updateMenuIcon(@Valid @RequestBody MenuIconUpdateDto dto) {
        menuIconService.updateMenuIcon(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除系统菜单图标", description = "删除系统菜单图标")
    @DeleteMapping("deleteMenuIcon")
    public Mono<Result<String>> deleteMenuIcon(@RequestBody List<Long> ids) {
        menuIconService.deleteMenuIcon(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
