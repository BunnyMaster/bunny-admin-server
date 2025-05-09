package cn.bunny.services.service.file;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.files.dto.FileUploadDto;
import cn.bunny.services.domain.system.files.dto.FilesAddOrUpdateDto;
import cn.bunny.services.domain.system.files.dto.FilesDto;
import cn.bunny.services.domain.system.files.dto.UploadThumbnail;
import cn.bunny.services.domain.system.files.entity.Files;
import cn.bunny.services.domain.system.files.vo.FileInfoVo;
import cn.bunny.services.domain.system.files.vo.FilesVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.x.file.storage.core.get.RemoteDirInfo;
import org.springframework.http.ResponseEntity;

import java.util.List;

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
    void addFiles(FilesAddOrUpdateDto dto);

    /**
     * * 更新系统文件表
     *
     * @param dto 更新表单
     */
    void updateFiles(FilesAddOrUpdateDto dto);

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
     * 上传文件縮略圖
     * 详细参考：
     * <a href="https://x-file-storage.xuyanwu.cn/#/%E5%9F%BA%E7%A1%80%E5%8A%9F%E8%83%BD?id=%e4%b8%8a%e4%bc%a0">
     * 上传文件文档
     * </a>
     *
     * @param uploadThumbnail 上传文件 {@link UploadThumbnail}
     */
    FileInfoVo uploadFileByThumbnail(UploadThumbnail uploadThumbnail);

    /**
     * 列举当前文件路径所有的文件
     *
     * @param path 路径
     * @return 文件列表
     */
    List<RemoteDirInfo> listFiles(String path);

}
