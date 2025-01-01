package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.message.MessageTypeAddDto;
import cn.bunny.dao.dto.system.message.MessageTypeDto;
import cn.bunny.dao.dto.system.message.MessageTypeUpdateDto;
import cn.bunny.dao.entity.system.MessageType;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageTypeVo;
import cn.bunny.services.service.MessageTypeService;
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
 * 系统消息类型表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 13:19:33
 */
@Tag(name = "系统消息类型", description = "系统消息类型相关接口")
@RestController
@RequestMapping("admin/messageType")
public class MessageTypeController {

    @Autowired
    private MessageTypeService messageTypeService;

    @Operation(summary = "分页查询系统消息类型", description = "分页查询系统消息类型")
    @GetMapping("getMessageTypeList/{page}/{limit}")
    public Mono<Result<PageResult<MessageTypeVo>>> getMessageTypeList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageTypeDto dto) {
        Page<MessageType> pageParams = new Page<>(page, limit);
        PageResult<MessageTypeVo> pageResult = messageTypeService.getMessageTypeList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有消息类型", description = "获取所有消息类型")
    @GetMapping("noManage/getAllMessageTypes")
    public Mono<Result<List<MessageTypeVo>>> getNoManageMessageTypes() {
        List<MessageTypeVo> voList = messageTypeService.getNoManageMessageTypes();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加系统消息类型", description = "添加系统消息类型")
    @PostMapping("addMessageType")
    public Mono<Result<String>> addMessageType(@Valid @RequestBody MessageTypeAddDto dto) {
        messageTypeService.addMessageType(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新系统消息类型", description = "更新系统消息类型")
    @PutMapping("updateMessageType")
    public Mono<Result<String>> updateMessageType(@Valid @RequestBody MessageTypeUpdateDto dto) {
        messageTypeService.updateMessageType(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除系统消息类型", description = "删除系统消息类型")
    @DeleteMapping("deleteMessageType")
    public Mono<Result<String>> deleteMessageType(@RequestBody List<Long> ids) {
        messageTypeService.deleteMessageType(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
