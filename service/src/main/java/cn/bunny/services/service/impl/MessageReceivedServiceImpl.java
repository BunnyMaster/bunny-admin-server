package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.services.mapper.MessageReceivedMapper;
import cn.bunny.services.service.MessageReceivedService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
@Service
public class MessageReceivedServiceImpl extends ServiceImpl<MessageReceivedMapper, MessageReceived> implements MessageReceivedService {

    /**
     * 根据发送者id批量删除消息接受者
     *
     * @param sendUserIds 发送用户ID
     */
    @Override
    public void deleteBatchIdsWithPhysics(List<Long> sendUserIds) {
        baseMapper.deleteBatchIdsWithPhysics(sendUserIds);
    }
}
