package cn.bunny.services.domain.message.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageTypeUpdateDto对象", title = "更新系统消息类型", description = "更新系统消息类型")
public class MessageTypeUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "status", title = "1:启用 0:禁用")
    private Boolean status;

    @Schema(name = "messageName", title = "消息名称")
    private String messageName;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    private String messageType;

    @Schema(name = "summary", title = "消息备注")
    private String summary;

}