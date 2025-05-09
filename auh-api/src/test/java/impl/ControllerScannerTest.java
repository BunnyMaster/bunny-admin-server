package impl;

import cn.bunny.services.aop.scanner.ControllerApiPermissionScanner;
import cn.bunny.services.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import com.alibaba.fastjson2.JSON;
import org.junit.jupiter.api.Test;

import java.util.List;

public class ControllerScannerTest {

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

        String jsonString = JSON.toJSONString(list);
        System.out.println(jsonString);
    }
}
