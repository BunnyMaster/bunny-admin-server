package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.common.entity.BaseEntity;
import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageReceivedWithUserVo;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.MessageMapper;
import cn.bunny.services.mapper.MessageReceivedMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.service.MessageReceivedService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private UserFactory userFactory;

    /**
     * 管理员管理用户消息接收分页查询
     *
     * @param pageParams 系统消息分页查询page对象
     * @param dto        系统消息分页查询对象
     * @return 查询分页系统消息返回对象
     */
    @Override
    public PageResult<MessageReceivedWithMessageVo> getMessageReceivedList(Page<Message> pageParams, MessageDto dto) {
        // 分页查询消息数据
        IPage<MessageReceivedWithMessageVo> page = baseMapper.selectListByMessageReceivedPage(pageParams, dto);
        List<MessageReceivedWithMessageVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageReceivedWithMessageVo vo = new MessageReceivedWithMessageVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = userFactory.checkGetUserAvatar(cover);
            vo.setCover(cover);
            return vo;
        }).toList();
        return PageResult.<MessageReceivedWithMessageVo>builder().list(voList).pageNo(page.getCurrent())
                .pageSize(page.getSize()).total(page.getTotal())
                .build();
    }

    /**
     * 管理员将用户接受消息标为已读
     *
     * @param ids 用户消息表id
     */
    @Override
    public void markMessageReceivedAsRead(List<Long> ids) {
        List<MessageReceived> messageReceivedList = ids.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setId(id);
            messageReceived.setStatus(true);
            return messageReceived;
        }).toList();
        updateBatchById(messageReceivedList);
    }

    /**
     * 管理删除用户接受的消息
     *
     * @param ids 用户消息Id列表
     */
    @Override
    public void deleteMessageReceivedByIds(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
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

    /**
     * 添加系统消息
     * 判断发送消息的接收人是否为空，如果为空默认是所有用户都是接受者
     * 之后要将消息的接受者要保存在，消息接收表中，在这之前是没有消息id的
     * 先要保存消息内容，之后获取到保存消息的id
     * 将消息的id和接收者的id构建成map插入到消息接收表中
     *
     * @param dto 系统消息添加
     */
    @Override
    public void addMessage(@Valid MessageAddDto dto) {
        // 如果发送人为空设置当前登录的人的ID
        if (dto.getSendUserId() == null) dto.setSendUserId(BaseContext.getUserId());

        // 设置封面返回内容
        String cover = dto.getCover();
        dto.setCover(userFactory.checkGetUserAvatar(cover));

        // 先保存消息数据，之后拿到保存消息的id
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        message.setMessageType(dto.getMessageTypeId().toString());
        messageMapper.insert(message);

        // 如果接收人为空默认接收全部人
        List<Long> receivedUserIds = dto.getReceivedUserIds();
        if (receivedUserIds.isEmpty()) {
            receivedUserIds = userMapper.selectList(null).stream().map(BaseEntity::getId).toList();
        }

        // 从之前保存的消息中获取消息id，保存到消息接收表中
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(message.getId());
            messageReceived.setReceivedUserId(id);
            messageReceived.setStatus(false);
            return messageReceived;
        }).toList();

        saveBatch(receivedList);
    }


    /**
     * 更新系统消息
     *
     * @param dto 系统消息更新
     */
    @Override
    public void updateMessage(@Valid MessageUpdateDto dto) {
        // 如果发送人为空设置当前登录的人的ID
        Long sendUserId = dto.getSendUserId();
        if (sendUserId == null) dto.setSendUserId(BaseContext.getUserId());

        // 如果接收人为空默认接收全部人
        List<Long> receivedUserIds = dto.getReceivedUserIds();
        if (receivedUserIds.isEmpty()) {
            receivedUserIds = userMapper.selectList(null).stream().map(BaseEntity::getId).toList();
        }

        // 设置封面返回内容
        String cover = dto.getCover();
        dto.setCover(userFactory.checkGetUserAvatar(cover));

        // 更新内容
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        message.setMessageType(dto.getMessageTypeId().toString());
        messageMapper.updateById(message);

        // 保存消息和用户之间关联数据
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(dto.getId());
            messageReceived.setReceivedUserId(id);

            // 当更新的时当前消息用户表是否已读
            if (id.equals(dto.getReceivedUserId())) {
                messageReceived.setStatus(dto.getStatus());
            }
            return messageReceived;
        }).toList();

        // 删除这个消息id下所有用户消息关系内容
        baseMapper.deleteBatchIdsByMessageIdsWithPhysics(List.of(dto.getId()));

        // 插入接收者和消息表
        saveBatch(receivedList);
    }

    /**
     * 用户将消息标为已读
     * 将消息表中满足id条件全部标为已读
     *
     * @param ids 消息id列表
     */
    @Override
    public void updateUserMarkAsRead(List<Long> ids) {
        // 判断ids是否为空
        if (ids.isEmpty()) {
            throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }

        // 更新表中消息状态
        List<MessageReceived> messageList = ids.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setId(id);
            messageReceived.setStatus(true);
            return messageReceived;
        }).toList();

        updateBatchById(messageList);
    }

}
