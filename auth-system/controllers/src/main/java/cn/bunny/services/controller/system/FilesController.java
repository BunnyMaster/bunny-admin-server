package cn.bunny.services.controller.system;

import cn.bunny.domain.constant.MinioConstant;
import cn.bunny.domain.files.dto.FileUploadDto;
import cn.bunny.domain.files.dto.FilesAddDto;
import cn.bunny.domain.files.dto.FilesDto;
import cn.bunny.domain.files.dto.FilesUpdateDto;
import cn.bunny.domain.files.entity.Files;
import cn.bunny.domain.files.vo.FileInfoVo;
import cn.bunny.domain.files.vo.FilesVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.system.FilesService;
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

    @Resource
    private FilesService filesService;

    @Operation(summary = "分页查询系统文件", description = "分页查询系统文件")
    @GetMapping("getFilesList/{page}/{limit}")
    public Result<PageResult<FilesVo>> getFilesList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            FilesDto dto) {
        Page<Files> pageParams = new Page<>(page, limit);
        PageResult<FilesVo> pageResult = filesService.getFilesList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "下载文件", description = "下载文件")
    @GetMapping("downloadFilesByFileId/{fileId}")
    public ResponseEntity<byte[]> downloadFilesByFileId(@PathVariable Long fileId) {
        return filesService.downloadFilesByFileId(fileId);
    }

    @Operation(summary = "获取所有文件类型", description = "获取所有文件类型")
    @GetMapping("noManage/getAllMediaTypes")
    public Result<Set<String>> getAllMediaTypes() {
        Set<String> list = filesService.getAllMediaTypes();
        return Result.success(list);
    }

    @Operation(summary = "获取所有文件存储基础路径", description = "获取所有文件存储基础路径")
    @GetMapping("noManage/getAllFilesStoragePath")
    public Result<List<String>> getAllFilesStoragePath() {
        Map<String, String> typeMap = MinioConstant.typeMap;
        List<String> list = typeMap.keySet().stream().toList();

        return Result.success(list);
    }

    @Operation(summary = "根据文件名下载文件", description = "根据文件名下载文件")
    @GetMapping("downloadFilesByFilepath")
    public ResponseEntity<byte[]> downloadFilesByFilepath(String filepath) {
        return filesService.downloadFilesByFilepath(filepath);
    }

    @Operation(summary = "更新系统文件", description = "更新系统文件")
    @PutMapping("updateFiles")
    public Result<String> updateFiles(@Valid FilesUpdateDto dto) {
        filesService.updateFiles(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "添加系统文件", description = "添加系统文件")
    @PostMapping("addFiles")
    public Result<Object> addFiles(@Valid FilesAddDto dto) {
        filesService.addFiles(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
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
