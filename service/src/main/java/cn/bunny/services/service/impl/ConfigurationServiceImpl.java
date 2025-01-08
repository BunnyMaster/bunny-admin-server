package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.ConfigurationService;
import com.alibaba.fastjson2.JSON;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;

@Service
@Transactional
public class ConfigurationServiceImpl implements ConfigurationService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * * 更新web配置
     *
     * @param dto 前端配置选项
     */
    @Override
    public void updateWebConfiguration(WebConfigurationDto dto) {
        redisTemplate.delete(RedisUserConstant.WEB_CONFIG_KEY);

        // 提交表单转换
        WebConfiguration webConfiguration = new WebConfiguration();
        BeanUtils.copyProperties(dto, webConfiguration);

        redisTemplate.opsForValue().set(RedisUserConstant.WEB_CONFIG_KEY, webConfiguration);
    }

    /**
     * 读取web配置文件
     *
     * @return 前端配置文件
     */
    @Override
    public WebConfiguration webConfig() {
        // 判断Redis中是否存在
        Object object = redisTemplate.opsForValue().get(RedisUserConstant.WEB_CONFIG_KEY);
        if (object != null) {
            String jsonString = JSON.toJSONString(object);
            return JSON.parseObject(jsonString, WebConfiguration.class);
        }

        // 不存在从文件中获取
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/platform-config.json")) {
            if (inputStream == null) throw new AuthCustomerException(ResultCodeEnum.MISSING_TEMPLATE_FILES);

            // 读取文件返回并存入Redis
            byte[] bytes = inputStream.readAllBytes();
            WebConfiguration webConfiguration = JSON.parseObject(new String(bytes), WebConfiguration.class);
            redisTemplate.opsForValue().set(RedisUserConstant.WEB_CONFIG_KEY, webConfiguration);

            return webConfiguration;
        } catch (IOException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }
}
