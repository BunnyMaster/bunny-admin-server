package cn.bunny.services.controller.system;

import cn.bunny.services.domain.common.constant.RedisUserConstant;
import com.alibaba.fastjson2.JSONObject;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserControllerTest {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Test
    void test() {
        // Set<String> keys = redisTemplate.keys("admin::login_info::*");
        // for (String key : keys) {
        //     System.out.println(key);
        // }

        Map<String, Object> adminLoginInfoWithScan = getAdminLoginInfoWithScan();
        JSONObject adminLoginInfo = new JSONObject(adminLoginInfoWithScan);
        System.out.println(adminLoginInfo);
    }

    public Map<String, Object> getAdminLoginInfoWithScan() {
        String pattern = "admin::login_info::*";
        Map<String, Object> result = new HashMap<>();

        // 使用scan命令迭代查找
        ScanOptions options = ScanOptions.scanOptions().match(pattern).count(100).build();
        Cursor<String> cursor = redisTemplate.scan(options);

        while (cursor.hasNext()) {
            String key = cursor.next();
            Object value = redisTemplate.opsForValue().get(key);
            result.put(key, value);
        }

        try {
            cursor.close();
        } catch (Exception e) {
            // 处理异常
        }

        return result;
    }
}