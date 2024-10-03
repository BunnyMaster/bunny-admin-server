package cn.bunny.dao.dto.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AdminUserAddDto对象", title = "用户", description = "用户管理")
public class AdminUserAddDto {

    @Schema(name = "username", title = "用户名")
    @NotBlank(message = "用户名不能为空")
    private String username;

    @Schema(name = "nickName", title = "昵称")
    @NotBlank(message = "昵称不能为空")
    private String nickName;

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    private String password;

    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex = 1;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status = false;

}

