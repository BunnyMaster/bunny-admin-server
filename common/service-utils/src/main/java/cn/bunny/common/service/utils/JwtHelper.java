package cn.bunny.common.service.utils;

import io.jsonwebtoken.*;
import io.micrometer.common.lang.Nullable;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class JwtHelper {
    // 时间 按天 计算
    private static final long tokenExpiration = 24 * 60 * 60 * 1000;
    // JWT 的 秘钥
    private static final String tokenSignKey = "Bunny-Java-Template";
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
                .setSubject(subject)
                .setExpiration(time)
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .compressWith(CompressionCodecs.GZIP).compact();
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
                .setSubject(subject)
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .setExpiration(time)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .compressWith(CompressionCodecs.GZIP).compact();
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
                .setSubject(subject)
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .compressWith(CompressionCodecs.GZIP).compact();
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
                .setSubject(subject)
                .setExpiration(time)
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .compressWith(CompressionCodecs.GZIP).compact();
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
                .setSubject(subject)
                .setExpiration(time)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)
                .compact();
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
                .setSubject(subject)
                .setExpiration(time)
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .compressWith(CompressionCodecs.GZIP).compact();
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
                .setSubject(subject)
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration * time))
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)
                .compact();
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
                .setSubject(subject)
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)
                .compact();
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
                .setSubject(subject)
                .setExpiration(time)
                .setClaims(map)
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)
                .compact();
    }

    /**
     * 根据用户名和ID创建token
     *
     * @param userId   用户ID
     * @param userName 用户名
     * @param day      过期时间
     * @return token值
     */
    public static String createToken(Long userId, String userName, Integer day) {
        return Jwts.builder()
                .setSubject(subject)
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration * day))
                .claim("userId", userId)
                .claim("userName", userName)
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)
                .compact();
    }

    /**
     * 使用token获取map集合,使用默认秘钥
     *
     * @param token token
     * @return map集合
     */
    public static Map<String, Object> getMapByToken(String token) {
        try {
            if (!StringUtils.hasText(token)) return null;
            Claims claims = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token).getBody();

            // 将 body 值转为map
            return new HashMap<>(claims);

        } catch (Exception exception) {
            return null;
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
            if (!StringUtils.hasText(token)) return null;
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(signKey).parseClaimsJws(token);
            Claims body = claimsJws.getBody();
            // 将 body 值转为map
            return new HashMap<>(body);

        } catch (Exception exception) {
            return null;
        }
    }

    /**
     * 根据token获取主题
     *
     * @param token token
     * @return 主题
     */
    public static String getSubjectByToken(String token) {
        return getSubjectByTokenHandler(token, tokenSignKey);
    }

    @Nullable
    private static String getSubjectByTokenHandler(String token, String tokenSignKey) {
        try {
            if (!StringUtils.hasText(token)) return null;
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
            Claims body = claimsJws.getBody();

            return body.getSubject();

        } catch (Exception exception) {
            return null;
        }
    }

    /**
     * 根据token获取主题
     *
     * @param token token
     * @return 主题
     */
    public static String getSubjectByToken(String token, String tokenSignKey) {
        return getSubjectByTokenHandler(token, tokenSignKey);
    }

    /**
     * 根据token获取用户ID
     *
     * @param token token
     * @return 用户ID
     */
    public static Long getUserId(String token) {
        try {
            if (!StringUtils.hasText(token)) return null;

            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
            Claims claims = claimsJws.getBody();

            return Long.valueOf(String.valueOf(claims.get("userId")));
        } catch (Exception exception) {
            return null;
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

            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
            Claims claims = claimsJws.getBody();
            return (String) claims.get("userName");
        } catch (Exception exception) {
            return null;
        }
    }

    /**
     * 判断token是否过期
     *
     * @param token token
     * @return 是否过期
     */
    public static boolean isExpired(String token) {
        return isExpiredUtil(token, tokenSignKey);
    }

    /**
     * 判断token是否过期
     *
     * @param token token
     * @return 是否过期
     */
    public static boolean isExpired(String token, String tokenSignKey) {
        return isExpiredUtil(token, tokenSignKey);
    }

    /**
     * 判断是否过期
     *
     * @param token        token
     * @param tokenSignKey key值
     * @return 是否过期
     */
    private static boolean isExpiredUtil(String token, String tokenSignKey) {
        try {
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
            Date expiration = claimsJws.getBody().getExpiration();

            return expiration != null && expiration.before(new Date());
        } catch (Exception exception) {
            return true;
        }
    }
}