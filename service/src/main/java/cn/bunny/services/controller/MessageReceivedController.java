package cn.bunny.services.controller;

import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
import cn.bunny.services.service.MessageReceivedService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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
}
