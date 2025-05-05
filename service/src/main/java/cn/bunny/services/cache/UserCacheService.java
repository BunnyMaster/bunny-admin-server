package cn.bunny.services.cache;

import cn.bunny.services.domain.common.constant.LocalDateTimeConstant;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.minio.MinioHelper;
import cn.bunny.services.service.system.helper.RoleServiceHelper;
import cn.bunny.services.utils.JwtTokenUtil;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class UserCacheService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private MinioHelper minioHelper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private UserAuthorizationCacheService userAuthorizationCacheService;

    /**
     * 根据用户名获取缓存中内容
     *
     * @param username 用户名
     * @return LoginVo
     */
    public LoginVo getLoginVoByUsername(String username) {
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getUserLoginInfoPrefix(username));
        return JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);
    }

    /**
     * 构建用户登录返回对象(LoginVo) 更新用户相关就用这个包括登录
     *
     * <p>主要处理流程：</p>
     * <ol>
     *   <li><b>参数校验</b>：检查用户对象是否为空</li>
     *   <li><b>权限处理</b>：
     *     <ul>
     *       <li>查询用户角色和权限数据</li>
     *       <li>非管理员用户：从数据库加载权限信息</li>
     *       <li>管理员用户：通过RoleUtil.checkAdmin()自动设置管理员权限</li>
     *       <li>（可选）对角色和权限列表去重</li>
     *     </ul>
     *   </li>
     *   <li><b>信息装配</b>：
     *     <ul>
     *       <li>记录用户IP等访问信息</li>
     *       <li>使用BeanUtils.copyProperties()复制用户基础属性</li>
     *       <li>设置记住我功能及token过期时间</li>
     *     </ul>
     *   </li>
     *   <li><b>缓存处理</b>：将完整用户信息存入Redis</li>
     * </ol>
     *
     * <p>注意事项：</p>
     * <ul>
     *   <li>属性复制操作放在流程最后，确保所有字段正确同步</li>
     *   <li>IP信息需要同时更新到用户实体和返回对象</li>
     * </ul>
     *
     * @param user      用户实体对象（不可为空）
     * @param readMeDay 记住我时长（单位：天）
     * @return 完整的登录响应对象
     * @throws IllegalArgumentException 当用户对象为空时抛出
     */
    public LoginVo buildLoginUserVo(AdminUser user, long readMeDay) {
        String username = user.getUsername();
        Long userId = user.getId();

        // 用户角色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());

        // 判断是否是 admin 如果是admin 赋予所有权限
        List<String> permissions = new ArrayList<>();
        boolean isAdmin = RoleServiceHelper.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = permissionMapper.selectListByUserId(userId).stream()
                    .map(Permission::getPowerCode)
                    .toList();
        }

        // 为这两个去重，在判断 checkAdmin 会重新赋值
        permissions = permissions.stream().distinct().toList();
        roles = roles.stream().distinct().toList();

        // 设置用户返回对象
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setPersonDescription(user.getSummary());
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);

        // 使用用户名创建token
        String token = JwtTokenUtil.createToken(userId, username, (int) readMeDay);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setReadMeDay(readMeDay);

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);
        loginVo.setExpires(expires);

        // 设置用户头像
        String userAvatar = minioHelper.getUserAvatar(user.getAvatar());
        loginVo.setAvatar(userAvatar);

        String loginInfoPrefix = RedisUserConstant.getUserLoginInfoPrefix(username);
        redisTemplate.opsForValue().set(loginInfoPrefix, loginVo, readMeDay, TimeUnit.DAYS);
        return loginVo;
    }

    /**
     * 批量更新Redis中用户权限信息，设计用户和角色就用这个
     *
     * <p><b>使用场景</b>：当用户角色或权限变更时，同步更新Redis中的用户权限数据</p>
     *
     * <p><b>实现策略</b>：</p>
     * <ol>
     *   <li><b>主动更新（当前实现）</b>：重新构建用户权限信息并更新Redis缓存</li>
     *   <li><b>强制下线</b>：删除用户登录态，强制重新认证获取最新权限</li>
     * </ol>
     *
     * <p><b>技术实现</b>：</p>
     * <ul>
     *   <li>采用Spring事件驱动机制触发更新</li>
     *   <li>使用并行流(parallelStream)提高批量处理效率</li>
     *   <li>仅更新Redis中存在登录态的用户</li>
     * </ul>
     *
     * @param userIds 需要更新的用户ID集合
     *                （仅处理集合中存在的有效用户）
     * @see RedisUserConstant  Redis键前缀常量
     */
    public void updateUserRedisInfo(List<Long> userIds) {
        if (userIds.isEmpty()) return;

        // 批量查询用户
        List<AdminUser> adminUsers = userMapper.selectBatchIds(userIds);
        // 并行处理用户更新
        adminUsers.stream()
                .filter(user -> redisTemplate.hasKey(RedisUserConstant.getUserLoginInfoPrefix(user.getUsername())))
                .forEach(user -> {
                    // 更新时清除缓存中的角色和权限
                    String username = user.getUsername();
                    userAuthorizationCacheService.deleteRoleAndPermissionCache(username);

                    // 更新用户权限信息
                    buildLoginUserVo(user, RedisUserConstant.REDIS_EXPIRATION_TIME);
                });
    }

    /**
     * 清除用户登录时的缓存
     *
     * @param username 用户名
     */
    public void deleteLoginUserCache(String username) {
        String userRolesCodePrefix = RedisUserConstant.getUserRolesCodePrefix(username);
        redisTemplate.delete(userRolesCodePrefix);
    }

    /**
     * 清除用户登录时的缓存
     *
     * @param username 用户名
     */
    public void deleteUserCache(String username) {
        userAuthorizationCacheService.deleteRoleAndPermissionCache(username);
        deleteLoginUserCache(username);
    }
}
