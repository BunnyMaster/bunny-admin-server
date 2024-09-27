package cn.bunny.dao.pojo.constant;

import lombok.Data;

/**
 * Redis用户前缀设置
 */
@Data
public class RedisUserConstant {
    // 过期时间
    public static final Long REDIS_EXPIRATION_TIME = 15L;// 15 天/分钟 Redis过期
    public static final Integer Cookie_EXPIRATION_TIME = 5 * 60 * 60;// cookies 过期时间 5 分钟

    private static final String ADMIN_LOGIN_INFO_PREFIX = "admin::login_info::";
    private static final String ADMIN_EMAIL_CODE_PREFIX = "admin::email_code::";
    private static final String USER_LOGIN_INFO_PREFIX = "user::login_info::";
    private static final String USER_EMAIL_CODE_PREFIX = "user::email_code::";

    public static String getAdminLoginInfoPrefix(String adminUser) {
        return ADMIN_LOGIN_INFO_PREFIX + adminUser;
    }

    public static String getAdminUserEmailCodePrefix(String adminUser) {
        return ADMIN_EMAIL_CODE_PREFIX + adminUser;
    }

    public static String getUserLoginInfoPrefix(String user) {
        return USER_LOGIN_INFO_PREFIX + user;
    }

    public static String getUserEmailCodePrefix(String user) {
        return USER_EMAIL_CODE_PREFIX + user;
    }
}
