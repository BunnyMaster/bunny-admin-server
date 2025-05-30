package cn.bunny.domain.common.constant;

import lombok.Data;

/**
 * Redis用户前缀设置
 */
@Data
public class RedisUserConstant {
    // 过期时间
    public static final Long REDIS_EXPIRATION_TIME = 7L;// 7 天/分钟 Redis过期
    public static final Integer Cookie_EXPIRATION_TIME = 5 * 60 * 60;// cookies 过期时间 5 分钟
    public static final String WEB_CONFIG_KEY = "webConfig::platformConfig";// web配置

    /* 用户登录前缀 */
    private static final String USER_LOGIN_INFO_PREFIX = "user::login_info::";

    /* 用户邮箱验证码前缀 */
    private static final String USER_EMAIL_CODE_PREFIX = "user::email_code::";

    /* 用户角色前缀 */
    private static final String USER_ROLES_CODE_PREFIX = "user::roles::";

    /* 用户权限前缀 */
    private static final String USER_PERMISSION_CODE_PREFIX = "user::permission::";

    /**
     * 用户登录前缀
     *
     * @param user 用户名信息
     * @return 格式化后缓存前缀
     */
    public static String getUserLoginInfoPrefix(String user) {
        return USER_LOGIN_INFO_PREFIX + user;
    }

    /**
     * 用户邮箱前缀
     *
     * @param user 用户信息
     * @return 邮箱验证码前缀
     */
    public static String getUserEmailCodePrefix(String user) {
        return USER_EMAIL_CODE_PREFIX + user;
    }

    /**
     * 用户角色前缀
     *
     * @param user 用户信息
     * @return 格式化后用户角色前缀
     */
    public static String getUserRolesCodePrefix(String user) {
        return USER_ROLES_CODE_PREFIX + user;
    }

    /**
     * 用户权限前缀
     *
     * @param user 用户信息
     * @return 格式化后用户权限前缀
     */
    public static String getUserPermissionCodePrefix(String user) {
        return USER_PERMISSION_CODE_PREFIX + user;
    }

}
