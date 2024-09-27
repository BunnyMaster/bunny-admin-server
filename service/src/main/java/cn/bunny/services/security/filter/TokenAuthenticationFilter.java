package cn.bunny.services.security.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class TokenAuthenticationFilter extends OncePerRequestFilter {

    private final RedisTemplate<String, Object> redisTemplate;

    public TokenAuthenticationFilter(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        // 自定义实现内容
        UsernamePasswordAuthenticationToken authentication = getAuthentication(request);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        chain.doFilter(request, response);
    }

    /**
     * 用户请求判断
     *
     * @param request 请求
     * @return 验证码方法
     */
    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        // 请求头是否有token
        String token = request.getHeader("token");
        String username = "admin";
        List<SimpleGrantedAuthority> authList = new ArrayList<>();

        // 设置角色内容
        if (token != null) {
            List<String> roleList = new ArrayList<>();
            return new UsernamePasswordAuthenticationToken(username, null, authList);
        } else {
            return new UsernamePasswordAuthenticationToken(username, null, new ArrayList<>());
        }
    }
}
