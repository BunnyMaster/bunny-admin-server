package cn.bunny.services.controller;

import cn.bunny.domain.system.entity.Permission;
import cn.bunny.services.aop.scanner.controller.ScannerControllerInfoVo;
import cn.bunny.services.service.system.PermissionService;
import cn.bunny.services.utils.system.PermissionUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class TestControllerTest {

    @Autowired
    private PermissionService permissionService;

    @Test
    void test1() {
        List<ScannerControllerInfoVo> list = PermissionUtil.getSystemApiInfoList();
        list.forEach(parent -> {
            String parentPath = parent.getPath();
            String powerCode = parentPath.replace("/api/", "").replace("/**", "");
            powerCode = "user::" + powerCode;

            Permission permission = new Permission();
            permission.setParentId(0L);
            permission.setPowerCode(powerCode);
            permission.setPowerName(parent.getSummary());
            permission.setRequestUrl(parentPath);
            permissionService.saveOrUpdate(permission);

            List<Permission> permissionList = parent.getChildren().stream()
                    .map(children -> {
                        String childrenPath = children.getPath();
                        String requestMethod = children.getHttpMethod();

                        Permission childrenPermission = new Permission();
                        childrenPermission.setParentId(permission.getId());
                        childrenPermission.setPowerName(children.getSummary());
                        if (!children.getPowerCodes().isEmpty()) {
                            String ChildrenPowerCode = children.getPowerCodes().get(0);
                            childrenPermission.setPowerCode(ChildrenPowerCode);

                        }
                        childrenPermission.setRequestUrl(childrenPath);
                        childrenPermission.setRequestMethod(requestMethod);

                        return childrenPermission;
                    }).toList();
            permissionService.saveOrUpdateBatch(permissionList);
        });
    }
}