package cn.bunny.domain.message.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageDto对象", title = "消息分页查询", description = "消息分页查询")
public class MessageDto {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "sendNickname", title = "发送人用户昵称")
    private String sendNickname;

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "level", title = "消息等级")
    private String level;

    @Schema(name = "extra", title = "消息等级详情")
    private String extra;

    @Schema(name = "editorType", title = "编辑器类型")
    private String editorType;

}
