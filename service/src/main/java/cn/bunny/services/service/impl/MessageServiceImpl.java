package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageVo;
import cn.bunny.services.mapper.MessageMapper;
import cn.bunny.services.service.MessageService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import jodd.util.StringUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

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
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements MessageService {

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
        // 保存数据
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);

        // 将发送用户逗号分隔
        String receivedUserIds = StringUtil.join(dto.getReceivedUserIds(), ",");
        message.setReceivedUserIds(receivedUserIds);
        save(message);
    }

    /**
     * 更新系统消息
     *
     * @param dto 系统消息更新
     */
    @Override
    public void updateMessage(@Valid MessageUpdateDto dto) {
        // 更新内容
        Message message = new Message();
        BeanUtils.copyProperties(dto, message);

        // 将发送用户逗号分隔
        String receivedUserIds = StringUtil.join(dto.getReceivedUserIds(), ",");
        message.setReceivedUserIds(receivedUserIds);
        updateById(message);
    }

    /**
     * 删除|批量删除系统消息
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteMessage(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
