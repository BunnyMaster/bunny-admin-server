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
@Schema(name = "LoginDto", title = "登录表单内容", description = "登录表单内容")
public class LoginDto {

    @Schema(name = "username", title = "用户名")
    @NotBlank(message = "用户名不能为空")
    private String username;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    private String password;


    @Schema(name = "emailCode", title = "邮箱验证码")
    @NotBlank(message = "邮箱验证码不能为空")
    private String emailCode;

    @Schema(name = "readMeDay", title = "记住我的天数")
    private Long readMeDay = 1L;
}
