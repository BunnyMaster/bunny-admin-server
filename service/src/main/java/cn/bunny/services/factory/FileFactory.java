package cn.bunny.services.factory;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.FileUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.pojo.common.MinioFilePath;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.services.mapper.FilesMapper;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileFactory {
    @Autowired
    private FilesMapper filesMapper;
    @Value("${spring.servlet.multipart.max-file-size}")
    private String maxFileSize;
    @Autowired
    private MinioUtil minioUtil;

    /**
     * 上传文件
     *
     * @param file 文件
     * @param type 文件类型(MinioConstant)
     * @return 返回文件信息
     */
    @SneakyThrows
    public FileInfoVo uploadFile(MultipartFile file, String type) {
        // 管理员Id
        Long userId = BaseContext.getUserId();
        // 文件大小
        long fileSize = file.getSize();
        // 文件类型
        String contentType = file.getContentType();
        // 文件名
        String filename = file.getOriginalFilename();

        // 上传文件
        MinioFilePath minioFIlePath = minioUtil.getUploadMinioObjectFilePath(file, type);
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
        filesMapper.insert(adminFiles);

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
