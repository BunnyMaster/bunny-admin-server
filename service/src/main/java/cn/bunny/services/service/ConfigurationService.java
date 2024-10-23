package cn.bunny.services.service;

import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;

public interface ConfigurationService {

    /**
     * * 更新web配置
     *
     * @param dto 前端配置选项
     */
    void updateWebConfiguration(WebConfigurationDto dto);
}
