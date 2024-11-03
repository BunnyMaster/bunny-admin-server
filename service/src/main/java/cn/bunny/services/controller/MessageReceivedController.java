package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
import cn.bunny.services.service.MessageReceivedService;
import io.swagger.v3.oas.annotations.Operation;
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

    @Operation(summary = "根据消息id获取接收人信息", description = "根据消息id获取接收人信息")
    @GetMapping("noManage/getReceivedUserinfoByMessageId")
    public Mono<Result<List<MessageReceivedWithUserVo>>> getReceivedUserinfoByMessageId(Long messageId) {
        List<MessageReceivedWithUserVo> voList = messageReceivedService.getReceivedUserinfoByMessageId(messageId);
        return Mono.just(Result.success(voList));
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

    @Operation(summary = "用户将消息标为已读", description = "用户将消息标为已读")
    @PutMapping("noManage/updateUserMarkAsRead")
    public Mono<Result<String>> updateUserMarkAsRead(@Valid @RequestBody List<Long> ids) {
        messageReceivedService.updateUserMarkAsRead(ids);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }
}
