package cn.bunny.common.service.utils.minio;

import io.minio.MinioClient;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "bunny.minio")
@ConditionalOnProperty(name = "bunny.minio.bucket-name")// 当属性有值时这个配置才生效
@Data
@Slf4j
public class MinioProperties {
    private String endpointUrl;
    private String accessKey;
    private String secretKey;
    private String bucketName;

    @Bean
    public MinioClient minioClient() {
        return MinioClient.builder().endpoint(endpointUrl).credentials(accessKey, secretKey).build();
    }
}
