package cn.bunny.dao.dto.system.email.template;

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
@Schema(name = "EmailTemplateUpdateDto对象", title = "更新邮箱模板", description = "更新邮箱模板")
public class EmailTemplateUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "templateName", title = "模板名称")
    @NotBlank(message = "模板名称不能为空")
    @NotNull(message = "模板名称不能为空")
    private String templateName;

    @Schema(name = "emailUser", title = "配置邮件用户")
    @NotNull(message = "配置邮件用户不能为空")
    private Long emailUser;

    @Schema(name = "subject", title = "主题")
    @NotBlank(message = "主题不能为空")
    @NotNull(message = "主题不能为空")
    private String subject;

    @Schema(name = "body", title = "邮件内容")
    @NotBlank(message = "邮件内容不能为空")
    @NotNull(message = "邮件内容不能为空")
    private String body;

    @Schema(name = "type", title = "邮件类型")
    private String type;

    @Schema(name = "isDefault", title = "是否默认")
    @NotNull(message = "是否默认不能为空")
    private Boolean isDefault;

}