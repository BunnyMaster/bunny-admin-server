package cn.bunny.domain.message.entity;

import cn.bunny.domain.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_message_received")
@Schema(name = "MessageReceived对象", title = "系统消息接受用户", description = "系统消息接受用户")
public class MessageReceived extends BaseEntity {

    @Schema(name = "receivedUserId", title = "接受者id")
    private Long receivedUserId;

    @Schema(name = "messageId", title = "消息ID")
    private Long messageId;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}
