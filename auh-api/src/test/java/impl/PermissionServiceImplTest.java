package impl;

import cn.bunny.services.AuthServiceApplication;
import cn.bunny.services.core.template.PermissionTreeProcessor;
import cn.bunny.services.domain.common.model.dto.excel.PermissionExcel;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.mapper.system.PermissionMapper;
import com.alibaba.fastjson2.JSON;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest(classes = AuthServiceApplication.class)
class PermissionServiceImplTest {

    @Autowired
    private PermissionMapper permissionMapper;

    @Test
    void exportPermission() {

        List<Permission> permissionList = permissionMapper.selectList(null);
        List<PermissionExcel> permissionExcelList = permissionList.stream().map(permission -> {
            PermissionExcel permissionExcel = new PermissionExcel();
            BeanUtils.copyProperties(permission, permissionExcel);

            return permissionExcel;
        }).toList();

        PermissionTreeProcessor permissionTreeProcessor = new PermissionTreeProcessor();
        List<PermissionExcel> buildTree = permissionTreeProcessor.process(permissionExcelList);

        System.out.println(JSON.toJSONString(buildTree));
    }
}