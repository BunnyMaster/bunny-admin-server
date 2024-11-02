package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.common.entity.BaseEntity;
import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.dto.system.message.MessageUserDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
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

import java.util.ArrayList;
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
        // 分页查询消息数据
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
     * 分页查询用户消息
     * 用户在主页查询内容为：是否已读和消息类型
     * 为了方便用户之后进入消息详情页面查询，按照消息类型查询消息
     * 也可以查询消息是否已读
     * 节省带宽的情况下传给前端消息详情等内容
     *
     * @param pageParams 系统消息返回列表
     * @param dto        用户消息查询内容"
     * @return 分页结果
     */
    @Override
    public PageResult<MessageUserVo> getUserMessageList(Page<Message> pageParams, MessageUserDto dto) {
        // 查询当前用户需要接收的消息id
        List<MessageReceived> messageReceivedList = messageReceivedMapper.selectList(Wrappers.<MessageReceived>lambdaQuery().eq(MessageReceived::getReceivedUserId, BaseContext.getUserId()));
        List<Long> messageIds = messageReceivedList.stream().map(MessageReceived::getMessageId).toList();

        // 消息为空直接返回
        if (messageIds.isEmpty()) {
            return PageResult.<MessageUserVo>builder()
                    .list(new ArrayList<>())
                    .pageNo(pageParams.getCurrent())
                    .pageSize(pageParams.getSize())
                    .total(pageParams.getTotal())
                    .build();
        }

        // 根据消息所有包含匹配当前消息Id的列表
        IPage<Message> page = baseMapper.selectListByPageWithMessageUserDto(pageParams, dto, messageIds);
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

    /**
     * 根据消息id查询消息详情
     * 请求消息内容后标为已读
     *
     * @param id 消息id
     * @return 消息详情
     */
    @Override
    public MessageVo getMessageDetailById(Long id) {
        // 将消息设为已读
        Message message = new Message();
        message.setId(id);
        message.setStatus(true);
        updateById(message);

        // 返回详情内容给前端
        return baseMapper.selectMessageVoById(id);
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
        List<Message> messageList = ids.stream().map(id -> {
            Message message = new Message();
            message.setId(id);
            message.setStatus(true);
            return message;
        }).toList();

        updateBatchById(messageList);
    }

    /**
     * 用户删除消息
     *
     * @param ids 消息Id列表
     */
    @Override
    public void deleteUserMessageByIds(List<Long> ids) {
        // 判断ids是否为空
        if (ids.isEmpty()) {
            throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }

        // 删除消息表中数据
        baseMapper.deleteBatchIdsWithPhysics(ids);

        // 根据当前用户id删除消息接受表中数据
        Long userId = BaseContext.getUserId();
        messageReceivedMapper.deleteBatchIdsByMessageIdsAndUserIdWithPhysics(ids, userId);
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

        // 先保存消息数据，之后拿到保存消息的id
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
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

        // 更新内容
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);
        updateById(message);

        // 保存消息和用户之间关联数据
        List<MessageReceived> receivedList = receivedUserIds.stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setMessageId(dto.getId());
            messageReceived.setReceivedUserId(id);
            return messageReceived;
        }).toList();

        // 删除这个消息接受下所有发送者
        messageReceivedMapper.deleteBatchIdsByMessageIdsWithPhysics(List.of(dto.getId()));

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
        // 物理删除消息表数据
        baseMapper.deleteBatchIdsWithPhysics(ids);

        // 根据消息Id物理删除接受者消息
        messageReceivedMapper.deleteBatchIdsByMessageIdsWithPhysics(ids);
    }
}
