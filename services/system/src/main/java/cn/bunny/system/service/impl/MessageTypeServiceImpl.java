package cn.bunny.system.service.impl;

import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.system.dto.MessageTypeDto;
import cn.bunny.domain.system.entity.MessageType;
import cn.bunny.domain.system.vo.MessageTypeVo;
import cn.bunny.system.mapper.MessageTypeMapper;
import cn.bunny.system.service.MessageTypeService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 系统消息类型 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 13:19:33
 */
@Service
@Transactional
public class MessageTypeServiceImpl extends ServiceImpl<MessageTypeMapper, MessageType> implements MessageTypeService {

    /**
     * * 系统消息类型 服务实现类
     *
     * @param pageParams 系统消息类型分页查询page对象
     * @param dto        系统消息类型分页查询对象
     * @return 查询分页系统消息类型返回对象
     */
    @Override
    public PageResult<MessageTypeVo> getMessageTypePage(Page<MessageType> pageParams, MessageTypeDto dto) {
        IPage<MessageTypeVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<MessageTypeVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加系统消息类型
     *
     * @param dto 系统消息类型添加
     */
    @Override
    public void createMessageType(MessageTypeDto dto) {
        // 保存数据
        MessageType messageType = new MessageType();
        BeanUtils.copyProperties(dto, messageType);
        save(messageType);
    }

    /**
     * 更新系统消息类型
     *
     * @param dto 系统消息类型更新
     */
    @Override
    public void updateMessageType(MessageTypeDto dto) {
        // 更新内容
        MessageType messageType = new MessageType();
        BeanUtils.copyProperties(dto, messageType);
        updateById(messageType);
    }

    /**
     * 删除|批量删除系统消息类型
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteMessageType(List<Long> ids) {
        removeByIds(ids);
    }

    /**
     * 获取所有消息类型
     *
     * @return 系统消息类型列表
     */
    @Override
    public List<MessageTypeVo> getMessageList() {
        return list(Wrappers.<MessageType>lambdaQuery().eq(MessageType::getStatus, true)).stream().map(messageType -> {
            MessageTypeVo messageTypeVo = new MessageTypeVo();
            BeanUtils.copyProperties(messageType, messageTypeVo);
            return messageTypeVo;
        }).toList();
    }
}
