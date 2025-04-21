package cn.bunny.services.service.configuration;


import cn.bunny.domain.configuration.dto.WebConfigurationDto;
import cn.bunny.domain.configuration.entity.WebConfiguration;

public interface ConfigurationService {

    /**
     * * 更新web配置
     *
     * @param dto 前端配置选项
     */
    void updateWebConfiguration(WebConfigurationDto dto);

    /**
     * 读取web配置文件
     *
     * @return 前端配置文件
     */
    WebConfiguration webConfig();

}