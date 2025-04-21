package cn.bunny.services.controller.configuration;

import cn.bunny.domain.menuIcon.dto.MenuIconAddDto;
import cn.bunny.domain.menuIcon.dto.MenuIconDto;
import cn.bunny.domain.menuIcon.dto.MenuIconUpdateDto;
import cn.bunny.domain.menuIcon.entity.MenuIcon;
import cn.bunny.domain.menuIcon.vo.MenuIconVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.configuration.MenuIconService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
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
@Tag(name = "系统菜单图标", description = "系统菜单图标相关接口")
@RestController
@RequestMapping("api/menuIcon")
public class MenuIconController {

    @Resource
    private MenuIconService menuIconService;

    @Operation(summary = "分页查询系统菜单图标", description = "分页查询系统菜单图标")
    @GetMapping("getMenuIconList/{page}/{limit}")
    public Result<PageResult<MenuIconVo>> getMenuIconList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MenuIconDto dto) {
        Page<MenuIcon> pageParams = new Page<>(page, limit);
        PageResult<MenuIconVo> pageResult = menuIconService.getMenuIconList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取查询图标名称列", description = "获取查询图标名称列")
    @GetMapping("noManage/getIconNameList")
    public Result<List<MenuIconVo>> getIconNameList(String iconName) {
        List<MenuIconVo> voList = menuIconService.getIconNameList(iconName);
        return Result.success(voList);
    }

    @Operation(summary = "添加系统菜单图标", description = "添加系统菜单图标")
    @PostMapping("addMenuIcon")
    public Result<String> addMenuIcon(@Valid @RequestBody MenuIconAddDto dto) {
        menuIconService.addMenuIcon(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新系统菜单图标", description = "更新系统菜单图标")
    @PutMapping("updateMenuIcon")
    public Result<String> updateMenuIcon(@Valid @RequestBody MenuIconUpdateDto dto) {
        menuIconService.updateMenuIcon(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除系统菜单图标", description = "删除系统菜单图标")
    @DeleteMapping("deleteMenuIcon")
    public Result<String> deleteMenuIcon(@RequestBody List<Long> ids) {
        menuIconService.deleteMenuIcon(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
