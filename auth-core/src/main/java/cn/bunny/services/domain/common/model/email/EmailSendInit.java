package cn.bunny.services.domain.common.model.email;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "EmailSendInit", title = "邮件发送初始化", description = "邮件发送初始化")
public class EmailSendInit {

    @Schema(name = "port", title = "端口")
    @NotNull(message = "端口不能为空")
    private Integer port;

    @Schema(name = "host", title = "主机")
    @NotBlank(message = "主机不能为空")
    @NotNull(message = "主机不能为空")
    private String host;

    @Schema(name = "protocol", description = "协议")
    private String protocol = "smtps";

    @Schema(name = "username", title = "用户名")
    @NotBlank(message = "用户名不能为空")
    @NotNull(message = "用户名不能为空")
    private String username;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    @NotNull(message = "密码不能为空")
    private String password;

    @Schema(name = "openSSL", description = "启用SSL")
    private Boolean openSSL;

}