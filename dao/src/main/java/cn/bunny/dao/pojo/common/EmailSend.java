package cn.bunny.dao.pojo.common;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

/**
 * 邮件发送对象
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "EmailSend", title = "邮件发送表单", description = "邮件发送表单")
public class EmailSend {

    @Schema(name = "sendTo", title = "给谁发送")
    private String sendTo;

    @Schema(name = "subject", title = "发送主题")
    private String subject;

    @Schema(name = "isRichText", title = "是否为富文本")
    private boolean isRichText = true;

    @Schema(name = "message", title = "发送内容")
    private String message;

    @Schema(name = "ccParam", title = "抄送人")
    private String ccParam;

    @Schema(name = "file", title = "发送的文件")
    private MultipartFile[] files;

}