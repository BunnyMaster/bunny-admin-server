package cn.bunny.services.service;

import cn.bunny.dao.dto.system.message.MessageTypeAddDto;
import cn.bunny.dao.dto.system.message.MessageTypeDto;
import cn.bunny.dao.dto.system.message.MessageTypeUpdateDto;
import cn.bunny.dao.entity.system.MessageType;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageTypeVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 系统消息类型 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 13:19:33
 */
public interface MessageTypeService extends IService<MessageType> {

    /**
     * * 获取系统消息类型列表
     *
     * @return 系统消息类型返回列表
     */
    PageResult<MessageTypeVo> getMessageTypeList(Page<MessageType> pageParams, MessageTypeDto dto);

    /**
     * * 添加系统消息类型
     *
     * @param dto 添加表单
     */
    void addMessageType(@Valid MessageTypeAddDto dto);

    /**
     * * 更新系统消息类型
     *
     * @param dto 更新表单
     */
    void updateMessageType(@Valid MessageTypeUpdateDto dto);

    /**
     * * 删除|批量删除系统消息类型类型
     *
     * @param ids 删除id列表
     */
    void deleteMessageType(List<Long> ids);

    /**
     * 获取所有消息类型
     *
     * @return 系统消息类型列表
     */
    List<MessageTypeVo> getNoManageMessageTypes();
}
