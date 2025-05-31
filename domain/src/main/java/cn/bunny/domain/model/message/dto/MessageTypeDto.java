package cn.bunny.domain.model.message.dto;

import cn.bunny.domain.common.ValidationGroups;
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
@Schema(name = "MessageType对象", title = "系统消息类型分页查询", description = "系统消息类型分页查询")
public class MessageTypeDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "messageName", title = "消息名称")
    @NotBlank(message = "消息名称 不能为空", groups = {ValidationGroups.Add.class})
    private String messageName;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    @NotBlank(message = "消息类型 不能为空", groups = {ValidationGroups.Add.class})
    private String messageType;

    @Schema(name = "summary", title = "消息备注")
    private String summary;

    @Schema(name = "status", title = "消息类型")
    private Boolean status;

}


