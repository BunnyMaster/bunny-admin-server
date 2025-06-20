package cn.bunny.configuration.service.impl;

import cn.bunny.configuration.service.ConfigurationService;
import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.configuration.dto.WebConfigurationDto;
import cn.bunny.domain.configuration.entity.WebConfiguration;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;

@Service
@Transactional
public class ConfigurationServiceImpl implements ConfigurationService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 更新web配置
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
     * 只存储在缓存中，重启应用失效
     * 永久修改需要修改后端
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
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/platform-config.json" )) {
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
