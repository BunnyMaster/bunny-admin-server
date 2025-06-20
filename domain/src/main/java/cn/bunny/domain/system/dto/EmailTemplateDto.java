package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
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
@Schema(name = "EmailTemplateDto" , title = "邮箱模板请求内容" , description = "邮箱模板请求内容" )
public class EmailTemplateDto {

    @Schema(name = "id" , title = "主键" )
    @NotNull(message = "id不能为空" , groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "templateName" , title = "模板名称" )
    @NotBlank(message = "模板名称不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String templateName;

    @Schema(name = "emailUser" , title = "配置邮件用户" )
    @NotNull(message = "配置邮件用户不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private Long emailUser;

    @Schema(name = "subject" , title = "主题" )
    @NotBlank(message = "主题不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String subject;

    @Schema(name = "body" , title = "邮件内容" )
    @NotBlank(message = "邮件内容不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String body;

    @Schema(name = "type" , title = "邮件类型" )
    private String type;

    @Schema(name = "isDefault" , title = "是否默认" )
    @NotNull(message = "是否默认不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private Boolean isDefault;

}

