package cn.bunny.services.service;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.files.FilesAddDto;
import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.dto.system.files.FilesUpdateDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.files.FilesVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
import org.springframework.core.io.Resource;
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
    PageResult<FilesVo> getFilesList(Page<Files> pageParams, FilesDto dto);

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
     * * 下载文件
     *
     * @param filepath 文件路径
     * @return 文件字节数组
     */
    ResponseEntity<byte[]> downloadFilesByFilepath(String filepath);

    /**
     * * 获取所有文件类型
     *
     * @return 媒体文件类型列表
     */
    Set<String> getAllMediaTypes();

    /**
     * * 根据文件名访问resource下文件
     *
     * @param filename 文件名
     * @return Resource
     */
    Resource getResourceByFilename(String filename);
}
