package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.common.entity.BaseEntity;
import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageUserVo;
import cn.bunny.dao.vo.system.message.MessageVo;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.MessageMapper;
import cn.bunny.services.mapper.MessageReceivedMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.service.MessageReceivedService;
import cn.bunny.services.service.MessageService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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
 * 系统消息 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Service
@Transactional
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements MessageService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserFactory userFactory;

    @Autowired
    private MessageReceivedService messageReceivedService;

    @Autowired
    private MessageReceivedMapper messageReceivedMapper;

    /**
     * * 系统消息 服务实现类
     *
     * @param pageParams 系统消息分页查询page对象
     * @param dto        系统消息分页查询对象
     * @return 查询分页系统消息返回对象
     */
    @Override
    public PageResult<MessageVo> getMessageList(Page<Message> pageParams, MessageDto dto) {
        IPage<MessageVo> page = baseMapper.selectListByPage(pageParams, dto);

        List<MessageVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageVo vo = new MessageVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = userFactory.checkGetUserAvatar(cover);
            vo.setCover(cover);
            return vo;
        }).toList();
        return PageResult.<MessageVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加系统消息
     *
     * @param dto 系统消息添加
     */
    @Override
    public void addMessage(@Valid MessageAddDto dto) {
        // 如果发送人为空设置当前登录的人的ID
        Long sendUserId = dto.getSendUserId();
        if (sendUserId == null) dto.setSendUserId(BaseContext.getUserId());

        // 接受人id列表
        List<Long> receivedUserIds = dto.getReceivedUserIds();

        // 如果接收人为空默认接收全部人
        if (receivedUserIds.isEmpty()) {
            List<Long> userIds = userMapper.selectList(null).stream().map(BaseEntity::getId).toList();
            dto.setReceivedUserIds(userIds);
        }

        // 保存消息数据
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        save(message);

        // 保存消息和用户之间关联数据
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(dto.getSendUserId());
            messageReceived.setReceivedUserId(id);
            return messageReceived;
        }).toList();
        messageReceivedService.saveBatch(receivedList);
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

        // 接受人id列表
        List<Long> receivedUserIds = dto.getReceivedUserIds();

        // 如果接收人为空默认接收全部人
        if (receivedUserIds.isEmpty()) {
            List<Long> userIds = userMapper.selectList(null).stream().map(BaseEntity::getId).toList();
            dto.setReceivedUserIds(userIds);
        }

        // 更新内容
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        updateById(message);

        // 删除这个消息接受下所有发送者
        if (sendUserId != null) {
            messageReceivedMapper.deleteBatchIdsWithPhysics(List.of(sendUserId));
        }

        // 保存消息和用户之间关联数据
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(dto.getSendUserId());
            messageReceived.setReceivedUserId(id);
            return messageReceived;
        }).toList();
        messageReceivedService.saveBatch(receivedList);
    }

    /**
     * 删除|批量删除系统消息
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteMessage(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
        
        // 根据消息Id物理删除接受者消息
        messageReceivedMapper.deleteBatchIdsByMessageIdsWithPhysics(ids);
    }

    /**
     * 分页查询用户消息
     *
     * @param pageParams 系统消息返回列表
     * @return 分页结果
     */
    @Override
    public PageResult<MessageUserVo> getUserMessageList(Page<Message> pageParams) {
        // 查询当前用户接收的消息的接收者关系表
        List<MessageReceived> messageReceivedList = messageReceivedMapper.selectList(Wrappers.<MessageReceived>lambdaQuery().eq(MessageReceived::getReceivedUserId, BaseContext.getUserId()));
        List<Long> messageIds = messageReceivedList.stream().map(MessageReceived::getMessageId).toList();

        // 根据消息所有包含匹配当前消息Id的列表
        Page<Message> page = page(pageParams, Wrappers.<Message>lambdaQuery().in(Message::getId, messageIds));
        List<MessageUserVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageUserVo vo = new MessageUserVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = userFactory.checkGetUserAvatar(cover);
            vo.setCover(cover);
            return vo;
        }).toList();
        return PageResult.<MessageUserVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }
}
