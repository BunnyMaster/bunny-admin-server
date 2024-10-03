package cn.bunny.dao.vo.system.user;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AdminUserVo对象", title = "用户信息", description = "用户信息")
public class AdminUserVo extends BaseVo {
    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickName", title = "昵称")
    private String nickName;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "lastLoginIp", title = "最后登录IP")
    private String lastLoginIp;

    @Schema(name = "lastLoginIpAddress", title = "最后登录ip归属地")
    private String lastLoginIpAddress;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;
}