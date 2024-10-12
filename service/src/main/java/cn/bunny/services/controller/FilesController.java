package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.files.FilesAddDto;
import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.dto.system.files.FilesUpdateDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.files.FilesVo;
import cn.bunny.services.service.FilesService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 系统文件表表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Tag(name = "系统文件表", description = "系统文件表相关接口")
@RestController
@RequestMapping("admin/files")
public class FilesController {

    @Autowired
    private FilesService filesService;

    @Operation(summary = "分页查询系统文件表", description = "分页查询系统文件表")
    @GetMapping("getFilesList/{page}/{limit}")
    public Mono<Result<PageResult<FilesVo>>> getFilesList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            FilesDto dto) {
        Page<Files> pageParams = new Page<>(page, limit);
        PageResult<FilesVo> pageResult = filesService.getFilesList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "下载文件", description = "下载文件")
    @GetMapping("downloadFiles/{fileId}")
    public void downloadFiles(@PathVariable Long fileId, HttpServletResponse response) {
        filesService.downloadFiles(response, fileId);
    }

    @Operation(summary = "更新系统文件表", description = "更新系统文件表")
    @PutMapping("updateFiles")
    public Mono<Result<String>> updateFiles(@Valid @RequestBody FilesUpdateDto dto) {
        filesService.updateFiles(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "添加系统文件表", description = "添加系统文件表")
    @PostMapping("addFiles")
    public Mono<Result<String>> addFiles(@Valid @RequestBody FilesAddDto dto) {
        filesService.addFiles(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "上传文件", description = "上传文件")
    @PostMapping("upload")
    public Result<FileInfoVo> upload(FileUploadDto dto) {
        FileInfoVo vo = filesService.upload(dto);
        return Result.success(vo, ResultCodeEnum.SUCCESS_UPLOAD);
    }

    @Operation(summary = "删除系统文件表", description = "删除系统文件表")
    @DeleteMapping("deleteFiles")
    public Mono<Result<String>> deleteFiles(@RequestBody List<Long> ids) {
        filesService.deleteFiles(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
