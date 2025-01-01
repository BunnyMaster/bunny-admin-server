package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.vo.configuration.WebConfigurationVo;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.ConfigurationService;
import com.alibaba.fastjson2.JSON;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

@Service
public class ConfigurationServiceImpl implements ConfigurationService {

    @Value("${bunny.bashPath}")
    private String bashPath;

    private static @NotNull String getWebConfigString(InputStream inputStream, Path templatePath) throws IOException {
        if (inputStream == null) throw new AuthCustomerException(ResultCodeEnum.MISSING_TEMPLATE_FILES);

        // 判断web模板文件是否存在，不存在进行复制
        boolean exists = Files.exists(templatePath);
        if (!exists) Files.copy(inputStream, templatePath);

        // 将读取文件返回
        byte[] bytes = Files.readAllBytes(templatePath);
        return new String(bytes);
    }

    /**
     * * 更新web配置
     *
     * @param dto 前端配置选项
     */
    @Override
    @CacheEvict(cacheNames = "webConfig", key = "'platformConfig'", beforeInvocation = true, cacheManager = "cacheManagerWithMouth")
    public void updateWebConfiguration(WebConfigurationDto dto) {
        try {
            // 系统模板文件位置
            Path templatePath = Path.of(bashPath + "/platform-config.json");

            // 提交表单转换
            WebConfiguration webConfiguration = new WebConfiguration();
            BeanUtils.copyProperties(dto, webConfiguration);

            // 将表单转成存储的类型
            WebConfigurationVo webConfigurationVo = new WebConfigurationVo();
            BeanUtils.copyProperties(webConfiguration, webConfigurationVo);

            // 将文件写入
            String jsonString = JSON.toJSONString(webConfigurationVo);
            Files.writeString(templatePath, jsonString);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 读取web配置文件
     *
     * @return 前端配置文件
     */
    @Override
    @Cacheable(cacheNames = "webConfig", key = "'platformConfig'", cacheManager = "cacheManagerWithMouth")
    public WebConfiguration webConfig() {
        // 系统模板文件位置
        Path templatePath = Path.of(bashPath + "/platform-config.json");

        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/platform-config.json")) {
            String string = getWebConfigString(inputStream, templatePath);
            return JSON.parseObject(string, WebConfiguration.class);
        } catch (IOException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }

    /**
     * 获取修改web配置文件
     *
     * @return 要修改前端配置文件
     */
    @Override
    public WebConfigurationVo getWebConfig() {
        // 系统模板文件位置
        Path templatePath = Path.of(bashPath + "/platform-config.json");

        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/platform-config.json")) {
            String string = getWebConfigString(inputStream, templatePath);
            return JSON.parseObject(string, WebConfigurationVo.class);
        } catch (IOException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }
}
