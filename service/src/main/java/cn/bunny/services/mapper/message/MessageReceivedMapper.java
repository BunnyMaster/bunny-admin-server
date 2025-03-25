package cn.bunny.services.mapper.message;

import cn.bunny.dao.dto.system.message.MessageReceivedDto;
import cn.bunny.dao.dto.system.message.MessageUserDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.entity.system.MessageReceived;
import cn.bunny.dao.vo.system.message.MessageReceivedWithMessageVo;
import cn.bunny.dao.vo.system.message.MessageUserVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
@Mapper
public interface MessageReceivedMapper extends BaseMapper<MessageReceived> {

    /**
     * * 用户消息接收管理分页查询
     *
     * @param pageParams 系统消息分页参数
     * @param dto        系统消息查询表单
     * @return 系统消息分页结果
     */
    IPage<MessageReceivedWithMessageVo> selectListByMessageReceivedPage(@Param("page") Page<Message> pageParams, @Param("dto") MessageReceivedDto dto);

    /**
     * 根据id批量删除
     *
     * @param ids 主键ids
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);

    /**
     * 根据消息所有包含匹配当前消息Id的列表
     *
     * @param pageParams 系统消息分页参数
     * @param dto        系统消息查询表单
     * @return 系统消息分页结果
     */
    IPage<MessageUserVo> selectListByUserMessagePage(@Param("page") Page<Message> pageParams, @Param("dto") MessageUserDto dto, @Param("userId") Long userId);

    /**
     * 根据消息Id物理删除
     *
     * @param ids 消息id
     */
    void deleteBatchIdsByMessageIdsWithPhysics(List<Long> ids);
}
