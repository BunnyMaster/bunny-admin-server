package cn.bunny.api.security.service;

import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.entity.Role;
import cn.bunny.system.mapper.PermissionMapper;
import cn.bunny.system.mapper.RoleMapper;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Service
public class UserAuthorizationCacheService {

    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 根据用户ID和用户名获取角色列表（缓存优先）
     *
     * <p><b>执行逻辑</b>：</p>
     * <ol>
     *   <li>尝试从Redis缓存获取用户角色（使用用户名作为缓存key）</li>
     *   <li>若缓存未命中，则从数据库查询并写入缓存（有效期1天）</li>
     *   <li>若缓存命中，反序列化缓存数据返回</li>
     * </ol>
     *
     * @param userId   用户ID（数据库查询用）
     * @param username 用户名（缓存key生成用）
     * @return 用户角色列表
     */
    public List<Role> getRolesByUser(Long userId, String username) {
        // 角色列表
        List<Role> roleList;

        // 尝试从缓存中获取当前用户角色
        String userRolesCodePrefix = RedisUserConstant.getUserRolesCodePrefix(username);
        Object object = redisTemplate.opsForValue().get(userRolesCodePrefix);

        // 为空查询数据库，并将信息存入Redis
        if (Objects.isNull(object)) {
            roleList = roleMapper.selectListByUserId(userId);
            redisTemplate.opsForValue().set(userRolesCodePrefix, roleList, 1, TimeUnit.DAYS);
        }
        // 从缓存中得到当前用户的角色列表
        else {
            String jsonString = JSON.toJSONString(object);
            TypeReference<List<Role>> reference = new TypeReference<>() {
            };
            List<Role> list = JSON.parseObject(jsonString, reference);
            // 防止 list 为空报错
            roleList = list != null ? list : new ArrayList<>();
        }

        return roleList;
    }

    /**
     * 根据用户ID和用户名获取权限列表（缓存优先）
     *
     * <p><b>执行逻辑</b>：</p>
     * <ol>
     *   <li>尝试从Redis缓存获取用户权限（使用用户名作为缓存key）</li>
     *   <li>若缓存未命中，则从数据库查询并写入缓存（有效期1天）</li>
     *   <li>若缓存命中，反序列化缓存数据返回</li>
     * </ol>
     *
     * @param userId   用户ID（数据库查询用）
     * @param username 用户名（缓存key生成用）
     * @return 用户权限列表
     */
    public List<Permission> getPermissionsByUser(Long userId, String username) {
        // 权限列表
        List<Permission> permissionList;

        // 获取缓存中的用户权限
        String userPermissionCodePrefix = RedisUserConstant.getUserPermissionCodePrefix(username);
        Object object = redisTemplate.opsForValue().get(userPermissionCodePrefix);

        // 为空查询数据库，并将用户权限放在Redis中
        if (Objects.isNull(object)) {
            permissionList = permissionMapper.selectListByUserId(userId);
            redisTemplate.opsForValue().set(userPermissionCodePrefix, permissionList, 1, TimeUnit.DAYS);
        }
        // 从缓存中得到当前用户权限
        else {
            String jsonString = JSON.toJSONString(object);
            TypeReference<List<Permission>> reference = new TypeReference<>() {
            };
            List<Permission> list = JSON.parseObject(jsonString, reference);
            // 防止 list 为空报错
            permissionList = list != null ? list : new ArrayList<>();
        }

        return permissionList;
    }
}
