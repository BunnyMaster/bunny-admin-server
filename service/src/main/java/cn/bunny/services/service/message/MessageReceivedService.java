package cn.bunny.services.service.message;

import cn.bunny.dao.dto.system.message.MessageReceivedDto;
import cn.bunny.dao.dto.system.message.MessageReceivedUpdateDto;
import cn.bunny.dao.dto.system.message.MessageUserDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageUserVo;
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
