package cn.bunny.domain.model.configuration.dto;

import cn.bunny.domain.common.ValidationGroups.Add;
import cn.bunny.domain.common.ValidationGroups.Update;
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
@Schema(name = "EmailUsersDto对象", title = "邮箱用户发送配置分页查询", description = "邮箱用户发送配置分页查询")
public class EmailUsersDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {Update.class})
    private Long id;

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空", groups = {Add.class, Update.class})
    private String email;

    @Schema(name = "password", title = "密码")
    @NotBlank(message = "密码不能为空", groups = {Add.class, Update.class})
    private String password;

    @Schema(name = "host", title = "Host地址")
    @NotBlank(message = "Host地址不能为空", groups = {Add.class, Update.class})
    private String host;

    @Schema(name = "port", title = "端口号")
    @NotNull(message = "端口号不能为空", groups = {Add.class, Update.class})
    private Integer port;

    @Schema(name = "smtpAgreement", title = "邮箱协议")
    private String smtpAgreement;

    @Schema(name = "isDefault", title = "是否为默认邮件")
    private Boolean isDefault;

    @Schema(name = "openSSL", description = "启用SSL")
    private Boolean openSSL;

}