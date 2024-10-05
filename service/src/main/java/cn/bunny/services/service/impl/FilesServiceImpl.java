package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.services.factory.FileFactory;
import cn.bunny.services.mapper.FilesMapper;
import cn.bunny.services.service.FilesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * 系统文件表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Service
public class FilesServiceImpl extends ServiceImpl<FilesMapper, Files> implements FilesService {

    @Autowired
    private FileFactory fileFactory;

    /**
     * * 上传文件
     *
     * @param dto 文件上传
     * @return 管理端返回文件信息
     */
    @SneakyThrows
    @Override
    public FileInfoVo upload(FileUploadDto dto) {
        MultipartFile file = dto.getFile();
        String type = dto.getType();

        return fileFactory.uploadFile(file, type);
    }
}
