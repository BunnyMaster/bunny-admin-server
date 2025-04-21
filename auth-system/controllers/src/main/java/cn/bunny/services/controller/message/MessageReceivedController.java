package cn.bunny.services.controller.message;

import cn.bunny.domain.message.dto.MessageReceivedDto;
import cn.bunny.domain.message.dto.MessageReceivedUpdateDto;
import cn.bunny.domain.message.dto.MessageUserDto;
import cn.bunny.domain.message.entity.Message;
import cn.bunny.domain.message.vo.MessageReceivedWithMessageVo;
import cn.bunny.domain.message.vo.MessageUserVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
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
@RestController
@RequestMapping("/api/messageReceived")
public class MessageReceivedController {

    @Resource
    private MessageReceivedService messageReceivedService;

    @Operation(summary = "管理员分页查询用户消息", description = "管理员分页查询用户消息")
    @GetMapping("getMessageReceivedList/{page}/{limit}")
    public Result<PageResult<MessageReceivedWithMessageVo>> getMessageReceivedList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageReceivedDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageReceivedWithMessageVo> pageResult = messageReceivedService.getMessageReceivedList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "管理员将用户消息标为已读", description = "管理员将用户消息标为已读")
    @PutMapping("updateMarkMessageReceived")
    public Result<String> updateMarkMessageReceived(@Valid @RequestBody MessageReceivedUpdateDto dto) {
        messageReceivedService.updateMarkMessageReceived(dto);
        return Result.success();
    }

    @Operation(summary = "管理删除用户消息", description = "管理删除用户消息")
    @DeleteMapping("deleteMessageReceivedByIds")
    public Result<String> deleteMessageReceivedByIds(@RequestBody List<Long> ids) {
        messageReceivedService.deleteMessageReceivedByIds(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "分页查询用户消息", description = "分页查询用户消息")
    @GetMapping("noManage/getUserMessageList/{page}/{limit}")
    public Result<PageResult<MessageUserVo>> getUserMessageList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageUserDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageUserVo> pageResult = messageReceivedService.getUserMessageList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "用户将消息标为已读", description = "用户将消息标为已读")
    @PutMapping("noManage/userMarkAsRead")
    public Result<String> userMarkAsRead(@Valid @RequestBody List<Long> ids) {
        messageReceivedService.userMarkAsRead(ids);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "用户删除消息", description = "用户删除消息")
    @DeleteMapping("noManage/deleteUserMessageByIds")
    public Result<String> deleteUserMessageByIds(@RequestBody List<Long> ids) {
        messageReceivedService.deleteUserMessageByIds(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
