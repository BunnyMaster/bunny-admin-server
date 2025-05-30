package cn.bunny.core.config;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.SetBucketPolicyArgs;
import lombok.Data;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 如果项目使用的是minio，创建桶的时候需要设置公开权限
 * 在这里初始化的时候会自动设置公开权限
 * 不需要可以删除这个文件
 */
@Configuration
@ConditionalOnProperty(name = "dromara.x-file-storage.minio.bucket-name")
@Data
public class MinioConfiguration {

    /* 地址 */
    private String domain;
    /* 访问秘钥 */
    private String accessKey;
    /* 私有秘钥 */
    private String secretKey;
    /* 桶名称 */
    private String bucketName;

    @Bean
    public MinioClient minioClient() {
        MinioClient minioClient = MinioClient.builder().endpoint(domain).credentials(accessKey, secretKey).build();

        try {
            // 判断桶是否存在，不存在则创建，并且可以有公开访问权限
            boolean found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
            if (!found) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
                String publicPolicy = String.format("{\n" +
                        "  \"Version\": \"2012-10-17\",\n" +
                        "  \"Statement\": [\n" +
                        "    {\n" +
                        "      \"Effect\": \"Allow\",\n" +
                        "      \"Principal\": \"*\",\n" +
                        "      \"Action\": [\"s3:GetObject\"],\n" +
                        "      \"Resource\": [\"arn:aws:s3:::%s/*\"]\n" +
                        "    }\n" +
                        "  ]\n" +
                        "}", bucketName);

                minioClient.setBucketPolicy(SetBucketPolicyArgs.builder().bucket(bucketName).config(publicPolicy).build());
            }
        } catch (Exception exception) {
            exception.getStackTrace();
        }

        return minioClient;
    }
}