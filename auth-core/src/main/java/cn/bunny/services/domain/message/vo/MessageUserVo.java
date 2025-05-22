package cn.bunny.services.domain.message.vo;

import cn.bunny.services.domain.common.model.vo.BaseVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MessageVo对象", title = "系统消息返回内容", description = "系统消息返回内容")
public class MessageUserVo extends BaseVo {

    @Schema(name = "id", title = "消息messageId")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;

    @Schema(name = "messageReceivedId", title = "用户消息表id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long messageReceivedId;

    @Schema(name = "title", title = "消息标题")
    private String title;

    @Schema(name = "messageType", title = "消息类型")
    private String messageType;

    @Schema(name = "cover", title = "封面")
    private String cover;

    @Schema(name = "summary", title = "消息简介")
    private String summary;

    @Schema(name = "level", title = "消息等级")
    private String level;

    @Schema(name = "extra", title = "消息等级详情")
    private String extra;

    @Schema(name = "status", title = "消息状态")
    private Boolean status;

    @Schema(name = "updateTime", title = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonProperty("acceptanceTime")
    private LocalDateTime updateTime;

}
