package cn.bunny.dao.vo.email;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailTemplateVo对象", title = "邮箱模板返回内容", description = "邮箱模板返回内容")
public class EmailTemplateVo {
    @Schema(name = "templateName", title = "模板名称")
    private String templateName;

    @Schema(name = "subject", title = "主题")
    private String subject;

    @Schema(name = "body", title = "邮件内容")
    private String body;
}