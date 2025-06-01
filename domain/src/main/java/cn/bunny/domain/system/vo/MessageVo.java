package cn.bunny.domain.system.vo;

import cn.bunny.domain.common.model.vo.BaseUserVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageVo对象" , title = "系统消息返回内容" , description = "系统消息返回内容" )
public class MessageVo extends BaseUserVo {

    @Schema(name = "receivedUserId" , title = "接收人用户ID" )
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private List<String> receivedUserId;

    @Schema(name = "receivedUserNickname" , title = "接收人用户昵称" )
    private List<String> receivedUserNickname;

    @Schema(name = "title" , title = "消息标题" )
    private String title;

    @Schema(name = "sendUserId" , title = "发送人用户ID" )
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long sendUserId;

    @Schema(name = "sendNickname" , title = "发送人昵称" )
    private String sendNickname;

    @Schema(name = "messageTypeId" , title = "消息类型id" )
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private String messageTypeId;

    @Schema(name = "messageType" , title = "sys:系统消息,user用户消息" )
    private String messageType;

    @Schema(name = "cover" , title = "封面" )
    private String cover;

    @Schema(name = "summary" , title = "消息简介" )
    private String summary;

    @Schema(name = "content" , title = "消息内容" )
    private String content;

    @Schema(name = "editorType" , title = "编辑器类型" )
    private String editorType;

    @Schema(name = "level" , title = "消息等级" )
    private String level;

    @Schema(name = "extra" , title = "消息等级详情" )
    private String extra;

}



