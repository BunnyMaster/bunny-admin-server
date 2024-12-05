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
@Schema(name = "MessageType对象", title = "系统消息类型分页查询", description = "系统消息类型分页查询")
public class MessageTypeDto {

    @Schema(name = "status", title = "1:启用 0:禁用")
    private Boolean status;

    @Schema(name = "messageName", title = "消息名称")
    private String messageName;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    private String messageType;

    @Schema(name = "summary", title = "消息备注")
    private String summary;

}


