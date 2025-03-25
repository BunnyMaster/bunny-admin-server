package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.configuration.ConfigurationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Tag(name = "系统配置", description = "系统配置相关接口")
@RestController
@RequestMapping("/api/config")
public class ConfigurationController {

    @Autowired
    private ConfigurationService configurationService;

    @Operation(summary = "读取web配置文件", description = "读取web配置文件")
    @GetMapping("noAuth/webConfig")
    public WebConfiguration webConfig() {
        return configurationService.webConfig();
    }

    @Operation(summary = "获取修改web配置文件", description = "获取修改web配置文件")
    @GetMapping("getWebConfig")
    public Result<WebConfiguration> getWebConfig() {
        WebConfiguration webConfiguration = configurationService.webConfig();
        return Result.success(webConfiguration);
    }

    @Operation(summary = "更新web配置文件", description = "更新web配置文件")
    @PutMapping("updateWebConfiguration")
    public Result<Object> updateWebConfiguration(@Valid @RequestBody WebConfigurationDto dto) {
        configurationService.updateWebConfiguration(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

}
