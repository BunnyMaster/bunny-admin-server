package cn.bunny.dao.vo.system.message;

import cn.bunny.dao.common.vo.BaseUserVo;
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
@Schema(name = "MessageReceivedWithMessageVo对象", title = "消息内容和消息接受", description = "消息内容和消息接受")
public class MessageReceivedWithMessageVo extends BaseUserVo {

    @Schema(name = "id", title = "消息接受id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;

    @Schema(name = "messageId", title = "消息id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long messageId;

    @Schema(name = "receivedUserId", title = "接收人用户ID")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private String receivedUserId;

    @Schema(name = "receivedUserNickname", title = "接收人用户昵称")
    private String receivedUserNickname;

    @Schema(name = "messageTypeId", title = "消息类型id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private String messageTypeId;

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long sendUserId;

    @Schema(name = "sendNickname", title = "发送人昵称")
    private String sendNickname;

    @Schema(name = "cover", title = "封面")
    private String cover;

    @Schema(name = "summary", title = "消息简介")
    private String summary;

    @Schema(name = "content", title = "消息内容")
    private String content;

    @Schema(name = "editorType", title = "编辑器类型")
    private String editorType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

    @Schema(name = "level", title = "消息等级")
    private String level;

    @Schema(name = "extra", title = "消息等级详情")
    private String extra;

}