package cn.bunny.services.core.cache;

import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import jakarta.annotation.Resource;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class EmailCacheService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 存储邮箱验证码
     *
     * @param email     邮箱
     * @param emailCode 邮箱验证码
     */
    public void buildEmailCodeCache(@NotNull String email, String emailCode) {
        // 在Redis中存储验证码
        String emailCodePrefix = RedisUserConstant.getUserEmailCodePrefix(email);
        redisTemplate.opsForValue().set(emailCodePrefix, emailCode, RedisUserConstant.REDIS_EXPIRATION_TIME, TimeUnit.MINUTES);
    }

    /**
     * 获取邮箱验证码
     *
     * @param email 邮箱
     * @return 邮箱验证码
     */
    public String getEmailCode(@NotNull String email) {
        String userEmailCodePrefix = RedisUserConstant.getUserEmailCodePrefix(email);
        Object emailCode = redisTemplate.opsForValue().get(userEmailCodePrefix);

        if (emailCode == null) {
            throw new UsernameNotFoundException(ResultCodeEnum.EMAIL_CODE_EMPTY.getMessage());
        }

        return emailCode.toString();
    }

    /**
     * 清除邮箱验证码
     *
     * @param email 邮箱
     */
    public void deleteEmailCodeCache(String email) {
        String emailCodePrefix = RedisUserConstant.getUserEmailCodePrefix(email);
        redisTemplate.delete(emailCodePrefix);
    }

}
