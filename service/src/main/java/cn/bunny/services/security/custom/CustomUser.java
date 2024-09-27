package cn.bunny.services.security.custom;

import cn.bunny.dao.entity.system.AdminUser;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

/**
 * 重写自带的User
 */
@Getter
@Setter
public class CustomUser extends User {
    private AdminUser user;

    public CustomUser(AdminUser user, Collection<? extends GrantedAuthority> authorities) {
        super(user.getEmail(), user.getPassword(), authorities);
        this.user = user;
    }
}