package cn.bunny.system.mapper;

import cn.bunny.domain.system.dto.MessageReceivedDto;
import cn.bunny.domain.system.dto.MessageUserDto;
import cn.bunny.domain.system.entity.Message;
import cn.bunny.domain.system.entity.MessageReceived;
import cn.bunny.domain.system.vo.MessageReceivedWithMessageVo;
import cn.bunny.domain.system.vo.MessageUserVo;
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
    IPage<MessageReceivedWithMessageVo> selectListByMessageReceivedPage(@Param("page" ) Page<Message> pageParams, @Param("dto" ) MessageReceivedDto dto);

    /**
     * 根据消息所有包含匹配当前消息Id的列表
     *
     * @param pageParams 系统消息分页参数
     * @param dto        系统消息查询表单
     * @return 系统消息分页结果
     */
    IPage<MessageUserVo> selectListByUserMessagePage(@Param("page" ) Page<Message> pageParams, @Param("dto" ) MessageUserDto dto, @Param("userId" ) Long userId);

    /**
     * 根据消息 id 列表删除
     *
     * @param ids 消息id列表
     */
    void deleteBatchMessageIds(List<Long> ids);
}
