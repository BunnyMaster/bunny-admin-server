package cn.bunny.api.controller.system;

import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.system.dto.MessageDto;
import cn.bunny.domain.system.entity.Message;
import cn.bunny.domain.system.vo.MessageDetailVo;
import cn.bunny.domain.system.vo.MessageReceivedWithUserVo;
import cn.bunny.domain.system.vo.MessageVo;
import cn.bunny.system.service.MessageService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 系统消息表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Tag(name = "系统消息" , description = "系统消息相关接口" )
@PermissionTag(permission = "message:*" )
@RestController
@RequestMapping("api/message" )
public class MessageController {

    @Resource
    private MessageService messageService;

    @Operation(summary = "分页查询系统消息" , description = "分页查询发送消息" )
    @PermissionTag(permission = "message:query" )
    @GetMapping("{page}/{limit}" )
    public Result<PageResult<MessageVo>> getMessagePage(
            @Parameter(name = "page" , description = "当前页" , required = true)
            @PathVariable("page" ) Integer page,
            @Parameter(name = "limit" , description = "每页记录数" , required = true)
            @PathVariable("limit" ) Integer limit,
            MessageDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageVo> pageResult = messageService.getMessagePage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加系统消息" , description = "添加系统消息" )
    @PostMapping()
    public Result<String> createMessage(@Validated(ValidationGroups.Add.class) @RequestBody MessageDto dto) {
        messageService.createMessage(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更系统消息" , description = "更新系统消息" )
    @PutMapping()
    public Result<String> updateMessage(@Validated(ValidationGroups.Update.class) @RequestBody MessageDto dto) {
        messageService.updateMessage(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除系统消息" , description = "删除系统消息" )
    @DeleteMapping()
    public Result<String> deleteMessage(@RequestBody List<Long> ids) {
        messageService.deleteMessage(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "根据消息id查询消息详情" , description = "根据消息id查询消息详情" )
    @GetMapping("private/message/{id}" )
    public Result<MessageDetailVo> getMessageDetailById(@PathVariable Long id) {
        MessageDetailVo vo = messageService.getMessageDetailById(id);
        return Result.success(vo);
    }

    @Operation(summary = "根据消息id获取接收人信息" , description = "根据消息id获取接收人信息" )
    @GetMapping("private/messages/{message-id}/recipients" )
    public Result<List<MessageReceivedWithUserVo>> getReceivedUserinfoByMessageId(Long messageId, @PathVariable("message-id" ) String parameter) {
        List<MessageReceivedWithUserVo> voList = messageService.getReceivedUserinfoByMessageId(messageId);
        return Result.success(voList);
    }
}
