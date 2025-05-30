package cn.bunny.domain.message.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 系统消息
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@TableName("sys_message")
@Schema(name = "Message对象", title = "系统消息", description = "系统消息")
public class Message extends BaseEntity {

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

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}


