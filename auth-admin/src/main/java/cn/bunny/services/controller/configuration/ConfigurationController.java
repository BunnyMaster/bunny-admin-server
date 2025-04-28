package cn.bunny.services.controller.configuration;

import cn.bunny.domain.configuration.dto.WebConfigurationDto;
import cn.bunny.domain.configuration.entity.WebConfiguration;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.configuration.ConfigurationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

@Tag(name = "web配置", description = "web配置相关接口")
@RestController
@RequestMapping("/api/config")
public class ConfigurationController {

    @Resource
    private ConfigurationService configurationService;

    @Operation(summary = "用户前端配置文件", description = "读取web配置文件并返回给前端")
    @GetMapping("public/webConfig")
    public WebConfiguration webConfig() {
        return configurationService.webConfig();
    }

    @Operation(summary = "更新web配置文件", description = "更新web配置文件，重启应用失效", tags = "config::update")
    @PutMapping()
    public Result<Object> updateWebConfiguration(@Valid @RequestBody WebConfigurationDto dto) {
        configurationService.updateWebConfiguration(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
