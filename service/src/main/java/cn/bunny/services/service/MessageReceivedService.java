package cn.bunny.services.service;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
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
     * 根据发送者id批量删除消息接受者
     *
     * @param sendUserIds 发送用户ID
     */
    void deleteBatchIdsWithPhysics(List<Long> sendUserIds);

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
