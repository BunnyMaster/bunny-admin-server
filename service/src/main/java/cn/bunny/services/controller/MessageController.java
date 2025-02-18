package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageDetailVo;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
import cn.bunny.dao.vo.system.message.MessageVo;
import cn.bunny.services.service.MessageService;
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
 * 系统消息表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Tag(name = "系统消息", description = "系统消息相关接口")
@RestController
@RequestMapping("admin/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Operation(summary = "分页查询发送消息", description = "分页查询发送消息")
    @GetMapping("getMessageList/{page}/{limit}")
    public Mono<Result<PageResult<MessageVo>>> getMessageList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageVo> pageResult = messageService.getMessageList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "根据消息id查询消息详情", description = "根据消息id查询消息详情")
    @GetMapping("noManage/getMessageDetailById")
    public Mono<Result<MessageDetailVo>> getMessageDetailById(Long id) {
        MessageDetailVo vo = messageService.getMessageDetailById(id);
        return Mono.just(Result.success(vo));
    }

    @Operation(summary = "根据消息id获取接收人信息", description = "根据消息id获取接收人信息")
    @GetMapping("noManage/getReceivedUserinfoByMessageId")
    public Mono<Result<List<MessageReceivedWithUserVo>>> getReceivedUserinfoByMessageId(Long messageId) {
        List<MessageReceivedWithUserVo> voList = messageService.getReceivedUserinfoByMessageId(messageId);
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加系统消息", description = "添加系统消息")
    @PostMapping("addMessage")
    public Mono<Result<String>> addMessage(@Valid @RequestBody MessageAddDto dto) {
        messageService.addMessage(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新系统消息", description = "更新系统消息")
    @PutMapping("updateMessage")
    public Mono<Result<String>> updateMessage(@Valid @RequestBody MessageUpdateDto dto) {
        messageService.updateMessage(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除系统消息", description = "删除系统消息")
    @DeleteMapping("deleteMessage")
    public Mono<Result<String>> deleteMessage(@RequestBody List<Long> ids) {
        messageService.deleteMessage(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
