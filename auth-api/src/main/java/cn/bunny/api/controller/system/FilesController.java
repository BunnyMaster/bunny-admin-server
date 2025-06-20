package cn.bunny.api.controller.system;

import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.constant.FileStorageConstant;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.system.dto.FileUploadDto;
import cn.bunny.domain.system.dto.FilesCreateOrUpdateDto;
import cn.bunny.domain.system.dto.FilesDto;
import cn.bunny.domain.system.entity.Files;
import cn.bunny.domain.system.vo.FileInfoVo;
import cn.bunny.domain.system.vo.FilesVo;
import cn.bunny.system.service.FilesService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统文件表表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Tag(name = "文件" , description = "系统文件相关接口" )
@PermissionTag(permission = "files:*" )
@RestController
@RequestMapping("api/files" )
public class FilesController {

    @Resource
    private FilesService filesService;

    @Operation(summary = "分页查询文件" , description = "分页查询系统文件" )
    @PermissionTag(permission = "files:query" )
    @GetMapping("{page}/{limit}" )
    public Result<PageResult<FilesVo>> getFilesPage(
            @Parameter(name = "page" , description = "当前页" , required = true)
            @PathVariable("page" ) Integer page,
            @Parameter(name = "limit" , description = "每页记录数" , required = true)
            @PathVariable("limit" ) Integer limit,
            FilesDto dto) {
        Page<Files> pageParams = new Page<>(page, limit);
        PageResult<FilesVo> pageResult = filesService.getFilesPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "更新文件" , description = "更新系统文件" )
    @PermissionTag(permission = "files:update" )
    @PutMapping()
    public Result<String> updateFiles(@Validated(ValidationGroups.Update.class) FilesCreateOrUpdateDto dto) {
        filesService.updateFiles(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "添加文件" , description = "添加系统文件" )
    @PermissionTag(permission = "files:add" )
    @PostMapping()
    public Result<Object> createFiles(@Validated(ValidationGroups.Add.class) FilesCreateOrUpdateDto dto) {
        filesService.createFiles(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "删除文件" , description = "删除系统文件" )
    @PermissionTag(permission = "files:delete" )
    @DeleteMapping()
    public Result<String> deleteFiles(@RequestBody List<Long> ids) {
        filesService.deleteFiles(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "下载文件" , description = "根据文件id下载文件" )
    @PermissionTag(permission = "files:query" )
    @GetMapping("file/{fileId}" )
    public ResponseEntity<byte[]> downloadFilesByFileId(@PathVariable Long fileId) {
        return filesService.downloadFilesByFileId(fileId);
    }

    @Operation(summary = "获取所有文件存储基础路径" , description = "获取所有文件存储基础路径" )
    @GetMapping("private/file-storage-paths" )
    public Result<List<String>> getAllFilesStoragePath() {
        Map<String, String> typeMap = FileStorageConstant.typeMap;
        List<String> list = typeMap.keySet().stream().toList();

        return Result.success(list);
    }

    @Operation(summary = "上传文件" , description = "上传文件" )
    @PostMapping("private/file" )
    public Result<FileInfoVo> upload(@Valid FileUploadDto dto) {
        FileInfoVo vo = filesService.upload(dto);
        return Result.success(vo, ResultCodeEnum.SUCCESS_UPLOAD);
    }

    @Operation(summary = "上传图片文件" , description = "上传图片文件" )
    @PostMapping("private/image" )
    public Result<FileInfoVo> uploadImage(@Valid FileUploadDto dto) {
        FileInfoVo vo = filesService.uploadFileByThumbnail(dto);
        return Result.success(vo, ResultCodeEnum.SUCCESS_UPLOAD);
    }
}
