package cn.bunny.dao.vo.user;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@Data
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "LoginVo对象", title = "登录成功返回内容", description = "登录成功返回内容")
public class UserVo extends BaseVo {

    @Schema(name = "nickName", title = "昵称")
    private String nickName;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "0:女 1:男")
    private Byte sex;

    @Schema(name = "personDescription", title = "个人描述")
    private String personDescription;

    @Schema(name = "status", title = "1:禁用 0:正常")
    private Byte status;

}