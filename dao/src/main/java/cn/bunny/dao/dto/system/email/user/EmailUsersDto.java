package cn.bunny.dao.dto.system.email.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailUsersDto对象", title = "邮箱用户发送配置", description = "邮箱用户发送配置管理")
public class EmailUsersDto {

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "host", title = "Host地址")
    private String host;

    @Schema(name = "port", title = "端口号")
    private Integer port;

    @Schema(name = "smtpAgreement", title = "邮箱协议")
    private String smtpAgreement;

    @Schema(name = "openSSL", description = "启用SSL")
    private Boolean openSSL;

}


