package cn.bunny.services.controller.configuration;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.services.domain.common.ValidationGroups;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.configuration.dto.MenuIconDto;
import cn.bunny.services.domain.configuration.entity.MenuIcon;
import cn.bunny.services.domain.configuration.vo.MenuIconVo;
import cn.bunny.services.service.configuration.MenuIconService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 系统菜单图标表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
@Tag(name = "菜单图标", description = "菜单图标相关接口")
@PermissionTag(permission = "menuIcon:*")
@RestController
@RequestMapping("api/menu-icon")
public class MenuIconController {

    @Resource
    private MenuIconService menuIconService;

    @Operation(summary = "分页查询菜单图标", description = "分页查询系统菜单图标")
    @PermissionTag(permission = "menuIcon:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<MenuIconVo>> getMenuIconPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MenuIconDto dto) {
        Page<MenuIcon> pageParams = new Page<>(page, limit);
        PageResult<MenuIconVo> pageResult = menuIconService.getMenuIconPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加菜单图标", description = "添加系统菜单图标")
    @PermissionTag(permission = "menuIcon:add")
    @PostMapping()
    public Result<String> createMenuIcon(@Validated(ValidationGroups.Add.class) @RequestBody MenuIconDto dto) {
        menuIconService.createMenuIcon(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新菜单图标", description = "更新系统菜单图标")
    @PermissionTag(permission = "menuIcon:update")
    @PutMapping()
    public Result<String> updateMenuIcon(@Validated(ValidationGroups.Update.class) @RequestBody MenuIconDto dto) {
        menuIconService.updateMenuIcon(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除菜单图标", description = "删除系统菜单图标")
    @PermissionTag(permission = "menuIcon:delete")
    @DeleteMapping()
    public Result<String> deleteMenuIcon(@RequestBody List<Long> ids) {
        menuIconService.deleteMenuIcon(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "搜索图标", description = "根据名称搜索图标")
    @GetMapping("public")
    public Result<List<MenuIconVo>> getIconNameListByIconName(String iconName) {
        List<MenuIconVo> voList = menuIconService.getIconNameListByIconName(iconName);
        return Result.success(voList);
    }
}
