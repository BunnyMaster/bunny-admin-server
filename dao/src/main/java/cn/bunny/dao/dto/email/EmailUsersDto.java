package cn.bunny.dao.dto.email;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 添加邮箱用户
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailUsersDto", title = "邮箱用户发送基础内容", description = "邮箱用户发送基础内容")
public class EmailUsersDto {

    @Schema(name = "id", title = "主键")
    @NotBlank(message = "id不能为空")
    private Long id;

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空")
    private String email;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空")
    private String password;

    @Schema(name = "host", title = "SMTP服务器")
    private String host;

    @Schema(name = "port", title = "端口号")
    @NotNull(message = "端口号不能为空")
    private Integer port;

    @Schema(name = "smtpAgreement", title = "邮箱协议")
    private Integer smtpAgreement;

    @Schema(name = "isDefault", title = "是否为默认邮件")
    private Boolean isDefault;
}
