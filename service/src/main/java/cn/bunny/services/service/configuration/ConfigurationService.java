package cn.bunny.services.service.configuration;


import cn.bunny.services.domain.system.configuration.dto.WebConfigurationDto;
import cn.bunny.services.domain.system.configuration.entity.WebConfiguration;

public interface ConfigurationService {

    /**
     * 更新web配置
     *
     * @param dto 前端配置选项
     */
    void updateWebConfiguration(WebConfigurationDto dto);

    /**
     * 读取web配置文件
     * 只存储在缓存中，重启应用失效
     * 永久修改需要修改后端
     *
     * @return 前端配置文件
     */
    WebConfiguration webConfig();

}