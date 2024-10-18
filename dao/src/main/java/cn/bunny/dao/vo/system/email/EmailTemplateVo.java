package cn.bunny.dao.vo.system.email;

import cn.bunny.dao.vo.common.BaseVo;
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
@Schema(name = "EmailTemplateVo对象", title = "邮箱模板返回内容", description = "邮箱模板返回内容")
public class EmailTemplateVo extends BaseVo {

    @Schema(name = "templateName", title = "模板名称")
    private String templateName;

    @Schema(name = "emailUser", title = "配置邮件用户")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long emailUser;

    @Schema(name = "emailUsername", title = "邮箱账户")
    private String emailUsername;

    @Schema(name = "subject", title = "主题")
    private String subject;

    @Schema(name = "body", title = "邮件内容")
    private String body;

    @Schema(name = "type", title = "邮件类型")
    private String type;

    @Schema(name = "isDefault", title = "是否默认")
    private Boolean isDefault;

}