package cn.bunny.dao.dto.system.message;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageUserDto对象", title = "用户消息查询内容", description = "用户消息查询内容")
public class MessageUserDto {

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;
}
