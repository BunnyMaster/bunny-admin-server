package cn.bunny.services.controller;

import cn.bunny.services.aop.scanner.ControllerApiPermissionScanner;
import cn.bunny.services.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.service.system.PermissionService;
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
        List<ScannerControllerInfoVo> list = ControllerApiPermissionScanner.getSystemApiInfoList();
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
            // System.out.println(permission);

            List<Permission> permissionList = parent.getChildren().stream()
                    .map(children -> {
                        Permission childrenPermission = new Permission();
                        childrenPermission.setParentId(permission.getId());
                        childrenPermission.setPowerName(children.getSummary());
                        if (!children.getPowerCodes().isEmpty()) {
                            String ChildrenPowerCode = children.getPowerCodes().get(0);
                            childrenPermission.setPowerCode(ChildrenPowerCode);
                        }

                        String childrenPath = children.getPath();
                        childrenPermission.setRequestUrl(childrenPath);
                        childrenPermission.setRequestMethod(children.getHttpMethod());

                        return childrenPermission;
                    })
                    .toList();
            // System.out.println(JSON.toJSONString(permissionList));
            permissionService.saveOrUpdateBatch(permissionList);
        });
    }
}