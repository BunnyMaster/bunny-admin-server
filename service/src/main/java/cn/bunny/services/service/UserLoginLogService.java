package cn.bunny.services.service;

import cn.bunny.dao.dto.log.UserLoginLogAddDto;
import cn.bunny.dao.dto.log.UserLoginLogDto;
import cn.bunny.dao.dto.log.UserLoginLogUpdateDto;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 用户登录日志 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 22:36:07
 */
public interface UserLoginLogService extends IService<UserLoginLog> {

    /**
     * * 获取用户登录日志列表
     *
     * @return 用户登录日志返回列表
     */
    PageResult<UserLoginLogVo> getUserLoginLogList(Page<UserLoginLog> pageParams, UserLoginLogDto dto);

    /**
     * * 添加用户登录日志
     *
     * @param dto 添加表单
     */
    void addUserLoginLog(@Valid UserLoginLogAddDto dto);

    /**
     * * 更新用户登录日志
     *
     * @param dto 更新表单
     */
    void updateUserLoginLog(@Valid UserLoginLogUpdateDto dto);

    /**
     * * 删除|批量删除用户登录日志类型
     *
     * @param ids 删除id列表
     */
    void deleteUserLoginLog(List<Long> ids);
}
