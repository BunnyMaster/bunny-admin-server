package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.i18n.I18nAddDto;
import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.dto.i18n.I18nUpdateDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.vo.i18n.I18nVo;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.configuration.I18nService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 多语言 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Tag(name = "多语言", description = "多语言相关接口")
@RestController
@RequestMapping("api/i18n")
public class I18nController {

    @Autowired
    private I18nService i18nService;

    @Operation(summary = "获取多语言内容", description = "获取多语言内容")
    @GetMapping("getI18n")
    public Result<Map<String, Object>> getI18n() {
        Map<String, Object> vo = i18nService.getI18n();
        return Result.success(vo);
    }

    @Operation(summary = "获取管理多语言列", description = "获取管理多语言列")
    @GetMapping("getI18nList/{page}/{limit}")
    public Result<PageResult<I18nVo>> getI18nList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            I18nDto dto) {
        Page<I18n> pageParams = new Page<>(page, limit);
        PageResult<I18nVo> vo = i18nService.getI18nList(pageParams, dto);
        return Result.success(vo);
    }

    @Operation(summary = "下载多语言配置", description = "下载多语言配置")
    @GetMapping("downloadI18n")
    public ResponseEntity<byte[]> downloadI18n() {
        return i18nService.downloadI18n();
    }

    @Operation(summary = "添加多语言", description = "添加多语言")
    @PostMapping("addI18n")
    public Result<Object> addI18n(@Valid @RequestBody I18nAddDto dto) {
        i18nService.addI18n(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新多语言", description = "更新多语言")
    @PutMapping("updateI18n")
    public Result<Object> updateI18n(@Valid @RequestBody I18nUpdateDto dto) {
        i18nService.updateI18n(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除多语言", description = "删除多语言")
    @DeleteMapping("deleteI18n")
    public Result<Object> deleteI18n(@RequestBody List<Long> ids) {
        i18nService.deleteI18n(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
