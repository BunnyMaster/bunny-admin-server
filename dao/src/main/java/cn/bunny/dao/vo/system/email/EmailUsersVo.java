package cn.bunny.dao.vo.system.email;

import cn.bunny.dao.vo.BaseVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailUsersVo对象", title = "邮箱用户发送配置", description = "邮箱用户发送配置管理")
public class EmailUsersVo extends BaseVo {

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "emailTemplate", title = "使用邮件模板")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long emailTemplate;

    @Schema(name = "password", title = "密码")
    private String password;

    @Schema(name = "host", title = "Host地址")
    private String host;

    @Schema(name = "port", title = "端口号")
    private Integer port;

    @Schema(name = "smtpAgreement", title = "邮箱协议")
    private String smtpAgreement;

    @Schema(name = "isDefault", title = "是否为默认邮件")
    private Boolean isDefault;

}