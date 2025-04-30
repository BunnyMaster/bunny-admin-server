package cn.bunny.services.domain.system.message.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageAddDto对象", title = "添加系统消息", description = "添加系统消息")
public class MessageAddDto {

    @Schema(name = "title", title = "消息标题")
    @NotBlank(message = "消息标题 不能为空")
    private String title;

    @Schema(name = "receivedUserIds", title = "接收人用户ID")
    private List<Long> receivedUserIds;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    private Long sendUserId;

    @Schema(name = "messageTypeId", title = "消息类型")
    @NotNull(message = "消息类型 不能为空")
    private Long messageTypeId;

    @Schema(name = "cover", title = "封面")
    private String cover;

    @Schema(name = "summary", title = "消息简介")
    @NotBlank(message = "消息简介 不能为空")
    private String summary;

    @Schema(name = "content", title = "消息内容")
    @NotBlank(message = "消息内容 不能为空")
    private String content;

    @Schema(name = "editorType", title = "编辑器类型")
    @NotBlank(message = "编辑器类型 不能为空")
    private String editorType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status = false;

    @Schema(name = "level", title = "消息等级")
    private String level;

    @Schema(name = "extra", title = "消息等级详情")
    private String extra;

}