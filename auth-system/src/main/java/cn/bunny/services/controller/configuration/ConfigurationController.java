package cn.bunny.services.controller.configuration;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.model.configuration.dto.WebConfigurationDto;
import cn.bunny.domain.model.configuration.entity.WebConfiguration;
import cn.bunny.services.service.configuration.ConfigurationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

@Tag(name = "web配置文件", description = "web配置相关接口")
@PermissionTag(permission = "config:*")
@RestController
@RequestMapping("/api/config")
public class ConfigurationController {

    @Resource
    private ConfigurationService configurationService;

    @Operation(summary = "获取web配置文件", description = "读取web配置文件并返回给前端")
    @GetMapping("public/web-config")
    public WebConfiguration webConfig() {
        return configurationService.webConfig();
    }

    @Operation(summary = "更新web配置文件", description = "更新web配置文件，重启应用失效")
    @PermissionTag(permission = "config::update")
    @PutMapping()
    public Result<Object> updateWebConfiguration(@Valid @RequestBody WebConfigurationDto dto) {
        configurationService.updateWebConfiguration(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
