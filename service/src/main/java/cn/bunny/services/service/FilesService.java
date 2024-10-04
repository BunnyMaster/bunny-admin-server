package cn.bunny.services.service;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.services.Bunny.Files;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 系统文件表 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
public interface FilesService extends IService<Files> {

    /**
     * * 上传文件
     *
     * @param dto 文件上传
     * @return 管理端返回文件信息
     */
    FileInfoVo upload(FileUploadDto dto);
}
