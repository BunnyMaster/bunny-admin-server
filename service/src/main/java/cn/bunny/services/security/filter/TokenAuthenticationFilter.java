package cn.bunny.services.security.filter;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.vo.system.user.LoginVo;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class TokenAuthenticationFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        // 自定义实现内容
        UsernamePasswordAuthenticationToken authentication = getAuthentication();
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }

    /**
     * 用户请求判断
     *
     * @return 验证码方法
     */
    private UsernamePasswordAuthenticationToken getAuthentication() {
        // 请求头是否有token
        LoginVo LoginVo = BaseContext.getLoginVo();

        // 通过username从redis获取权限数据
        String username = LoginVo.getUsername();
        List<String> roleList = LoginVo.getRoles();

        // 角色列表
        List<SimpleGrantedAuthority> authList = roleList.stream().map(SimpleGrantedAuthority::new).toList();

        if (authList.isEmpty()) return new UsernamePasswordAuthenticationToken(username, null, new ArrayList<>());
        return new UsernamePasswordAuthenticationToken(username, null, authList);
    }
}
