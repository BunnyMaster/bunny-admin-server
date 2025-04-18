package cn.bunny.services.service.message;

import cn.bunny.domain.message.dto.MessageReceivedDto;
import cn.bunny.domain.message.dto.MessageReceivedUpdateDto;
import cn.bunny.domain.message.dto.MessageUserDto;
import cn.bunny.domain.message.entity.Message;
import cn.bunny.domain.message.entity.MessageReceived;
import cn.bunny.domain.message.vo.MessageReceivedWithMessageVo;
import cn.bunny.domain.message.vo.MessageUserVo;
import cn.bunny.domain.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
public interface MessageReceivedService extends IService<MessageReceived> {

    /**
     * 管理员管理用户消息接收分页查询
     *
     * @return 系统消息返回列表
     */
    PageResult<MessageReceivedWithMessageVo> getMessageReceivedList(Page<Message> pageParams, MessageReceivedDto dto);

    /**
     * 管理员将用户接受消息标为已读
     *
     * @param dto 用户消息表单
     */
    void updateMarkMessageReceived(@Valid MessageReceivedUpdateDto dto);

    /**
     * 管理删除用户接受的消息
     *
     * @param ids 用户消息Id列表
     */
    void deleteMessageReceivedByIds(List<Long> ids);

    /**
     * 分页查询用户消息
     *
     * @param pageParams 系统消息返回列表
     * @param dto        查询表单
     * @return 分页结果
     */
    PageResult<MessageUserVo> getUserMessageList(Page<Message> pageParams, MessageUserDto dto);

    /**
     * 用户将消息标为已读
     *
     * @param ids 消息id列表
     */
    void userMarkAsRead(List<Long> ids);

    /**
     * 用户删除消息
     *
     * @param ids 消息Id列表
     */
    void deleteUserMessageByIds(List<Long> ids);
}
