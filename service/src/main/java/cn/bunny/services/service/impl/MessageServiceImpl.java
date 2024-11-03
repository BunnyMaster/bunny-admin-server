package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.message.MessageDto;
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
import cn.bunny.services.service.MessageService;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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
    private UserFactory userFactory;

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
        return PageResult.<MessageVo>builder().list(voList).pageNo(page.getCurrent())
                .pageSize(page.getSize()).total(page.getTotal())
                .build();
    }

    /**
     * 分页查询用户消息
     * 查询用户消息关系表，找到当前用户所有的消息
     * 拿到用户消息关系表中数据只要MessageId
     * 根据MessageId分页查询消息表
     *
     * @param pageParams 系统消息返回列表
     * @param dto        用户消息查询内容
     * @return 分页结果
     */
    @Override
    public PageResult<MessageUserVo> getUserMessageList(Page<Message> pageParams, MessageUserDto dto) {
        // 根据消息所有包含匹配当前消息Id的列表
        IPage<MessageVo> page = baseMapper.selectListByPageWithMessageUserDto(pageParams, dto, BaseContext.getUserId());
        List<MessageUserVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageUserVo vo = new MessageUserVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = userFactory.checkGetUserAvatar(cover);
            vo.setCover(cover);
            return vo;
        }).toList();

        return PageResult.<MessageUserVo>builder().list(voList).pageNo(page.getCurrent())
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
    public MessageVo getMessageDetailById(Long id) {
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

        // 根据当前用户id删除消息接受表中数据
        messageReceivedMapper.deleteBatchIdsWithPhysics(ids);
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
