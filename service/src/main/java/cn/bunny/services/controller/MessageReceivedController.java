package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
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
@Tag(name = "消息接受关系", description = "消息接受关系相关接口")
@RestController
@RequestMapping("/admin/messageReceived")
public class MessageReceivedController {

    @Autowired
    private MessageReceivedService messageReceivedService;

    @Operation(summary = "管理员管理用户消息接收分页查询", description = "管理员管理用户消息接收分页查询")
    @GetMapping("getMessageReceivedList/{page}/{limit}")
    public Mono<Result<PageResult<MessageReceivedWithMessageVo>>> getMessageReceivedList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageReceivedWithMessageVo> pageResult = messageReceivedService.getMessageReceivedList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "管理员将用户接受消息标为已读", description = "管理员将用户接受消息标为已读")
    @PutMapping("markMessageReceivedAsRead")
    public Mono<Result<String>> markMessageReceivedAsRead(@RequestBody List<Long> ids) {
        messageReceivedService.markMessageReceivedAsRead(ids);
        return Mono.just(Result.success());
    }

    @Operation(summary = "管理删除用户接受的消息", description = "管理删除用户接受的消息")
    @DeleteMapping("deleteMessageReceivedByIds")
    public Mono<Result<String>> deleteMessageReceivedByIds(@RequestBody List<Long> ids) {
        messageReceivedService.deleteMessageReceivedByIds(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }

    @Operation(summary = "根据消息id获取接收人信息", description = "根据消息id获取接收人信息")
    @GetMapping("noManage/getReceivedUserinfoByMessageId")
    public Mono<Result<List<MessageReceivedWithUserVo>>> getReceivedUserinfoByMessageId(Long messageId) {
        List<MessageReceivedWithUserVo> voList = messageReceivedService.getReceivedUserinfoByMessageId(messageId);
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "用户将消息标为已读", description = "用户将消息标为已读")
    @PutMapping("noManage/updateUserMarkAsRead")
    public Mono<Result<String>> updateUserMarkAsRead(@Valid @RequestBody List<Long> ids) {
        messageReceivedService.updateUserMarkAsRead(ids);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "添加系统消息", description = "添加系统消息")
    @PostMapping("addMessage")
    public Mono<Result<String>> addMessage(@Valid @RequestBody MessageAddDto dto) {
        messageReceivedService.addMessage(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新系统消息", description = "更新系统消息")
    @PutMapping("updateMessage")
    public Mono<Result<String>> updateMessage(@Valid @RequestBody MessageUpdateDto dto) {
        messageReceivedService.updateMessage(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

}
