package cn.bunny.services.domain.system.message.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageReceivedDto对象", title = "更新用户消息", description = "更新用户消息")
public class MessageReceivedUpdateDto {

    @Schema(name = "ids", title = "消息接受id")
    private List<Long> ids;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

}
