package cn.bunny.dao.dto.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
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
    @NotNull(message = "用户名不能为空")
    private String username;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    @NotNull(message = "密码不能为空")
    @Pattern(
            regexp = "^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?!([^(0-9a-zA-Z)]|[()])+$)(?!^.*[\\u4E00-\\u9FA5].*$)([^(0-9a-zA-Z)]|[()]|[a-z]|[A-Z]|[0-9]){8,18}$",
            message = "密码格式应为8-18位数字、字母、符号的任意两种组合")
    private String password;

    @Schema(name = "emailCode", title = "邮箱验证码")
    @NotBlank(message = "邮箱验证码不能为空")
    @NotNull(message = "邮箱验证码不能为空")
    private String emailCode;

    @Schema(name = "type", title = "登录类型")
    @NotBlank(message = "登录类型不能为空")
    @NotNull(message = "登录类型能为空")
    private String type = "default";

    @Schema(name = "readMeDay", title = "记住我的天数")
    private Long readMeDay = 1L;
}
