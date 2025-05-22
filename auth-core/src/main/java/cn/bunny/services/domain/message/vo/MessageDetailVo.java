package cn.bunny.services.domain.message.vo;

import cn.bunny.services.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageDetailVo对象", title = "系统消息详情返回内容", description = "系统消息详情返回内容")
public class MessageDetailVo extends BaseUserVo {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    private Long sendUserId;

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

    @Schema(name = "level", title = "消息等级")
    private String level;

    @Schema(name = "extra", title = "消息等级详情")
    private String extra;

    @Schema(name = "sendNickname", title = "发送人昵称")
    private String sendNickname;

}