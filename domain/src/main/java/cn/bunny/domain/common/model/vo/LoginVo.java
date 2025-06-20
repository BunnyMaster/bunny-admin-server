package cn.bunny.domain.common.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户登录返回内容
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "LoginVo对象", title = "登录成功返回内容", description = "登录成功返回内容")
public class LoginVo extends BaseVo {

    @Schema(name = "nickname", title = "昵称")
    private String nickname;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "password", title = "密码")
    private String password;

    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "0:女 1:男")
    private Byte sex;

    @Schema(name = "personDescription", title = "个人描述")
    private String personDescription;

    @Schema(name = "ipAddress", title = "登录Ip")
    private String ipAddress;

    @Schema(name = "ipRegion", title = "登录Ip归属地")
    private String ipRegion;

    @Schema(name = "status", title = "1:禁用 0:正常")
    private Boolean status;

    @Schema(name = "token", title = "令牌")
    private String token;

    @Schema(name = "refreshToken", title = "刷新token")
    private String refreshToken;

    @Schema(name = "expires", title = "过期时间")
    private String expires;

    @Schema(name = "roleList", title = "角色列表")
    private List<String> roles = new ArrayList<>();

    @Schema(name = "powerList", title = "权限列表")
    private List<String> permissions = new ArrayList<>();

    @Schema(name = "readMeDay", title = "记住我多久")
    private Long readMeDay;

}