package cn.bunny.services.mapper.message;

import cn.bunny.services.domain.system.message.dto.MessageTypeDto;
import cn.bunny.services.domain.system.message.entity.MessageType;
import cn.bunny.services.domain.system.message.vo.MessageTypeVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 系统消息类型 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 13:19:33
 */
@Mapper
public interface MessageTypeMapper extends BaseMapper<MessageType> {

    /**
     * * 分页查询系统消息类型内容
     *
     * @param pageParams 系统消息类型分页参数
     * @param dto        系统消息类型查询表单
     * @return 系统消息类型分页结果
     */
    IPage<MessageTypeVo> selectListByPage(@Param("page") Page<MessageType> pageParams, @Param("dto") MessageTypeDto dto);

}
