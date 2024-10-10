package cn.bunny.dao.vo.system.email;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailTemplateVo对象", title = "邮箱模板返回内容", description = "邮箱模板返回内容")
public class EmailTemplateVo extends BaseVo {

    @Schema(name = "templateName", title = "模板名称")
    private String templateName;

    @Schema(name = "subject", title = "主题")
    private String subject;

    @Schema(name = "body", title = "邮件内容")
    private String body;

    @Schema(name = "type", title = "邮件类型")
    private String type;

    @Schema(name = "isDefault", title = "是否默认")
    private Boolean isDefault;

}