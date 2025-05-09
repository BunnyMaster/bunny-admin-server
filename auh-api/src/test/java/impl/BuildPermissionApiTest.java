package impl;

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
        List<ScannerControllerInfoVo> list = ControllerApiPermissionScanner.scanControllerInfo();

        // 添加【Springboot端点】在服务监控中会用到
        ScannerControllerInfoVo actuatorParent = ScannerControllerInfoVo.builder().powerCode("admin:actuator").summary("actuator端点访问").build();
        ScannerControllerInfoVo actuatorChild = ScannerControllerInfoVo.builder().path("/api/actuator/**")
                .summary("Springboot端点全部可以访问")
                .description("系统监控使用")
                .powerCode("actuator:all")
                .build();
        actuatorParent.setChildren(List.of(actuatorChild));
        list.add(actuatorParent);

        list.forEach(parent -> {
            String summary = parent.getSummary();
            String path = parent.getPath();
            String httpMethod = parent.getHttpMethod();
            String powerCodes = parent.getPowerCode();
            String description = parent.getDescription();

            // 设置 powerCode
            String powerCode = Objects.isNull(powerCodes) ? "" : powerCodes;

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
                        String childrenPowerCodes = children.getPowerCode();

                        // 设置 powerCode
                        String childrenPowerCode = Objects.isNull(childrenPowerCodes) ? "" : childrenPowerCodes;

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
