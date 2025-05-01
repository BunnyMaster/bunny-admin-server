package system;

import cn.bunny.services.controller.system.UserController;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.service.system.impl.UserServiceImpl;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisConnectionUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = UserServiceImpl.class)
class UserServiceTest {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Test
    void test() {
        String prefix = RedisUserConstant.getAdminUserEmailCodePrefix("");
        Set<String> keys = redisTemplate.keys(prefix);
        for (String key : keys) {
            System.out.println(key);
        }
    }
}