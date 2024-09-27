package cn.bunny.common.service.utils;

import cn.bunny.common.service.exception.BunnyException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;

@Slf4j
public class EmptyUtil {
    /**
     * 是否为空
     *
     * @param value   判断值
     * @param message 错误消息
     */
    public static void isEmpty(Object value, String message) {
        if (value == null || !StringUtils.hasText(value.toString())) {
            log.error("为空对象错误：{}，{}", value, message);
            throw new BunnyException(message);
        }
    }
}
