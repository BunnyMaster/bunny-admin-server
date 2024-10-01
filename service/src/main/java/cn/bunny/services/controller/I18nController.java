package cn.bunny.services.controller;

import cn.bunny.dao.dto.i18n.I18nAddDto;
import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.dto.i18n.I18nUpdateDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.i18n.I18nVo;
import cn.bunny.services.service.I18nService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 多语言表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Tag(name = "多语言", description = "多语言相关接口")
@RestController
@RequestMapping("admin/i18n")
public class I18nController {

    @Autowired
    private I18nService i18nService;

    @Operation(summary = "获取多语言内容", description = "获取多语言内容")
    @GetMapping("getI18n")
    public Mono<Result<Map<String, Object>>> getI18n() {
        Map<String, Object> vo = i18nService.getI18n();
        return Mono.just(Result.success(vo));
    }

    @Operation(summary = "获取管理多语言列表", description = "获取管理多语言列表")
    @GetMapping("getI18nList/{page}/{limit}")
    public Mono<Result<PageResult<I18nVo>>> getI18nList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            I18nDto dto) {
        Page<I18n> pageParams = new Page<>(page, limit);
        PageResult<I18nVo> vo = i18nService.getI18nList(pageParams, dto);
        return Mono.just(Result.success(vo));
    }

    @Operation(summary = "添加多语言", description = "添加多语言")
    @PostMapping("addI18n")
    public Mono<Result<String>> addI18n(@Valid @RequestBody I18nAddDto dto) {
        i18nService.addI18n(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新多语言", description = "更新多语言")
    @PutMapping("updateI18n")
    public Mono<Result<String>> updateI18n(@Valid @RequestBody I18nUpdateDto dto) {
        i18nService.updateI18n(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除多语言类型", description = "删除多语言类型")
    @DeleteMapping("deleteI18n")
    public Mono<Result<String>> deleteI18n(@RequestBody List<Long> ids) {
        i18nService.deleteI18n(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
