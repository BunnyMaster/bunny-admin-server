package cn.bunny.services.service;

import cn.bunny.dao.entity.system.MessageReceived;
import com.baomidou.mybatisplus.extension.service.IService;

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
}
