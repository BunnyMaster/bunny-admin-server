package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.configuration.WebConfigurationVo;
import cn.bunny.services.service.ConfigurationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@Tag(name = "系统配置", description = "系统配置相关接口")
@RestController
@RequestMapping("/admin/config")
public class ConfigurationController {

    @Autowired
    private ConfigurationService configurationService;

    @SneakyThrows
    @Operation(summary = "读取web配置文件", description = "读取web配置文件")
    @GetMapping("noAuth/webConfig")
    public WebConfiguration webConfig() {
        return configurationService.webConfig();
    }

    @SneakyThrows
    @Operation(summary = "获取修改web配置文件", description = "获取修改web配置文件")
    @GetMapping("getWebConfig")
    public Mono<Result<WebConfigurationVo>> getWebConfig() {
        WebConfigurationVo webConfiguration = configurationService.getWebConfig();
        return Mono.just(Result.success(webConfiguration));
    }

    @Operation(summary = "更新web配置文件", description = "更新web配置文件")
    @PutMapping("updateWebConfiguration")
    public Mono<Result<String>> updateWebConfiguration(@Valid @RequestBody WebConfigurationDto dto) {
        configurationService.updateWebConfiguration(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

}
