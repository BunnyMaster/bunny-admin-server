package cn.bunny.dao.dto.system.message;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageTypeAddDto对象", title = "添加系统消息类型", description = "添加系统消息类型")
public class MessageTypeAddDto {

    @Schema(name = "messageName", title = "消息名称")
    @NotBlank(message = "消息名称 不能为空")
    @NotNull(message = "消息名称 不能为空")
    private String messageName;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    @NotBlank(message = "消息类型 不能为空")
    @NotNull(message = "消息类型 不能为空")
    private String messageType;

    @Schema(name = "summary", title = "消息备注")
    private String summary;

    @Schema(name = "status", title = "消息类型")
    private Boolean status = true;

}