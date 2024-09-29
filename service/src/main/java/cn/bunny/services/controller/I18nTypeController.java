package cn.bunny.services.controller;

import cn.bunny.dao.dto.i18n.I18nTypeAddDto;
import cn.bunny.dao.dto.i18n.I18nTypeUpdateDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.i18n.I18nTypeVo;
import cn.bunny.services.service.I18nTypeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 多语言类型表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Tag(name = "多语言类型", description = "多语言类型相关接口")
@RestController
@RequestMapping("admin/i18nType")
public class I18nTypeController {

    @Autowired
    private I18nTypeService i18nTypeService;

    @Operation(summary = "获取多语言类型", description = "获取多语言类型")
    @GetMapping("getI18nTypeList")
    public Mono<Result<List<I18nTypeVo>>> getI18nTypeList() {
        List<I18nTypeVo> voList = i18nTypeService.getI18nTypeList();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加多语言类型", description = "添加多语言类型")
    @PostMapping("addI18nType")
    public Mono<Result<String>> addI18nType(@RequestBody I18nTypeAddDto dto) {
        i18nTypeService.addI18nType(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新多语言类型", description = "更新多语言类型")
    @PostMapping("updateI18nType")
    public Mono<Result<String>> updateI18nType(@RequestBody I18nTypeUpdateDto dto) {
        i18nTypeService.updateI18nType(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除多语言类型", description = "删除多语言类型")
    @PostMapping("deleteI18nType")
    public Mono<Result<String>> deleteI18nType(@RequestBody List<Long> ids) {
        i18nTypeService.deleteI18nType(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
