package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "MessageDto对象" , title = "消息分页查询" , description = "消息分页查询" )
public class MessageDto {

    @Schema(name = "id" , title = "主键" )
    @NotNull(message = "id不能为空" , groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "title" , title = "消息标题" )
    @NotBlank(message = "消息标题 不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String title;

    @Schema(name = "receivedUserIds" , title = "接收人用户ID" )
    private List<Long> receivedUserIds = new ArrayList<>();

    @Schema(name = "sendUserId" , title = "发送人用户ID" )
    @NotNull(message = "发送人用户ID 不能为空" , groups = {ValidationGroups.Update.class})
    private Long sendUserId;

    @Schema(name = "messageTypeId" , title = "消息类型" )
    @NotNull(message = "消息类型 不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private Long messageTypeId;

    @Schema(name = "cover" , title = "封面" )
    private String cover;

    @Schema(name = "summary" , title = "消息简介" )
    @NotBlank(message = "消息简介 不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String summary;

    @Schema(name = "content" , title = "消息内容" )
    @NotBlank(message = "消息内容 不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String content;

    @Schema(name = "editorType" , title = "编辑器类型" )
    @NotBlank(message = "编辑器类型 不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String editorType;

    @Schema(name = "status" , title = "0:未读 1:已读" )
    private Boolean status = false;

    @Schema(name = "level" , title = "消息等级" )
    private String level;

    @Schema(name = "extra" , title = "消息等级详情" )
    private String extra;

    @Schema(name = "sendNickname" , title = "发送人用户昵称" )
    private String sendNickname;

    @Schema(name = "messageType" , title = "消息类型" )
    private String messageType;

}
