package cn.bunny.services.mapper.log;

import cn.bunny.domain.log.dto.UserLoginLogDto;
import cn.bunny.domain.log.entity.UserLoginLog;
import cn.bunny.domain.log.vo.UserLoginLogVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
     * * 分页查询根据用户Id用户登录日志内容
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    IPage<UserLoginLog> selectListByPageWithLocalUser(Page<UserLoginLog> pageParams, Long id);
}
