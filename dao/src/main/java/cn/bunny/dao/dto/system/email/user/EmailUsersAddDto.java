package cn.bunny.dao.dto.system.email.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailUsersAddDto对象", title = "邮箱用户发送配置", description = "邮箱用户发送配置管理")
public class EmailUsersAddDto {

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空")
    @NotNull(message = "邮箱不能为空")
    private String email;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    @NotNull(message = "密码不能为空")
    private String password;

    @Schema(name = "host", title = "Host地址")
    @NotBlank(message = "Host地址不能为空")
    @NotNull(message = "Host地址不能为空")
    private String host;

    @Schema(name = "port", title = "端口号")
    @NotNull(message = "端口号不能为空")
    private Integer port;

    @Schema(name = "smtpAgreement", title = "邮箱协议")
    private String smtpAgreement;

    @Schema(name = "isDefault", title = "是否为默认邮件")
    private Boolean isDefault = false;

    @Schema(name = "openSSL", description = "启用SSL")
    private Boolean openSSL;

}
