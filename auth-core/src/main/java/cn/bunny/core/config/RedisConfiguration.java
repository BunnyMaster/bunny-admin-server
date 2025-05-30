package cn.bunny.core.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 设置Redis序列化
 */
@Component
@Slf4j
public class RedisConfiguration {
    /**
     * 使用StringRedisSerializer序列化为字符串
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(LettuceConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(connectionFactory);
        
        // 设置key序列化为string
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());

        // 设置value序列化为JSON，使用GenericJackson2JsonRedisSerializer替换默认序列化
        redisTemplate.setValueSerializer(jsonRedisSerializer());
        redisTemplate.setHashValueSerializer(jsonRedisSerializer());

        // 开启Redis事务
        redisTemplate.setEnableTransactionSupport(true);
        return redisTemplate;
    }

    /**
     * * 配置Redis过期时间
     * 一个月
     * 解决cache(@Cacheable)把数据缓存到redis中的value是乱码问题
     */
    @Bean
    @Primary
    @SuppressWarnings("all")
    public CacheManager cacheManagerWithMouth(RedisConnectionFactory factory) {
        // 配置序列化
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig()
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jsonRedisSerializer()))
                .entryTtl(Duration.ofDays(30));

        return RedisCacheManager.builder(factory).cacheDefaults(config).build();
    }

    /**
     * * 配置redis过期时间
     * 半个月
     *
     * @param factory
     * @return
     */
    @Bean
    @SuppressWarnings("all")
    public CacheManager cacheManagerWithHalfOfMouth(RedisConnectionFactory factory) {
        // 配置序列化
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig()
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jsonRedisSerializer()))
                .entryTtl(Duration.ofDays(15));

        return RedisCacheManager.builder(factory).cacheDefaults(config).build();
    }

    /**
     * * 配置Redis过期时间1小时
     *
     * @param factory
     * @return
     */
    @Bean
    @SuppressWarnings("all")
    public CacheManager cacheManagerWithHours(RedisConnectionFactory factory) {
        // 配置序列化
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig()
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jsonRedisSerializer()))
                .entryTtl(Duration.ofHours(1));

        return RedisCacheManager.builder(factory).cacheDefaults(config).build();
    }

    /**
     * 指定的日期模式
     */
    public Jackson2JsonRedisSerializer<Object> jsonRedisSerializer() {
        // LocalDatetime序列化，默认不兼容jdk8日期序列化
        JavaTimeModule timeModule = new JavaTimeModule();
        timeModule.addDeserializer(LocalDate.class, new LocalDateDeserializer(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        timeModule.addSerializer(LocalDate.class, new LocalDateSerializer(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        timeModule.addDeserializer(LocalDateTime.class, new LocalDateTimeDeserializer(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        timeModule.addSerializer(LocalDateTime.class, new LocalDateTimeSerializer(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        // 对象序列化
        ObjectMapper mapper = new ObjectMapper();

        // 设置ObjectMapper访问权限
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        // 关闭默认的日期格式化方式，默认UTC日期格式 yyyy-MM-dd’T’HH:mm:ss.SSS
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        mapper.registerModule(timeModule);

        return new Jackson2JsonRedisSerializer<>(mapper, Object.class);
    }
}
