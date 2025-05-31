package cn.bunny.domain.model.message.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageUserDto对象", title = "用户消息分页查询", description = "用户消息分页查询")
public class MessageUserDto {

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

}
