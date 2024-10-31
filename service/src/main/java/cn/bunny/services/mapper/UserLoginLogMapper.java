package cn.bunny.services.mapper;

import cn.bunny.dao.dto.log.UserLoginLogDto;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 用户登录日志 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19 01:01:01
 */
@Mapper
public interface UserLoginLogMapper extends BaseMapper<UserLoginLog> {

    /**
     * * 分页查询用户登录日志内容
     *
     * @param pageParams 用户登录日志分页参数
     * @param dto        用户登录日志查询表单
     * @return 用户登录日志分页结果
     */
    IPage<UserLoginLogVo> selectListByPage(@Param("page") Page<UserLoginLog> pageParams, @Param("dto") UserLoginLogDto dto);

    /**
     * 物理删除用户登录日志
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);

    /**
     * * 分页查询根据用户Id用户登录日志内容
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    IPage<UserLoginLog> selectListByPageWithLocalUser(Page<UserLoginLog> pageParams, Long id);
}
