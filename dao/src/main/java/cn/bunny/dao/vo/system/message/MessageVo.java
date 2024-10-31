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
@Schema(name = "MessageVo对象", title = "系统消息返回内容", description = "系统消息返回内容")
public class MessageVo extends BaseUserVo {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long sendUserId;

    @Schema(name = "sendNickname", title = "发送人昵称")
    private String sendNickname;

    @Schema(name = "receivedUserIds", title = "接收人用户ID")
    private String receivedUserIds;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    private String messageType;

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

}