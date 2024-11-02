package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
import cn.bunny.services.mapper.MessageReceivedMapper;
import cn.bunny.services.service.MessageReceivedService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
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

    /**
     * 根据消息id获取接收人信息
     *
     * @param messageId 消息id
     * @return 消息接收人用户名等信息
     */
    @Override
    public List<MessageReceivedWithUserVo> getReceivedUserinfoByMessageId(Long messageId) {
        if (messageId == null) {
            throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }
        return baseMapper.selectUserinfoListByMessageId(messageId);
    }
}
