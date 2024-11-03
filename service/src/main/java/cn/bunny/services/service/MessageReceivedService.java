package cn.bunny.services.service;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
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
    PageResult<MessageReceivedWithMessageVo> getMessageReceivedList(Page<Message> pageParams, MessageDto dto);

    /**
     * 管理员将用户接受消息标为已读
     *
     * @param ids 用户消息表id
     */
    void markMessageReceivedAsRead(List<Long> ids);

    /**
     * 管理删除用户接受的消息
     *
     * @param ids 用户消息Id列表
     */
    void deleteMessageReceivedByIds(List<Long> ids);

    /**
     * 根据消息id获取接收人信息
     *
     * @param messageId 消息id
     * @return 消息接收人用户名等信息
     */
    List<MessageReceivedWithUserVo> getReceivedUserinfoByMessageId(Long messageId);

    /**
     * * 添加系统消息
     *
     * @param dto 添加表单
     */
    void addMessage(@Valid MessageAddDto dto);

    /**
     * 用户将消息标为已读
     *
     * @param ids 消息id列表
     */
    void updateUserMarkAsRead(List<Long> ids);

    /**
     * * 更新系统消息
     *
     * @param dto 更新表单
     */
    void updateMessage(@Valid MessageUpdateDto dto);

}
