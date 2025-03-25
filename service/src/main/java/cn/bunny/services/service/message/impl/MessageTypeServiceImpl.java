package cn.bunny.services.service.message.impl;

import cn.bunny.dao.dto.system.message.MessageTypeAddDto;
import cn.bunny.dao.dto.system.message.MessageTypeDto;
import cn.bunny.dao.dto.system.message.MessageTypeUpdateDto;
import cn.bunny.dao.entity.system.MessageType;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageTypeVo;
import cn.bunny.services.mapper.MessageTypeMapper;
import cn.bunny.services.service.message.MessageTypeService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

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
public class MessageTypeServiceImpl extends ServiceImpl<MessageTypeMapper, MessageType> implements MessageTypeService {

    /**
     * * 系统消息类型 服务实现类
     *
     * @param pageParams 系统消息类型分页查询page对象
     * @param dto        系统消息类型分页查询对象
     * @return 查询分页系统消息类型返回对象
     */
    @Override
    public PageResult<MessageTypeVo> getMessageTypeList(Page<MessageType> pageParams, MessageTypeDto dto) {
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
    public void addMessageType(@Valid MessageTypeAddDto dto) {
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
    public void updateMessageType(@Valid MessageTypeUpdateDto dto) {
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
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * 获取所有消息类型
     *
     * @return 系统消息类型列表
     */
    @Override
    public List<MessageTypeVo> getNoManageMessageTypes() {
        return list(Wrappers.<MessageType>lambdaQuery().eq(MessageType::getStatus, true)).stream().map(messageType -> {
            MessageTypeVo messageTypeVo = new MessageTypeVo();
            BeanUtils.copyProperties(messageType, messageTypeVo);
            return messageTypeVo;
        }).toList();
    }
}
