package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.message.MessageReceivedDto;
import cn.bunny.dao.dto.system.message.MessageReceivedUpdateDto;
import cn.bunny.dao.dto.system.message.MessageUserDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageUserVo;
import cn.bunny.services.service.MessageReceivedService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

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
@RequestMapping("/admin/messageReceived")
public class MessageReceivedController {

    @Autowired
    private MessageReceivedService messageReceivedService;

    @Operation(summary = "管理员分页查询用户消息", description = "管理员分页查询用户消息")
    @GetMapping("getMessageReceivedList/{page}/{limit}")
    public Mono<Result<PageResult<MessageReceivedWithMessageVo>>> getMessageReceivedList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageReceivedDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageReceivedWithMessageVo> pageResult = messageReceivedService.getMessageReceivedList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "管理员将用户消息标为已读", description = "管理员将用户消息标为已读")
    @PutMapping("updateMarkMessageReceived")
    public Mono<Result<String>> updateMarkMessageReceived(@Valid @RequestBody MessageReceivedUpdateDto dto) {
        messageReceivedService.updateMarkMessageReceived(dto);
        return Mono.just(Result.success());
    }

    @Operation(summary = "管理删除用户消息", description = "管理删除用户消息")
    @DeleteMapping("deleteMessageReceivedByIds")
    public Mono<Result<String>> deleteMessageReceivedByIds(@RequestBody List<Long> ids) {
        messageReceivedService.deleteMessageReceivedByIds(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }

    @Operation(summary = "分页查询用户消息", description = "分页查询用户消息")
    @GetMapping("noManage/getUserMessageList/{page}/{limit}")
    public Mono<Result<PageResult<MessageUserVo>>> getUserMessageList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageUserDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageUserVo> pageResult = messageReceivedService.getUserMessageList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "用户将消息标为已读", description = "用户将消息标为已读")
    @PutMapping("noManage/userMarkAsRead")
    public Mono<Result<String>> userMarkAsRead(@Valid @RequestBody List<Long> ids) {
        messageReceivedService.userMarkAsRead(ids);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "用户删除消息", description = "用户删除消息")
    @DeleteMapping("noManage/deleteUserMessageByIds")
    public Mono<Result<String>> deleteUserMessageByIds(@RequestBody List<Long> ids) {
        messageReceivedService.deleteUserMessageByIds(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
