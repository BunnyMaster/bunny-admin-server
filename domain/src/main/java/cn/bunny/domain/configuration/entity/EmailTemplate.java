package cn.bunny.domain.configuration.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author Bunny
 * @since 2024-05-19
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@TableName("sys_email_template")
@Schema(name = "EmailTemplate对象", title = "邮件模板表", description = "邮件模板表")
public class EmailTemplate extends BaseEntity {

    @Schema(name = "templateName", title = "模板名称")
    private String templateName;

    @Schema(name = "emailUser", title = "模板名称")
    private Long emailUser;

    @Schema(name = "subject", title = "主题")
    private String subject;

    @Schema(name = "body", title = "邮件内容")
    private String body;

    @Schema(name = "type", title = "邮件类型")
    private String type;

    @Schema(name = "isDefault", title = "是否默认")
    private Boolean isDefault;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}