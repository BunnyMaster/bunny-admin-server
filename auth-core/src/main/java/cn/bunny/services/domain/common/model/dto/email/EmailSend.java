package cn.bunny.services.domain.common.model.dto.email;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

/**
 * 邮件发送对象
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "EmailSend", title = "邮件发送表单", description = "邮件发送表单")
public class EmailSend {

    @Schema(name = "sendTo", title = "收件人")
    @NotBlank(message = "收件人机不能为空")
    @NotNull(message = "收件人不能为空")
    private List<String> sendTo;

    @Schema(name = "subject", title = "发送主题")
    @NotBlank(message = "发送主题不能为空")
    @NotNull(message = "发送主题不能为空")
    private String subject;

    @Schema(name = "isRichText", title = "是否为富文本")
    private boolean isRichText = true;

    @Schema(name = "message", title = "发送内容")
    @NotBlank(message = "发送内容不能为空")
    @NotNull(message = "发送内容不能为空")
    private String text;

    @Schema(name = "ccParam", title = "抄送人")
    private List<String> ccParam = new ArrayList<>();

    @Schema(name = "file", title = "发送的文件")
    private MultipartFile[] files;

}