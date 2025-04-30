package cn.bunny.services.domain.system.system.entity;

import cn.bunny.services.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

/**
 * <p>
 * 管理员用户信息
 * </p>
 *
 * @author Bunny
 * @since 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_user")
@Schema(name = "AdminUser对象", title = "用户信息", description = "用户信息")
public class AdminUser extends BaseEntity implements UserDetails {

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickname", title = "昵称")
    private String nickname;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "password", title = "密码")
    private String password;

    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "ipAddress", title = "登录Ip")
    private String ipAddress;

    @Schema(name = "ipRegion", title = "登录Ip归属地")
    private String ipRegion;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;

    @TableField(exist = false)
    private List<GrantedAuthority> authorities;

    @Schema(name = "isDeleted", title = "是否被删除")
    private Boolean isDeleted;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }
}

