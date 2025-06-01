package cn.bunny.core.utils;

import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.core.exception.AuthCustomerException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.micrometer.common.lang.Nullable;
import org.springframework.util.StringUtils;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class JwtTokenUtil {
    // JWT 的 秘钥
    // static SecretKey key = new SecretKeySpec("Bunny-Java-Template".getBytes(), "AES");
    private static final SecretKey key = Keys.hmacShaKeyFor("Bunny-Auth-Server-Private-SecretKey".getBytes(StandardCharsets.UTF_8));
    // 时间 按天 计算
    private static final long tokenExpiration = 24 * 60 * 60 * 1000;
    // 默认主题
    private static final String subject = "Bunny";
    // 默认时间
    private static final Date time = new Date(System.currentTimeMillis() + tokenExpiration * 7);

    /**
     * 使用默认主题，默认时间，默认秘钥，创建自定义集合token
     *
     * @param map 集合
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map) {
        return Jwts.builder()
                .subject(subject)
                .expiration(time)
                .signWith(key)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 使用默认主题，默认秘钥，自定义时间，创建集合形式token
     *
     * @param map  集合
     * @param time 过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, Date time) {
        return Jwts.builder()
                .subject(subject)
                .signWith(key)
                .expiration(time)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 使用默认主题，默认秘钥，自定义时间，创建集合形式token
     *
     * @param map 集合
     * @param day 过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, Integer day) {
        return Jwts.builder()
                .subject(subject)
                .signWith(key)
                .expiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .claims(map)
                .id(UUID.randomUUID().toString())
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 使用默认主题，默认秘钥，自定义key，创建集合形式token
     *
     * @param map          集合
     * @param tokenSignKey 自定义key
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String tokenSignKey) {

        return Jwts.builder()
                .subject(subject)
                .expiration(time)
                .signWith(key)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 使用自定义主题，自定义时间，创建集合形式token
     *
     * @param map     集合
     * @param subject 主题
     * @param time    过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String subject, Date time) {
        return Jwts.builder()
                .subject(subject)
                .expiration(time)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 创建集合形式token
     *
     * @param map          集合
     * @param subject      主题
     * @param tokenSignKey 过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String subject, String tokenSignKey) {
        return Jwts.builder()
                .subject(subject)
                .expiration(time)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 创建集合形式token
     *
     * @param map          集合
     * @param tokenSignKey 主题
     * @param time         过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String tokenSignKey, Integer time) {
        return Jwts.builder()
                .subject(subject)
                .expiration(new Date(System.currentTimeMillis() + tokenExpiration * time))
                .claims(map)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 创建集合形式token
     *
     * @param map     集合
     * @param subject 主题
     * @param day     过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String subject, String tokenSignKey, Integer day) {
        return Jwts.builder()
                .subject(subject)
                .expiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .claims(map)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 创建集合形式token
     *
     * @param map     集合
     * @param subject 主题
     * @param time    过期时间
     * @return token
     */
    public static String createTokenWithMap(Map<String, Object> map, String subject, String tokenSignKey, Date time) {
        return Jwts.builder()
                .subject(subject)
                .expiration(time)
                .claims(map)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 根据用户名和ID创建token
     *
     * @param userId   用户ID
     * @param username 用户名
     * @param day      过期时间
     * @return token值
     */
    public static String createToken(Long userId, String username, Integer day) {
        return Jwts.builder()
                .subject(subject)
                .expiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .claim("userId", userId)
                .claim("username", username)
                .id(UUID.randomUUID().toString())
                .signWith(key)
                .compressWith(Jwts.ZIP.GZIP).compact();
    }

    /**
     * 使用token获取map集合,使用默认秘钥
     *
     * @param token token
     * @return map集合
     */
    public static Map<String, Object> getMapByToken(String token) {
        try {
            if (!StringUtils.hasText(token)) throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
            Claims claims = Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
            // 将 body 值转为map
            return new HashMap<>(claims);

        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
        }
    }

    /**
     * 使用token获取map集合
     *
     * @param token   token
     * @param signKey 秘钥
     * @return map集合
     */
    public static Map<String, Object> getMapByToken(String token, String signKey) {
        try {
            if (!StringUtils.hasText(token)) throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
            Jws<Claims> claimsJws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            Claims body = claimsJws.getPayload();
            // 将 body 值转为map
            return new HashMap<>(body);

        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
        }
    }

    @Nullable
    private static String getSubjectByTokenHandler(String token) {
        try {
            if (!StringUtils.hasText(token)) throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
            Jws<Claims> claimsJws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            Claims body = claimsJws.getPayload();

            return body.getSubject();

        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
        }
    }

    /**
     * 根据token获取主题
     *
     * @param token token
     * @return 主题
     */
    public static String getSubjectByToken(String token) {
        return getSubjectByTokenHandler(token);
    }

    /**
     * 根据token获取用户ID
     *
     * @param token token
     * @return 用户ID
     */
    public static Long getUserId(String token) {
        try {
            if (!StringUtils.hasText(token)) throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);

            Jws<Claims> claimsJws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            Claims claims = claimsJws.getPayload();

            return Long.valueOf(String.valueOf(claims.get("userId")));
        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
        }
    }

    /**
     * 根据token获取用户名
     *
     * @param token token
     * @return 用户名
     */
    public static String getUsername(String token) {
        try {
            if (!StringUtils.hasText(token)) return "";

            Jws<Claims> claimsJws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            Claims claims = claimsJws.getPayload();
            return (String) claims.get("username");
        } catch (Exception exception) {
            throw new AuthCustomerException(ResultCodeEnum.TOKEN_PARSING_FAILED);
        }
    }

    /**
     * 判断token是否过期
     *
     * @param token token
     * @return 是否过期
     */
    public static boolean isExpired(String token) {
        return isExpiredUtil(token);
    }

    /**
     * 判断是否过期
     *
     * @param token token
     * @return 是否过期
     */
    private static boolean isExpiredUtil(String token) {
        try {
            Jws<Claims> claimsJws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            Date expiration = claimsJws.getPayload().getExpiration();

            return expiration != null && expiration.before(new Date());
        } catch (Exception exception) {
            exception.printStackTrace();
            return true;
        }
    }
}