package cn.bunny.services.core.cache;

import cn.bunny.domain.common.constant.RedisUserConstant;
import jakarta.annotation.Resource;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class RedisService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 分页扫描Redis中匹配特定前缀的key
     *
     * @param pageNum  当前页码（从1开始）
     * @param pageSize 每页大小
     * @return 当前页的key列表
     */
    @NotNull
    public List<String> scannerRedisKeyByPage(long pageNum, long pageSize) {
        String prefix = RedisUserConstant.getUserLoginInfoPrefix("*");

        List<String> keys = new ArrayList<>();
        ScanOptions scanOptions = ScanOptions.scanOptions()
                .match(prefix)  // 匹配前缀
                .count(1000)  // 每次扫描的 key 数量（优化性能）
                .build();

        try (Cursor<String> cursor = redisTemplate.scan(scanOptions)) {
            int skip = Math.toIntExact((pageNum - 1) * pageSize);
            int count = 0;
            while (cursor.hasNext()) {
                String key = cursor.next();
                if (count >= skip && keys.size() < pageSize) {
                    keys.add(key);
                }
                count++;
            }
        }
        return keys;
    }

}
