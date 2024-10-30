package cn.bunny.dao.entity.system;

import cn.bunny.dao.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 系统消息
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_message")
@Schema(name = "Message对象", title = "系统消息", description = "系统消息")
public class Message extends BaseEntity {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "receivedUserIds", title = "接收人用户ID")
    private String receivedUserIds;

    @Schema(name = "sendUserId", title = "发送人用户ID")
    private Long sendUserId;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    private String messageType;

    @Schema(name = "content", title = "消息内容")
    private String content;

    @Schema(name = "editorType", title = "编辑器类型")
    private String editorType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

}


