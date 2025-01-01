package cn.bunny.common.service.utils.minio;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.constant.MinioConstant;
import cn.bunny.dao.model.file.MinioFilePath;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import io.minio.*;
import io.minio.messages.DeleteError;
import io.minio.messages.DeleteObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

/**
 * Minio操作工具类 简化操作步骤
 * By：Bunny0212
 */
@Component
@Slf4j
public class MinioUtil {
    @Autowired
    private MinioProperties properties;

    @Autowired
    private MinioClient minioClient;

    /**
     * 获取Minio文件路径
     */
    public static MinioFilePath initUploadFileReturnMinioFilePath(String buckName, String minioPreType, MultipartFile file) {
        String uuid = UUID.randomUUID().toString();
        // 定义日期时间格式
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM-dd");
        String extension = "";

        // 原始文件名
        String filename = file.getOriginalFilename();
        if (StringUtils.hasText(filename) && filename.contains(".")) {
            extension = "." + filename.substring(filename.lastIndexOf(".") + 1);
        }

        // UUID防止重名
        String uuidFilename = uuid + extension;

        // 拼接时间+UUID文件名
        String timeUuidFilename = currentDateTime.format(formatter) + "/" + uuidFilename;// 加上时间路径

        // 上传根文件夹+拼接时间+UUID文件名
        String filepath = MinioConstant.getType(minioPreType) + timeUuidFilename;

        // 桶名称+上传根文件夹+拼接时间+UUID文件名
        String buckNameFilepath = "/" + buckName + MinioConstant.getType(minioPreType) + timeUuidFilename;

        // 设置及Minio基础信息
        MinioFilePath minioFIlePath = new MinioFilePath();
        minioFIlePath.setFilename(filename);
        minioFIlePath.setUuidFilename(uuidFilename);
        minioFIlePath.setTimeUuidFilename(timeUuidFilename);
        minioFIlePath.setFilepath(filepath);
        minioFIlePath.setBucketNameFilepath(buckNameFilepath);

        return minioFIlePath;
    }

    /**
     * * 上传文件并返回处理信息
     */
    public MinioFilePath uploadObjectReturnFilePath(MultipartFile file, String minioPreType) throws IOException {
        if (file == null) return null;
        String bucketName = properties.getBucketName();

        // 上传对象
        try {
            MinioFilePath minioFile = initUploadFileReturnMinioFilePath(bucketName, minioPreType, file);

            minioClient.putObject(PutObjectArgs.builder().bucket(bucketName).object(minioFile.getFilepath()).stream(file.getInputStream(), file.getSize(), -1).build());

            return minioFile;
        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.UPLOAD_ERROR);
        }
    }

    /**
     * 获取默认bucket文件，并返回字节数组
     *
     * @param objectName 对象名称
     * @return 文件流对象
     */
    public byte[] getBucketObjectByte(String objectName) {
        String bucketName = properties.getBucketName();

        try {
            GetObjectResponse getObjectResponse = minioClient.getObject(GetObjectArgs.builder().bucket(bucketName).object(objectName).build());

            return getObjectResponse.readAllBytes();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        throw new AuthCustomerException(ResultCodeEnum.GET_BUCKET_EXCEPTION);
    }

    /**
     * 获取Minio全路径名，Object带有桶名称
     *
     * @param objectName 对象名称
     * @return 全路径
     */
    public String getObjectNameFullPath(String objectName) {
        String url = properties.getEndpointUrl();

        return url + objectName;
    }

    /**
     * 上传文件
     *
     * @param bucketName  桶名称
     * @param filename    文件名
     * @param inputStream 输入流
     * @param size        大小
     */
    public void putObject(String bucketName, String filename, InputStream inputStream, Long size) {
        try {
            minioClient.putObject(PutObjectArgs.builder().bucket(bucketName).object(filename).stream(inputStream, size, -1).build());
        } catch (Exception exception) {
            log.error("上传文件失败：{}", (Object) exception.getStackTrace());
            throw new AuthCustomerException(ResultCodeEnum.UPLOAD_ERROR);
        }
    }

    /**
     * * 删除目标文件
     *
     * @param list 对象文件列表
     */
    public void removeObjects(List<String> list) {
        try {
            String bucketName = properties.getBucketName();
            List<DeleteObject> objectList = list.stream().map(DeleteObject::new).toList();

            Iterable<Result<DeleteError>> results = minioClient.removeObjects(RemoveObjectsArgs.builder().bucket(bucketName).objects(objectList).build());
            for (Result<DeleteError> result : results) {
                DeleteError error = result.get();
                throw new AuthCustomerException("Error in deleting object " + error.objectName() + "; " + error.message());
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    /**
     * * 更新文件
     *
     * @param bucketName 桶名称
     * @param filepath   文件路径
     * @param file       文件
     */
    public void updateFile(String bucketName, String filepath, MultipartFile file) {
        try {
            putObject(bucketName, filepath, file.getInputStream(), file.getSize());
        } catch (IOException e) {
            throw new AuthCustomerException(e.getMessage());
        }
    }
}
