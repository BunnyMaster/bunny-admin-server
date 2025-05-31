package cn.bunny.services.controller.message;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.model.message.dto.MessageReceivedDto;
import cn.bunny.domain.model.message.dto.MessageReceivedUpdateDto;
import cn.bunny.domain.model.message.dto.MessageUserDto;
import cn.bunny.domain.model.message.entity.Message;
import cn.bunny.domain.model.message.vo.MessageReceivedWithMessageVo;
import cn.bunny.domain.model.message.vo.MessageUserVo;
import cn.bunny.services.service.message.MessageReceivedService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
@Tag(name = "消息接收(用户消息)", description = "消息接收(用户消息)相关接口")
@PermissionTag(permission = "messageReceived:*")
@RestController
@RequestMapping("/api/message-received")
public class MessageReceivedController {

    @Resource
    private MessageReceivedService messageReceivedService;

    @Operation(summary = "分页查询消息接收", description = "管理员分页查询用户消息")
    @PermissionTag(permission = "messageReceived:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<MessageReceivedWithMessageVo>> getMessageReceivedPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageReceivedDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageReceivedWithMessageVo> pageResult = messageReceivedService.getMessageReceivedPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "更新消息接收", description = "管理员将用户消息标为已读")
    @PermissionTag(permission = "messageReceived:update")
    @PutMapping()
    public Result<String> updateMarkMessageReceived(@Valid @RequestBody MessageReceivedUpdateDto dto) {
        messageReceivedService.updateMarkMessageReceived(dto);
        return Result.success();
    }

    @Operation(summary = "删除消息接收", description = "管理删除用户消息")
    @PermissionTag(permission = "messageReceived:delete")
    @DeleteMapping()
    public Result<String> deleteMessageReceived(@RequestBody List<Long> ids) {
        messageReceivedService.deleteMessageReceived(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "分页查询消息接收", description = "分页查询用户消息")
    @GetMapping("private/{page}/{limit}")
    public Result<PageResult<MessageUserVo>> getMessagePageByUser(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageUserDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageUserVo> pageResult = messageReceivedService.getMessagePageByUser(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "用户将消息标为已读", description = "用户将消息标为已读")
    @PutMapping("private/user/messages/read-status")
    public Result<String> markAsReadByUser(@RequestBody List<Long> ids) {
        messageReceivedService.markAsReadByUser(ids);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "用户删除消息", description = "用户删除消息")
    @DeleteMapping("private/user/messages")
    public Result<String> deleteMessageByUser(@RequestBody List<Long> ids) {
        messageReceivedService.deleteMessageByUser(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
