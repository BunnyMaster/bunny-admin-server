# 文档包含配置和一些其他说明

## 文件上传配置

如果需要其他平台，需要参考文档：https://x-file-storage.xuyanwu.cn/#/。

因为按照要求，删除、更新操作需要实现接口，所以目前的`FileRecorder`是实现了的，在`FileDetailService`。

```yaml
# 可以配置很多但只能使用一个！！！其他平台参考官方文档
dromara:
  x-file-storage: # 文件存储配置
    default-platform: local-plus-1 # 默认使用的存储平台
    # default-platform: minio-1 # 默认使用的存储平台
    thumbnail-suffix: ".min.jpg" # 缩略图后缀，例如【.min.jpg】【.png】
    local-plus:
      - platform: local-plus-1 # 存储平台标识
        enable-storage: true  # 启用存储
        enable-access: true # 启用访问（线上请使用 Nginx 配置，效率更高）
        domain: ${dromara.local-plus.domain}
        base-path: ${dromara.local-plus.base-path}
        path-patterns: ${dromara.local-plus.path-patterns}
        storage-path: ${dromara.local-plus.storage-path}
    minio:
      - platform: minio-1 # 存储平台标识
        enable-storage: true  # 启用存储
        end-point: ${dromara.minio.endpointUrl}
        domain: ${dromara.minio.endpointUrl}/${dromara.minio.bucket-name}
        bucket-name: ${dromara.minio.bucket-name}
        access-key: ${dromara.minio.accessKey}
        secret-key: ${dromara.minio.secretKey}
        base-path: ${dromara.minio.base-path}
```

## 生成系统需要的权限

```java
import cn.bunny.services.AuthServiceApplication;
import cn.bunny.services.aop.scanner.ControllerApiPermissionScanner;
import cn.bunny.services.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.service.system.PermissionService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Objects;

@SpringBootTest(classes = AuthServiceApplication.class, properties = "spring.profiles.active=dev")
public class BuildPermissionApiTest {

    @Autowired
    private PermissionService permissionService;

    @Test
    void test() {
        List<ScannerControllerInfoVo> list = ControllerApiPermissionScanner.getSystemApiInfoList();
        ScannerControllerInfoVo actuatorParent = ScannerControllerInfoVo.builder().powerCodes(List.of("admin::actuator")).summary("actuator端点访问").build();
        ScannerControllerInfoVo actuatorChild = ScannerControllerInfoVo.builder().path("/api/actuator/**")
                .summary("Springboot端点全部可以访问")
                .description("系统监控使用")
                .powerCodes(List.of("actuator::all"))
                .build();
        actuatorParent.setChildren(List.of(actuatorChild));
        list.add(actuatorParent);

        list.forEach(parent -> {
            String summary = parent.getSummary();
            String path = parent.getPath();
            String httpMethod = parent.getHttpMethod();
            List<String> powerCodes = parent.getPowerCodes();
            String description = parent.getDescription();

            // 设置 powerCode
            String powerCode = Objects.isNull(powerCodes) ? "" : powerCodes.get(0);

            Permission permission = new Permission();
            permission.setParentId(0L);
            permission.setPowerName(summary);
            permission.setPowerCode(powerCode);
            permission.setRequestMethod(httpMethod);
            permission.setRequestUrl(path);
            permissionService.save(permission);

            // 保存后 permission 的 Id 作为子级的父级Id
            Long permissionId = permission.getId();

            // 子级列表
            List<Permission> permissionList = parent.getChildren().stream()
                    .map(children -> {
                        String childrenSummary = children.getSummary();
                        String childrenPath = children.getPath();
                        String childrenHttpMethod = children.getHttpMethod();
                        List<String> childrenPowerCodes = children.getPowerCodes();

                        // 设置 powerCode
                        String childrenPowerCode = Objects.isNull(childrenPowerCodes) ? "" : childrenPowerCodes.get(0);

                        Permission childPermission = new Permission();
                        childPermission.setParentId(permissionId);
                        childPermission.setPowerName(childrenSummary);
                        childPermission.setPowerCode(childrenPowerCode);
                        childPermission.setRequestMethod(childrenHttpMethod);
                        childPermission.setRequestUrl(childrenPath);

                        return childPermission;
                    }).toList();

            permissionService.saveBatch(permissionList);
        });
    }
}
```

## MInio权限设置

如果其他平台也需要，根据自己需求进行添加，不需要可以删除这个文件。

```java
/**
 * 如果项目使用的是minio，创建桶的时候需要设置公开权限
 * 在这里初始化的时候会自动设置公开权限
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
```