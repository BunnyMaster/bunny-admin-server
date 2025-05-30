package cn.bunny.services.controller.file;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.files.dto.FilesParDetailDto;
import cn.bunny.domain.files.entity.FilesParDetail;
import cn.bunny.domain.files.vo.FilesParDetailVo;
import cn.bunny.services.service.file.FilesParDetailService;
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
 * 文件分片信息表，仅在手动分片上传时使用 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2025-05-08 23:01:19
 */
@Tag(name = "文件分片信息表，仅在手动分片上传时使用", description = "文件分片信息表，仅在手动分片上传时使用相关接口")
@PermissionTag(permission = "filesParDetail:*")
@RestController
@RequestMapping("/api/files-par-detail")
public class FilesParDetailController {

    @Resource
    private FilesParDetailService filesPardetailService;

    @Operation(summary = "分页查询文件分片信息表，仅在手动分片上传时使用", description = "分页文件分片信息表，仅在手动分片上传时使用")
    @PermissionTag(permission = "filesParDetail:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<FilesParDetailVo>> getFilesParDetailPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            FilesParDetailDto dto) {
        Page<FilesParDetail> pageParams = new Page<>(page, limit);
        PageResult<FilesParDetailVo> pageResult = filesPardetailService.getFilesParDetailPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加文件分片信息表，仅在手动分片上传时使用", description = "添加文件分片信息表，仅在手动分片上传时使用")
    @PermissionTag(permission = "filesParDetail:add")
    @PostMapping()
    public Result<String> createFilesParDetail(@Valid @RequestBody FilesParDetailDto dto) {
        filesPardetailService.createFilesParDetail(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新文件分片信息表，仅在手动分片上传时使用", description = "更新文件分片信息表，仅在手动分片上传时使用")
    @PermissionTag(permission = "filesParDetail:update")
    @PutMapping()
    public Result<String> updateFilesParDetail(@Valid @RequestBody FilesParDetailDto dto) {
        filesPardetailService.updateFilesParDetail(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除文件分片信息表，仅在手动分片上传时使用", description = "删除文件分片信息表，仅在手动分片上传时使用")
    @PermissionTag(permission = "filesParDetail:delete")
    @DeleteMapping()
    public Result<String> deleteFilesParDetail(@RequestBody List<Long> ids) {
        filesPardetailService.deleteFilesParDetail(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}