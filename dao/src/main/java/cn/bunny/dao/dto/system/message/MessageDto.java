package cn.bunny.dao.dto.system.message;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageDto对象", title = "系统消息", description = "系统消息")
public class MessageDto {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "receivedUserId", title = "接收人用户ID")
    private Long receivedUserId;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    private Long sendUserId;

    @Schema(name = "sendNickName", title = "发送人昵称")
    private String sendNickName;

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "content", title = "消息内容")
    private String content;

    @Schema(name = "editorType", title = "编辑器类型")
    private String editorType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

}
