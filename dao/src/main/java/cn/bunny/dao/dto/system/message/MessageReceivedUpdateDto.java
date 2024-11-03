package cn.bunny.dao.dto.system.message;

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
@Schema(name = "MessageReceivedDto对象", title = "用户消息查询", description = "用户消息查询")
public class MessageReceivedUpdateDto {

    @Schema(name = "ids", title = "消息接受id")
    private List<Long> ids;

    @Schema(name = "status", title = "0:未读 1:已读")
    private Boolean status;

}
