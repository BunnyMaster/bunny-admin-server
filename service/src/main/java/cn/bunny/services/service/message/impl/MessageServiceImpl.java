package cn.bunny.services.service.message.impl;

import cn.bunny.services.domain.common.entity.BaseEntity;
import cn.bunny.services.domain.system.message.dto.MessageAddDto;
import cn.bunny.services.domain.system.message.dto.MessageDto;
import cn.bunny.services.domain.system.message.dto.MessageUpdateDto;
import cn.bunny.services.domain.system.message.entity.Message;
import cn.bunny.services.domain.system.message.entity.MessageReceived;
import cn.bunny.services.domain.system.message.vo.MessageDetailVo;
import cn.bunny.services.domain.system.message.vo.MessageReceivedWithMessageVo;
import cn.bunny.services.domain.system.message.vo.MessageReceivedWithUserVo;
import cn.bunny.services.domain.system.message.vo.MessageVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import cn.bunny.services.domain.common.vo.result.ResultCodeEnum;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.message.MessageMapper;
import cn.bunny.services.mapper.message.MessageReceivedMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.service.message.MessageReceivedService;
import cn.bunny.services.service.message.MessageService;
import cn.bunny.services.utils.system.UserUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    @Resource
    private UserUtil userUtil;

    @Resource
    private MessageReceivedMapper messageReceivedMapper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private MessageReceivedService messageReceivedService;

    /**
     * 分页查询发送消息
     *
     * @param pageParams 分页参数
     * @param dto        查询表单
     * @return 系统消息返回列表
     */
    @Override
    public PageResult<MessageVo> getMessagePage(Page<Message> pageParams, MessageDto dto) {
        IPage<MessageReceivedWithMessageVo> page = baseMapper.selectListByPage(pageParams, dto);
        List<MessageReceivedWithMessageVo> records = page.getRecords();

        // 接受人昵称
        Map<Long, List<String>> receivedUserNicknameMap = records.stream()
                .collect(Collectors.groupingBy(
                        MessageReceivedWithMessageVo::getId,
                        Collectors.mapping(MessageReceivedWithMessageVo::getReceivedUserNickname, Collectors.toList())));

        // 接收人id
        Map<Long, List<String>> receivedUserIdMap = records.stream()
                .collect(Collectors.groupingBy(
                        MessageReceivedWithMessageVo::getId,
                        Collectors.mapping(messageWithMessageReceivedVo -> messageWithMessageReceivedVo.getId().toString(), Collectors.toList())));

        List<MessageVo> voList = records.stream()
                .map(messageWithMessageReceivedVo -> {
                    MessageVo messageVo = new MessageVo();
                    BeanUtils.copyProperties(messageWithMessageReceivedVo, messageVo);
                    messageVo.setReceivedUserNickname(receivedUserNicknameMap.get(messageWithMessageReceivedVo.getId()));
                    messageVo.setReceivedUserId(receivedUserIdMap.get(messageWithMessageReceivedVo.getId()));
                    return messageVo;
                }).distinct().toList();

        return PageResult.<MessageVo>builder().list(voList).pageNo(page.getCurrent())
                .pageSize(page.getSize()).total(page.getTotal())
                .build();
    }

    /**
     * 根据消息id查询消息详情
     * 请求消息内容后标为已读
     *
     * @param id 消息id
     * @return 消息详情
     */
    @Override
    public MessageDetailVo getMessageDetailById(Long id) {
        // 将消息设为已读
        MessageReceived messageReceived = new MessageReceived();
        messageReceived.setReceivedUserId(BaseContext.getUserId());
        messageReceived.setMessageId(id);
        messageReceived.setStatus(true);

        // 更新满足条件的消息用户表
        LambdaUpdateWrapper<MessageReceived> wrapper = Wrappers.<MessageReceived>lambdaUpdate()
                .eq(MessageReceived::getMessageId, id)
                .eq(MessageReceived::getReceivedUserId, BaseContext.getUserId());
        messageReceivedMapper.update(messageReceived, wrapper);

        // 返回详情内容给前端
        return baseMapper.selectMessageVoById(id);
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
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
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
        dto.setCover(userUtil.checkGetUserAvatar(cover));

        // 先保存消息数据，之后拿到保存消息的id
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        message.setMessageType(dto.getMessageTypeId().toString());
        save(message);

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

        // 如果接收人为空默认接收全部人
        List<Long> receivedUserIds = dto.getReceivedUserIds();
        if (receivedUserIds.isEmpty()) {
            receivedUserIds = userMapper.selectList(null).stream().map(BaseEntity::getId).toList();
        }

        // 设置封面返回内容
        String cover = dto.getCover();
        dto.setCover(userUtil.checkGetUserAvatar(cover));

        // 更新内容
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        message.setMessageType(dto.getMessageTypeId().toString());
        baseMapper.updateById(message);

        // 保存消息和用户之间关联数据
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(dto.getId());
            messageReceived.setReceivedUserId(id);
            return messageReceived;
        }).toList();

        // 删除这个消息id下所有用户消息关系内容
        messageReceivedMapper.deleteBatchIds(List.of(dto.getId()));

        // 插入接收者和消息表
        messageReceivedService.saveBatch(receivedList);
    }

    /**
     * 删除|批量删除系统消息
     * 删除消息表中的数据，还要删除消息接收表中的消息
     * 消息接收表根据消息id进行删除
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteMessage(List<Long> ids) {
        // 根据消息id删除
        removeByIds(ids);

        // 根据消息Id物理删除用户消息表
        messageReceivedMapper.deleteBatchMessageIds(ids);
    }
}
