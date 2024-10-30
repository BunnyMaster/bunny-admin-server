package cn.bunny.services.mapper;

import cn.bunny.dao.dto.system.message.MessageDto;
import cn.bunny.dao.entity.system.Message;
import cn.bunny.dao.vo.system.message.MessageVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统消息 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Mapper
public interface MessageMapper extends BaseMapper<Message> {

    /**
     * * 分页查询系统消息内容
     *
     * @param pageParams 系统消息分页参数
     * @param dto        系统消息查询表单
     * @return 系统消息分页结果
     */
    IPage<MessageVo> selectListByPage(@Param("page") Page<Message> pageParams, @Param("dto") MessageDto dto);

    /**
     * 物理删除系统消息
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
