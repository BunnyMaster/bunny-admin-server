package cn.bunny.services.controller.configuration;

import cn.bunny.services.domain.system.i18n.dto.I18nAddDto;
import cn.bunny.services.domain.system.i18n.dto.I18nDto;
import cn.bunny.services.domain.system.i18n.dto.I18nUpdateByFileDto;
import cn.bunny.services.domain.system.i18n.dto.I18nUpdateDto;
import cn.bunny.services.domain.system.i18n.entity.I18n;
import cn.bunny.services.domain.system.i18n.vo.I18nVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.service.configuration.I18nService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
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
@Tag(name = "i18n多语言", description = "i18n多语言相关接口")
@RestController
@RequestMapping("api/i18n")
public class I18nController {

    @Resource
    private I18nService i18nService;

    @Operation(summary = "分页查询", description = "分页查询多语言", tags = "i18n::query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<I18nVo>> getI18nPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            I18nDto dto) {
        Page<I18n> pageParams = new Page<>(page, limit);
        PageResult<I18nVo> vo = i18nService.getI18nPage(pageParams, dto);
        return Result.success(vo);
    }

    @Operation(summary = "更新", description = "更新多语言", tags = "i18n::update")
    @PutMapping()
    public Result<String> updateI18n(@Valid @RequestBody I18nUpdateDto dto) {
        i18nService.updateI18n(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "添加", description = "添加多语言", tags = "i18n::add")
    @PostMapping()
    public Result<String> addI18n(@Valid @RequestBody I18nAddDto dto) {
        i18nService.addI18n(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "删除", description = "删除多语言", tags = "i18n::delete")
    @DeleteMapping()
    public Result<String> deleteI18n(@RequestBody List<Long> ids) {
        i18nService.deleteI18n(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "获取多语言内容", description = "获取多语言内容", tags = "i18n::query")
    @GetMapping("public")
    public Result<Map<String, Object>> getI18nMap() {
        Map<String, Object> vo = i18nService.getI18nMap();
        return Result.success(vo);
    }

    @Operation(summary = "文件导出多语言", description = "文件导出并下载多语言", tags = "i18n::update")
    @GetMapping("file")
    public ResponseEntity<byte[]> downloadI18n(String type) {
        return i18nService.downloadI18n(type);
    }

    @Operation(summary = "文件导入多语言", description = "文件更新多语言可以是JSON、Excel", tags = "i18n::update")
    @PutMapping("file")
    public Result<String> uploadI18nFile(@Valid I18nUpdateByFileDto dto) {
        i18nService.uploadI18nFile(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
