package cn.bunny.services.service;

import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.vo.configuration.WebConfigurationVo;

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

    /**
     * 获取修改web配置文件
     *
     * @return 要修改前端配置文件
     */
    WebConfigurationVo getWebConfig();
}