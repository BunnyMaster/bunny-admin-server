package cn.bunny.services.controller.message;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.model.message.dto.MessageTypeDto;
import cn.bunny.domain.model.message.entity.MessageType;
import cn.bunny.domain.model.message.vo.MessageTypeVo;
import cn.bunny.services.service.message.MessageTypeService;
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
 * 系统消息类型 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 13:19:33
 */
@Tag(name = "消息类型", description = "系统消息类型相关接口")
@PermissionTag(permission = "messageType:*")
@RestController
@RequestMapping("api/messageType")
public class MessageTypeController {

    @Resource
    private MessageTypeService messageTypeService;

    @Operation(summary = "分页查询消息类型", description = "分页查询系统消息类型")
    @PermissionTag(permission = "messageType:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<MessageTypeVo>> getMessageTypePage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            MessageTypeDto dto) {
        Page<MessageType> pageParams = new Page<>(page, limit);
        PageResult<MessageTypeVo> pageResult = messageTypeService.getMessageTypePage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加消息类型", description = "添加系统消息类型")
    @PermissionTag(permission = "messageType:add")
    @PostMapping()
    public Result<String> createMessageType(@Validated(ValidationGroups.Add.class) @RequestBody MessageTypeDto dto) {
        messageTypeService.createMessageType(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新消息类型", description = "更新系统消息类型")
    @PermissionTag(permission = "messageType:update")
    @PutMapping()
    public Result<String> updateMessageType(@Validated(ValidationGroups.Update.class) @RequestBody MessageTypeDto dto) {
        messageTypeService.updateMessageType(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除消息类型", description = "删除系统消息类型")
    @PermissionTag(permission = "messageType:delete")
    @DeleteMapping()
    public Result<String> deleteMessageType(@RequestBody List<Long> ids) {
        messageTypeService.deleteMessageType(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "所有消息列表", description = "获取所有消息列表")
    @GetMapping("private/messages")
    public Result<List<MessageTypeVo>> getMessageList() {
        List<MessageTypeVo> voList = messageTypeService.getMessageList();
        return Result.success(voList);
    }
}
