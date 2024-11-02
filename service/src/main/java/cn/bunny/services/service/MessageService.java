package cn.bunny.services.service;

import cn.bunny.dao.dto.system.message.MessageAddDto;
import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.dto.system.message.MessageUpdateDto;
import cn.bunny.dao.dto.system.message.MessageUserDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.message.MessageUserVo;
import cn.bunny.dao.vo.system.message.MessageVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 系统消息 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
public interface MessageService extends IService<Message> {

    /**
     * * 获取系统消息列表
     *
     * @return 系统消息返回列表
     */
    PageResult<MessageVo> getMessageList(Page<Message> pageParams, MessageDto dto);

    /**
     * * 添加系统消息
     *
     * @param dto 添加表单
     */
    void addMessage(@Valid MessageAddDto dto);

    /**
     * * 更新系统消息
     *
     * @param dto 更新表单
     */
    void updateMessage(@Valid MessageUpdateDto dto);

    /**
     * * 删除|批量删除系统消息类型
     *
     * @param ids 删除id列表
     */
    void deleteMessage(List<Long> ids);

    /**
     * 分页查询用户消息
     *
     * @param pageParams 系统消息返回列表
     * @param dto        查询表单
     * @return 分页结果
     */
    PageResult<MessageUserVo> getUserMessageList(Page<Message> pageParams, MessageUserDto dto);

    /**
     * 根据消息id查询消息详情
     *
     * @param id 消息id
     * @return 消息详情
     */
    MessageVo getMessageDetailById(Long id);

    /**
     * 用户将消息标为已读
     *
     * @param ids 消息id列表
     */
    void updateUserMarkAsRead(List<Long> ids);

    /**
     * 用户删除消息
     *
     * @param ids 消息Id列表
     */
    void deleteUserMessageByIds(List<Long> ids);
}
