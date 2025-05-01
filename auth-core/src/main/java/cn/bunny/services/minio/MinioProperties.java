package cn.bunny.services.minio;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.SetBucketPolicyArgs;
import lombok.Data;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "bunny.minio")
// 当属性有值时这个配置才生效
@ConditionalOnProperty(name = "bunny.minio.bucket-name")
@Data
public class MinioProperties {

    /* 地址 */
    private String endpointUrl;
    /* 访问秘钥 */
    private String accessKey;
    /* 私有秘钥 */
    private String secretKey;
    /* 桶名称 */
    private String bucketName;

    @Bean
    public MinioClient minioClient() {
        MinioClient minioClient = MinioClient.builder().endpoint(endpointUrl).credentials(accessKey, secretKey).build();

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