package cn.bunny.services.service.system.helper;

import cn.bunny.services.domain.common.constant.LocalDateTimeConstant;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.constant.UserConstant;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.system.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.mapper.log.UserLoginLogMapper;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.minio.MinioHelper;
import cn.bunny.services.service.system.helper.role.RoleHelper;
import cn.bunny.services.utils.IpUtil;
import cn.bunny.services.utils.JwtTokenUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@Transactional
public class UserLoginHelper {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource
    private UserMapper userMapper;
    @Resource
    private UserLoginLogMapper userLoginLogMapper;
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private PermissionMapper permissionMapper;
    @Resource
    private MinioHelper minioHelper;

    /**
     * 构建用户登录返回对象(LoginVo)
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
        boolean isAdmin = RoleHelper.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = permissionMapper.selectListByUserId(userId).stream()
                    .map(Permission::getPowerCode)
                    .toList();
        }
        // 为这两个去重
        permissions = permissions.stream().distinct().toList();
        roles = roles.stream().distinct().toList();

        // 获取IP地址并更新用户登录信息，
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();
        // 设置用户IP地址，并更新用户信息
        user.setIpAddress(ipAddr);
        user.setIpRegion(ipRegion);
        userMapper.updateById(user);

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

        // 将用户登录保存在用户登录日志表中
        setUserLoginLog(user, token, UserConstant.LOGIN);

        // 将信息保存在Redis中，一定要确保用户名是唯一的
        String loginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(username);
        redisTemplate.opsForValue().set(loginInfoPrefix, loginVo, readMeDay, TimeUnit.DAYS);

        return loginVo;
    }

    /**
     * 设置用户登录日志内容
     * <p>
     * 该方法用于将管理员用户信息复制到用户登录日志对象中，同时处理特殊字段映射关系。
     * <p>
     * 实现说明：
     * 1. 使用BeanUtils.copyProperties()复制属性时，会自动将AdminUser.id复制到UserLoginLog.id
     * 2. 由于UserLoginLog实际需要的是userId字段而非id字段，需要特殊处理：
     * - 先进行属性复制
     * - 然后将UserLoginLog.userId设置为AdminUser.id
     * - 最后将UserLoginLog.id显式设为null（避免自动生成的id被覆盖）
     *
     * @param user  管理员用户实体对象，包含用户基本信息
     * @param token 本次登录/退出的认证令牌
     * @param type  操作类型（LOGIN-登录/LOGOUT-退出）
     */
    public void setUserLoginLog(AdminUser user, String token, String type) {
        UserLoginLog userLoginLog = new UserLoginLog();
        BeanUtils.copyProperties(user, userLoginLog);
        userLoginLog.setUserId(user.getId());
        userLoginLog.setId(null);
        userLoginLog.setToken(token);
        userLoginLog.setType(type);

        // 当前请求request
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = requestAttributes.getRequest();

            // 获取User-Agent
            String userAgent = request.getHeader("User-Agent");
            userLoginLog.setUserAgent(userAgent);

            // 获取X-Requested-With
            String xRequestedWith = request.getHeader("X-Requested-With");
            userLoginLog.setXRequestedWith(xRequestedWith);
        }

        userLoginLogMapper.insert(userLoginLog);
    }

}
