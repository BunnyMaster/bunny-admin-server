package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.FileUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.pojo.common.MinioFIlePath;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.services.Bunny.Files;
import cn.bunny.services.mapper.FilesMapper;
import cn.bunny.services.service.FilesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    private MinioUtil minioUtil;

    @Value("${spring.servlet.multipart.max-file-size}")
    private String maxFileSize;

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

        // 管理员Id
        Long userId = BaseContext.getUserId();
        // 文件大小
        long fileSize = file.getSize();
        // 文件类型
        String contentType = file.getContentType();
        // 文件名
        String filename = file.getOriginalFilename();

        // 上传文件
        MinioFIlePath minioFIlePath = minioUtil.getUploadMinioObjectFilePath(file, type);
        String bucketNameFilepath = minioFIlePath.getBucketNameFilepath();

        // 盘读研数据是否过大
        String mb = maxFileSize.replace("MB", "");
        if (fileSize / 1024 / 1024 > Long.parseLong(mb)) throw new BunnyException(ResultCodeEnum.DATA_TOO_LARGE);

        // 插入文件信息
        Files adminFiles = new Files();
        adminFiles.setFileSize(fileSize);
        adminFiles.setFileType(contentType);
        adminFiles.setFilename(filename);
        adminFiles.setFilepath(bucketNameFilepath);
        adminFiles.setCreateUser(userId);
        save(adminFiles);

        // 返回信息内容化
        return FileInfoVo.builder()
                .size(FileUtil.getSize(fileSize))
                .filepath(bucketNameFilepath)
                .fileSize(fileSize)
                .fileType(contentType)
                .filename(filename)
                .url(minioUtil.getObjectNameFullPath(bucketNameFilepath))
                .build();
    }
}
