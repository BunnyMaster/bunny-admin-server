package cn.bunny.services.service.system;

import cn.bunny.domain.files.dto.FileUploadDto;
import cn.bunny.domain.files.dto.FilesAddDto;
import cn.bunny.domain.files.dto.FilesDto;
import cn.bunny.domain.files.dto.FilesUpdateDto;
import cn.bunny.domain.files.entity.Files;
import cn.bunny.domain.files.vo.FileInfoVo;
import cn.bunny.domain.files.vo.FilesVo;
import cn.bunny.domain.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 系统文件表 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
public interface FilesService extends IService<Files> {

    /**
     * * 获取系统文件表列表
     *
     * @return 系统文件表返回列表
     */
    PageResult<FilesVo> getFilesPage(Page<Files> pageParams, FilesDto dto);

    /**
     * * 添加系统文件表
     *
     * @param dto 添加表单
     */
    void addFiles(@Valid FilesAddDto dto);

    /**
     * * 更新系统文件表
     *
     * @param dto 更新表单
     */
    void updateFiles(@Valid FilesUpdateDto dto);

    /**
     * * 上传文件
     *
     * @param dto 文件上传
     * @return 管理端返回文件信息
     */
    FileInfoVo upload(FileUploadDto dto);

    /**
     * * 删除|批量删除系统文件表类型
     *
     * @param ids 删除id列表
     */
    void deleteFiles(List<Long> ids);

    /**
     * * 下载文件
     *
     * @param fileId 文件id
     * @return 文件字节数组
     */
    ResponseEntity<byte[]> downloadFilesByFileId(Long fileId);

    /**
     * * 获取所有文件类型
     *
     * @return 媒体文件类型列表
     */
    Set<String> getMediaTypeList();
}
