package cn.bunny.services.controller.system;

import cn.bunny.dao.constant.MinioConstant;
import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.files.FilesAddDto;
import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.dto.system.files.FilesUpdateDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.files.FilesVo;
import cn.bunny.services.service.system.FilesService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>
 * 系统文件表表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Tag(name = "系统文件表", description = "系统文件相关接口")
@RestController
@RequestMapping("api/files")
public class FilesController {

    @Autowired
    private FilesService filesService;

    @Operation(summary = "分页查询系统文件", description = "分页查询系统文件")
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
    @GetMapping("downloadFilesByFileId/{fileId}")
    public ResponseEntity<byte[]> downloadFilesByFileId(@PathVariable Long fileId) {
        return filesService.downloadFilesByFileId(fileId);
    }

    @Operation(summary = "获取所有文件类型", description = "获取所有文件类型")
    @GetMapping("noManage/getAllMediaTypes")
    public Mono<Result<Set<String>>> getAllMediaTypes() {
        Set<String> list = filesService.getAllMediaTypes();
        return Mono.just(Result.success(list));
    }

    @Operation(summary = "获取所有文件存储基础路径", description = "获取所有文件存储基础路径")
    @GetMapping("noManage/getAllFilesStoragePath")
    public Mono<Result<List<String>>> getAllFilesStoragePath() {
        Map<String, String> typeMap = MinioConstant.typeMap;
        List<String> list = typeMap.keySet().stream().toList();

        return Mono.just(Result.success(list));
    }

    @Operation(summary = "根据文件名下载文件", description = "根据文件名下载文件")
    @GetMapping("downloadFilesByFilepath")
    public ResponseEntity<byte[]> downloadFilesByFilepath(String filepath) {
        return filesService.downloadFilesByFilepath(filepath);
    }

    // // 无法做权限校验
    // @Operation(summary = "根据文件名访问resource下图片文件", description = "根据文件名访问resource下文件")
    // @GetMapping("noAuth/getResourceImagesByFilename/{filename}")
    // public ResponseEntity<Resource> getResourceImagesByFilename(@PathVariable String filename) {
    //     Resource file = new ClassPathResource("static/images/" + filename);
    //     if (!file.exists()) throw new BunnyException(ResultCodeEnum.FILE_NOT_EXIST);
    //     return ResponseEntity.ok().body(file);
    // }

    @Operation(summary = "更新系统文件", description = "更新系统文件")
    @PutMapping("updateFiles")
    public Result<String> updateFiles(@Valid FilesUpdateDto dto) {
        filesService.updateFiles(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "添加系统文件", description = "添加系统文件")
    @PostMapping("addFiles")
    public Mono<Result<String>> addFiles(@Valid FilesAddDto dto) {
        filesService.addFiles(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "上传文件", description = "上传文件")
    @PostMapping("upload")
    public Result<FileInfoVo> upload(FileUploadDto dto) {
        FileInfoVo vo = filesService.upload(dto);
        return Result.success(vo, ResultCodeEnum.SUCCESS_UPLOAD);
    }

    @Operation(summary = "删除系统文件", description = "删除系统文件")
    @DeleteMapping("deleteFiles")
    public Result<String> deleteFiles(@RequestBody List<Long> ids) {
        filesService.deleteFiles(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
