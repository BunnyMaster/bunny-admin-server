package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.services.service.FilesService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 系统文件表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@RestController
@RequestMapping("admin/files")
public class FilesController {

    @Autowired
    private FilesService filesService;

    @Operation(summary = "上传文件", description = "上传文件")
    @PostMapping("upload")
    public Result<FileInfoVo> upload(FileUploadDto dto) {
        FileInfoVo vo = filesService.upload(dto);
        return Result.success(vo, ResultCodeEnum.SUCCESS_UPLOAD);
    }
}
