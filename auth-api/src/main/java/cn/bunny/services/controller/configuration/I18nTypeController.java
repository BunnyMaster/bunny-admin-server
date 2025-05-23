package cn.bunny.services.controller.configuration;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.i18n.dto.I18nTypeAddDto;
import cn.bunny.services.domain.system.i18n.dto.I18nTypeDto;
import cn.bunny.services.domain.system.i18n.dto.I18nTypeUpdateDto;
import cn.bunny.services.domain.system.i18n.vo.I18nTypeVo;
import cn.bunny.services.service.configuration.I18nTypeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 多语言类型 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Tag(name = "多语言类型", description = "多语言类型相关接口")
@PermissionTag(permission = "i18n:*")
@RestController
@RequestMapping("api/i18n-type")
public class I18nTypeController {

    @Resource
    private I18nTypeService i18nTypeService;

    @Operation(summary = "添加多语言类型", description = "添加多语言类型")
    @PermissionTag(permission = "i18n:query")
    @PostMapping()
    public Result<String> addI18nType(@Valid @RequestBody I18nTypeAddDto dto) {
        i18nTypeService.addI18nType(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新多语言类型", description = "更新多语言类型")
    @PermissionTag(permission = "i18n:update")
    @PutMapping()
    public Result<String> updateI18nType(@Valid @RequestBody I18nTypeUpdateDto dto) {
        i18nTypeService.updateI18nType(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除多语言类型", description = "删除多语言类型")
    @PermissionTag(permission = "i18n:delete")
    @DeleteMapping()
    public Result<String> deleteI18nType(@RequestBody List<Long> ids) {
        i18nTypeService.deleteI18nType(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "全部多语言类型列表", description = "获取全部多语言类型列表")
    @GetMapping("/public")
    public Result<List<I18nTypeVo>> getI18nTypeList(I18nTypeDto dto) {
        List<I18nTypeVo> voList = i18nTypeService.getI18nTypeList(dto);
        return Result.success(voList);
    }
}
