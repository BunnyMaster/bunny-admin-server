package cn.bunny.services.controller.message;

import cn.bunny.services.domain.system.message.dto.MessageAddDto;
import cn.bunny.services.domain.system.message.dto.MessageDto;
import cn.bunny.services.domain.system.message.dto.MessageUpdateDto;
import cn.bunny.services.domain.system.message.entity.Message;
import cn.bunny.services.domain.system.message.vo.MessageDetailVo;
import cn.bunny.services.domain.system.message.vo.MessageReceivedWithUserVo;
import cn.bunny.services.domain.system.message.vo.MessageVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.service.message.MessageService;
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
 * 系统消息表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Tag(name = "系统消息", description = "系统消息相关接口")
@RestController
@RequestMapping("api/message")
public class MessageController {

    @Resource
    private MessageService messageService;

    @Operation(summary = "分页查询", description = "分页查询发送消息", tags = "message::query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<MessageVo>> getMessagePage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageDto dto) {
        Page<Message> pageParams = new Page<>(page, limit);
        PageResult<MessageVo> pageResult = messageService.getMessagePage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加", description = "添加系统消息", tags = "message::add")
    @PostMapping()
    public Result<String> addMessage(@Valid @RequestBody MessageAddDto dto) {
        messageService.addMessage(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新", description = "更新系统消息", tags = "message::update")
    @PutMapping()
    public Result<String> updateMessage(@Valid @RequestBody MessageUpdateDto dto) {
        messageService.updateMessage(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除", description = "删除系统消息", tags = "message::delete")
    @DeleteMapping()
    public Result<String> deleteMessage(@RequestBody List<Long> ids) {
        messageService.deleteMessage(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "根据消息id查询消息详情", description = "根据消息id查询消息详情", tags = "message::query")
    @GetMapping("private/getMessageDetailById")
    public Result<MessageDetailVo> getMessageDetailById(Long id) {
        MessageDetailVo vo = messageService.getMessageDetailById(id);
        return Result.success(vo);
    }

    @Operation(summary = "根据消息id获取接收人信息", description = "根据消息id获取接收人信息", tags = "message::query")
    @GetMapping("private/getReceivedUserinfoByMessageId")
    public Result<List<MessageReceivedWithUserVo>> getReceivedUserinfoByMessageId(Long messageId) {
        List<MessageReceivedWithUserVo> voList = messageService.getReceivedUserinfoByMessageId(messageId);
        return Result.success(voList);
    }
}
