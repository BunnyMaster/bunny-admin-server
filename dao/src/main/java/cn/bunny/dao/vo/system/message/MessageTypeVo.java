package cn.bunny.dao.vo.system.message;

import cn.bunny.dao.vo.common.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageTypeVo对象", title = "系统消息类型", description = "系统消息类型")
public class MessageTypeVo extends BaseVo {

    @Schema(name = "messageName", title = "消息名称")
    private String messageName;

    @Schema(name = "messageType", title = "sys:系统消息,user用户消息")
    private String messageType;

    @Schema(name = "summary", title = "消息备注")
    private String summary;

    @Schema(name = "status", title = "消息状态")
    private Boolean status;

}