package cn.bunny.services.service.log;

import cn.bunny.services.domain.system.log.dto.UserLoginLogDto;
import cn.bunny.services.domain.system.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.log.vo.UserLoginLogLocalVo;
import cn.bunny.services.domain.system.log.vo.UserLoginLogVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 用户登录日志 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19 01:01:01
 */
public interface UserLoginLogService extends IService<UserLoginLog> {

    /**
     * * 获取用户登录日志列表
     *
     * @return 用户登录日志返回列表
     */
    PageResult<UserLoginLogVo> getUserLoginLogPage(Page<UserLoginLog> pageParams, UserLoginLogDto dto);

    /**
     * * 删除|批量删除用户登录日志类型
     *
     * @param ids 删除id列表
     */
    void deleteUserLoginLog(List<Long> ids);

    /**
     * * 获取本地用户登录日志
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    PageResult<UserLoginLogLocalVo> getUserLoginLogPageByUser(Page<UserLoginLog> pageParams);
}
