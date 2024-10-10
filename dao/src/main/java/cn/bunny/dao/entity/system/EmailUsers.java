package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 邮箱发送表
 * </p>
 *
 * @author Bunny
 * @since 2024-05-17
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@TableName("sys_email_users")
@Schema(name = "EmailUsers对象", title = "邮箱用户发送配置", description = "邮箱用户发送配置管理")
public class EmailUsers extends BaseEntity {

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "emailTemplate", title = "使用邮件模板")
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


