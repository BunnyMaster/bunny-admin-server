package cn.bunny.services.minio;

import cn.bunny.services.domain.common.constant.MinioConstant;
import cn.bunny.services.domain.common.model.dto.minio.MinioUploadFileInfo;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import io.minio.*;
import io.minio.messages.DeleteError;
import io.minio.messages.DeleteObject;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Minio操作工具类 简化操作步骤
 * 自定义封装
 */
@Slf4j
@Service
public class MinioService {

    @Resource
    private MinioProperties properties;

    @Resource
    private MinioClient minioClient;

    /**
     * 上传文件到MinIO并返回文件处理信息
     *
     * <p><b>文件存储规则：</b></p>
     * <ul>
     *   <li>按日期分目录存储（格式：yyyy/MM-dd）</li>
     *   <li>使用UUID重命名文件防止冲突</li>
     *   <li>保留原始文件名信息</li>
     *   <li>支持按类型分类存储（通过minioPreType参数）</li>
     * </ul>
     *
     * <p><b>返回信息包含：</b></p>
     * <ol>
     *   <li>原始文件名</li>
     *   <li>UUID重命名后的文件名</li>
     *   <li>带日期路径的文件名</li>
     *   <li>完整存储路径（不含桶名）</li>
     *   <li>完整访问路径（含桶名）</li>
     * </ol>
     *
     * @param file         上传的文件对象（不可为空）
     * @param minioPreType 文件类型前缀（用于分类存储，参考MinioConstant定义）
     * @return 文件处理信息对象（包含各种路径信息），当file为null时返回null
     * @throws IOException           当文件流读取异常时抛出
     * @throws AuthCustomerException 当上传失败时抛出（错误码：UPLOAD_ERROR）
     * @see MinioConstant 文件类型前缀常量
     * @see MinioUploadFileInfo 返回信息数据结构
     */
    public MinioUploadFileInfo uploadWithFileInfo(MultipartFile file, String minioPreType) throws IOException {
        if (file == null) return null;

        // 上传文件时的桶名称
        String bucketName = properties.getBucketName();

        // 上传对象
        try {
            String uuid = UUID.randomUUID().toString();
            // 定义日期时间格式
            String dateFormatter = new SimpleDateFormat("yyyy/MM-dd").format(new Date());
            // 文件后缀
            String extension = "";

            // 原始文件名
            String filename = file.getOriginalFilename();
            if (StringUtils.hasText(filename) && filename.contains(".")) {
                extension = "." + filename.substring(filename.lastIndexOf(".") + 1);
            }

            // UUID防止重名
            String uuidFilename = uuid + extension;

            // 拼接时间+UUID文件名 加上时间路径
            String timeUuidFilename = dateFormatter + "/" + uuidFilename;

            // 上传根文件夹+拼接时间+UUID文件名
            String filepath = MinioConstant.getType(minioPreType) + timeUuidFilename;

            // 桶名称+上传根文件夹+拼接时间+UUID文件名
            String buckNameFilepath = "/" + bucketName + MinioConstant.getType(minioPreType) + timeUuidFilename;

            // 设置及Minio基础信息
            MinioUploadFileInfo minioUploadFIleInfo = new MinioUploadFileInfo();
            minioUploadFIleInfo.setFilename(filename);
            minioUploadFIleInfo.setUuidFilename(uuidFilename);
            minioUploadFIleInfo.setTimeUuidFilename(timeUuidFilename);
            minioUploadFIleInfo.setFilepath(filepath);
            minioUploadFIleInfo.setBucketNameFilepath(buckNameFilepath);

            minioClient.putObject(PutObjectArgs.builder().bucket(bucketName).object(minioUploadFIleInfo.getFilepath()).stream(file.getInputStream(), file.getSize(), -1).build());

            return minioUploadFIleInfo;
        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.UPLOAD_ERROR);
        }
    }

    /**
     * 获取默认存储桶中的文件字节数组
     *
     * <p><b>注意：</b>会一次性读取全部文件内容到内存，大文件慎用</p>
     *
     * @param objectName 对象全路径名称（包含目录路径）
     * @return 文件内容的字节数组
     * @throws AuthCustomerException 当获取失败时抛出（错误码：{@link ResultCodeEnum#GET_BUCKET_EXCEPTION}）
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
     * 上传文件到指定存储桶
     *
     * @param bucketName  存储桶名称
     * @param filename    对象存储路径（包含文件名）
     * @param inputStream 文件输入流（调用方负责关闭）
     * @param size        文件大小（字节）
     * @throws AuthCustomerException 当上传失败时抛出（错误码：{@link ResultCodeEnum#UPLOAD_ERROR}）
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
     * 批量删除存储桶中的对象文件
     *
     * @param list 要删除的对象路径列表
     * @throws AuthCustomerException 当删除失败时抛出（包含错误对象信息）
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
     * 更新存储桶中的文件（覆盖写入）
     *
     * @param bucketName 存储桶名称
     * @param filepath   对象存储路径
     * @param file       新的文件对象
     * @throws AuthCustomerException 当更新失败时抛出
     */
    public void updateFile(String bucketName, String filepath, MultipartFile file) {
        try {
            putObject(bucketName, filepath, file.getInputStream(), file.getSize());
        } catch (IOException e) {
            throw new AuthCustomerException(e.getMessage());
        }
    }

    /**
     * 检查并创建存储桶（如果不存在）
     *
     * @param bucketName 存储桶名称
     * @return true-已存在，false-新创建
     * @throws AuthCustomerException 当操作失败时抛出
     */
    public boolean createBucketIfNotExists(String bucketName) {
        boolean found = false;
        try {
            found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());

            // 如果 bucket 不存在就创建
            if (!found) makeBucket(bucketName);

            return found;
        } catch (Exception exception) {
            log.error("判断桶是否存在 ------ 失败消息:{}", exception.getLocalizedMessage());
            exception.getStackTrace();
        }
        throw new AuthCustomerException("未初始化 bucket");
    }

    /**
     * 创建新的存储桶
     *
     * @param bucketName 存储桶名称（需符合命名规范）
     * @throws AuthCustomerException 当创建失败时抛出
     */
    public void makeBucket(String bucketName) {
        try {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
        } catch (Exception exception) {
            exception.getStackTrace();
            throw new AuthCustomerException("创建失败");
        }
    }
}
