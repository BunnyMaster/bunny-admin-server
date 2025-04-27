package cn.bunny.services.utils.system;

import cn.bunny.domain.constant.LocalDateTimeConstant;
import cn.bunny.domain.constant.MinioConstant;
import cn.bunny.domain.constant.RedisUserConstant;
import cn.bunny.domain.constant.UserConstant;
import cn.bunny.domain.files.dto.FileUploadDto;
import cn.bunny.domain.files.vo.FileInfoVo;
import cn.bunny.domain.log.entity.UserLoginLog;
import cn.bunny.domain.system.dto.user.AdminUserUpdateDto;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.entity.Role;
import cn.bunny.domain.vo.LoginVo;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.log.UserLoginLogMapper;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.service.system.FilesService;
import cn.bunny.services.utils.JwtHelper;
import cn.bunny.services.utils.ip.IpUtil;
import cn.bunny.services.utils.minio.MinioUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class UserUtil {

    @Resource
    private MinioUtil minioUtil;
    @Resource
    private PermissionMapper permissionMapper;
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private UserLoginLogMapper userLoginLogMapper;
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource
    private PasswordEncoder passwordEncoder;
    @Resource
    private FilesService filesService;

    /**
     * 构建登录用户返回对象
     *
     * @param user      用户
     * @param readMeDay 保存登录信息时间
     * @return 登录信息
     */
    @Transactional(rollbackFor = AuthCustomerException.class)
    public LoginVo buildLoginUserVo(AdminUser user, long readMeDay) {
        Long userId = user.getId();
        String email = user.getEmail();
        String username = user.getUsername();

        // 使用用户名创建token
        String token = JwtHelper.createToken(userId, username, (int) readMeDay);

        // 获取IP地址并更新用户登录信息
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setIpAddress(ipAddr);
        updateUser.setIpRegion(ipRegion);
        userMapper.updateById(updateUser);

        // 将用户登录保存在用户登录日志表中
        userLoginLogMapper.insert(setUserLoginLog(user, token, ipAddr, ipRegion, "login"));

        // 设置用户返回信息
        LoginVo loginVo = setLoginVo(user, token, readMeDay, ipAddr, ipRegion);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        // 将信息保存在Redis中，一定要确保用户名是唯一的
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(username), loginVo, readMeDay, TimeUnit.DAYS);

        return loginVo;
    }

    /**
     * * 构建用户返回对象LoginVo
     *
     * @param user      用户对象
     * @param readMeDay 记住我时间
     */
    public void buildUserVo(AdminUser user, long readMeDay) {
        Long userId = user.getId();
        String username = user.getUsername();
        String loginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(username);

        // 使用用户名创建token
        String token = JwtHelper.createToken(userId, username, (int) readMeDay);

        // 设置用户返回信息
        LoginVo loginVo = setLoginVo(user, token, readMeDay, user.getIpAddress(), user.getIpRegion());

        // 将信息保存在Redis中，一定要确保用户名是唯一的
        redisTemplate.opsForValue().set(loginInfoPrefix, loginVo, readMeDay, TimeUnit.DAYS);
    }


    /**
     * 设置更新用户设置内容
     *
     * @param user      AdminUser
     * @param token     token
     * @param readMeDay 记住我天数
     * @param ipAddr    IP地址
     * @param ipRegion  IP属地
     * @return LoginVo
     */
    public LoginVo setLoginVo(AdminUser user, String token, long readMeDay, String ipAddr, String ipRegion) {
        Long userId = user.getId();

        // 判断用户是否有头像，如果没有头像设置默认头像，并且用户头像不能和默认头像相同
        String avatar = checkGetUserAvatar(user.getAvatar());

        // 查找用户橘色
        List<String> roles = new ArrayList<>(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).toList());
        List<String> permissions = new ArrayList<>();

        // 判断是否是 admin 如果是admin 赋予所有权限
        boolean isAdmin = RoleUtil.checkAdmin(roles, permissions, user);
        if (!isAdmin) {
            permissions = permissionMapper.selectListByUserId(userId).stream().map(Permission::getPowerCode).toList();
        }

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);

        // 构建返回对象，设置用户需要内容
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setNickname(user.getNickname());
        loginVo.setAvatar(avatar);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setIpAddress(ipAddr);
        loginVo.setIpRegion(ipRegion);
        loginVo.setRoles(roles);
        loginVo.setPermissions(permissions);
        loginVo.setUpdateUser(userId);
        loginVo.setPersonDescription(user.getSummary());
        loginVo.setExpires(expires);
        loginVo.setReadMeDay(readMeDay);

        return loginVo;
    }

    /**
     * 检查用户头像是否合规
     *
     * @param avatar 头像字符串
     * @return 整理好的头像内容
     */
    public String checkPostUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (!matcher.matches()) return avatar;

        // 匹配后返回内容
        return "/" + matcher.group(1);
    }

    /**
     * 检查用户头像是否合规
     *
     * @param avatar 头像字符串
     * @return 整理好的头像内容
     */
    public String checkGetUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (matcher.matches()) return avatar;

        // 匹配后返回内容
        return minioUtil.getObjectNameFullPath(avatar);
    }


    /**
     * 设置用户登录日志内容
     *
     * @param user     AdminUser
     * @param token    token
     * @param ipAddr   IP地址
     * @param ipRegion IP属地
     * @param type     类型登录/退出
     * @return UserLoginLog
     */
    public UserLoginLog setUserLoginLog(AdminUser user, String token, String ipAddr, String ipRegion, String type) {
        Long userId = user.getId();

        UserLoginLog userLoginLog = new UserLoginLog();
        userLoginLog.setUsername(user.getUsername());
        userLoginLog.setUserId(userId);
        userLoginLog.setIpAddress(ipAddr);
        userLoginLog.setIpRegion(ipRegion);
        userLoginLog.setToken(token);
        userLoginLog.setType(type);
        userLoginLog.setCreateUser(userId);
        userLoginLog.setUpdateUser(userId);
        userLoginLog.setCreateTime(LocalDateTime.now());
        userLoginLog.setUpdateTime(LocalDateTime.now());

        // 当前请求request
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (requestAttributes == null) return userLoginLog;
        HttpServletRequest request = requestAttributes.getRequest();

        // 获取User-Agent
        String userAgent = request.getHeader("User-Agent");
        userLoginLog.setUserAgent(userAgent);

        // 获取X-Requested-With
        String xRequestedWith = request.getHeader("X-Requested-With");
        userLoginLog.setXRequestedWith(xRequestedWith);

        return userLoginLog;
    }

    /**
     * * 管理员修改管理员用户密码
     *
     * @param adminUser 管理员用户修改密码
     */
    public void updateUserPasswordByAdmin(AdminUser adminUser) {
        Long userId = adminUser.getId();
        String password = adminUser.getPassword();

        // 密码更新是否存在
        if (!StringUtils.hasText(password)) return;

        // 对密码加密
        String encode = passwordEncoder.encode(password);

        // 判断新密码是否与旧密码相同
        if (adminUser.getPassword().equals(encode))
            throw new AuthCustomerException(ResultCodeEnum.UPDATE_NEW_PASSWORD_SAME_AS_OLD_PASSWORD);

        // 更新用户密码
        adminUser.setPassword(encode);
        adminUser.setId(userId);

        // 删除Redis中用户信息
        String loginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(adminUser.getUsername());
        redisTemplate.delete(loginInfoPrefix);
    }

    /**
     * 管理员上传用户头像
     *
     * @param dto 管理员用户修改头像
     */
    public void uploadAvatarByAdmin(AdminUserUpdateDto dto, AdminUser adminUser) {
        MultipartFile avatar = dto.getAvatar();
        Long userId = dto.getId();

        // 上传头像是否存在
        if (avatar == null) return;

        // 上传头像
        FileUploadDto uploadDto = FileUploadDto.builder().file(avatar).type(MinioConstant.avatar).build();
        FileInfoVo fileInfoVo = filesService.upload(uploadDto);

        // 更新用户
        adminUser.setId(userId);
        adminUser.setAvatar(fileInfoVo.getFilepath());
    }
}