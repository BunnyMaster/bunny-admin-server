package cn.bunny.services.service.message.impl;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.domain.system.message.dto.MessageReceivedDto;
import cn.bunny.services.domain.system.message.dto.MessageReceivedUpdateDto;
import cn.bunny.services.domain.system.message.dto.MessageUserDto;
import cn.bunny.services.domain.system.message.entity.Message;
import cn.bunny.services.domain.system.message.entity.MessageReceived;
import cn.bunny.services.domain.system.message.vo.MessageReceivedWithMessageVo;
import cn.bunny.services.domain.system.message.vo.MessageUserVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.message.MessageReceivedMapper;
import cn.bunny.services.minio.MinioHelper;
import cn.bunny.services.service.message.MessageReceivedService;
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

    @Resource
    private MinioHelper minioHelper;

    /**
     * 管理员管理用户消息接收分页查询
     *
     * @param pageParams 系统消息分页查询page对象
     * @param dto        系统消息分页查询对象
     * @return 查询分页系统消息返回对象
     */
    @Override
    public PageResult<MessageReceivedWithMessageVo> getMessageReceivedPage(Page<Message> pageParams, MessageReceivedDto dto) {
        // 分页查询消息数据
        IPage<MessageReceivedWithMessageVo> page = baseMapper.selectListByMessageReceivedPage(pageParams, dto);
        List<MessageReceivedWithMessageVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageReceivedWithMessageVo vo = new MessageReceivedWithMessageVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = minioHelper.getUserAvatar(cover);
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
     * @param dto 用户消息表单
     */
    @Override
    public void updateMarkMessageReceived(@Valid MessageReceivedUpdateDto dto) {
        List<MessageReceived> messageReceivedList = dto.getIds().stream().map(id -> {
            MessageReceived messageReceived = new MessageReceived();
            messageReceived.setId(id);
            messageReceived.setStatus(dto.getStatus());
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
    public void deleteMessageReceived(List<Long> ids) {
        removeByIds(ids);
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
    public PageResult<MessageUserVo> getMessagePageByUser(Page<Message> pageParams, MessageUserDto dto) {
        // 根据消息所有包含匹配当前消息Id的列表
        IPage<MessageUserVo> page = baseMapper.selectListByUserMessagePage(pageParams, dto, BaseContext.getUserId());
        List<MessageUserVo> voList = page.getRecords().stream().map(messageVo -> {
            MessageUserVo vo = new MessageUserVo();
            BeanUtils.copyProperties(messageVo, vo);

            // 设置封面返回内容
            String cover = vo.getCover();
            cover = minioHelper.getUserAvatar(cover);
            vo.setCover(cover);
            return vo;
        }).toList();

        return PageResult.<MessageUserVo>builder().list(voList).pageNo(page.getCurrent())
                .pageSize(page.getSize()).total(page.getTotal())
                .build();
    }

    /**
     * 用户将消息标为已读
     * 将消息表中满足id条件全部标为已读
     *
     * @param ids 消息id列表
     */
    @Override
    public void markAsReadByUser(List<Long> ids) {
        // 判断ids是否为空
        if (ids.isEmpty()) {
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
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

    /**
     * 用户删除消息
     *
     * @param ids 消息Id列表
     */
    @Override
    public void deleteMessageByUser(List<Long> ids) {
        // 判断ids是否为空
        if (ids.isEmpty()) {
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }

        // 判断删除的是否是自己的消息
        List<MessageReceived> messageReceivedList = list(Wrappers.<MessageReceived>lambdaQuery().in(MessageReceived::getReceivedUserId, ids));
        messageReceivedList.forEach(messageReceived -> {
            if (!messageReceived.getReceivedUserId().equals(BaseContext.getUserId())) {
                throw new AuthCustomerException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);
            }
        });

        // 根据当前用户id删除消息接受表中数据
        removeByIds(ids);
    }

}
