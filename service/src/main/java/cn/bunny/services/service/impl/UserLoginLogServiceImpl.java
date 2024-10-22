package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.dto.log.UserLoginLogDto;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import cn.bunny.services.factory.UserLoginLogFactory;
import cn.bunny.services.mapper.UserLoginLogMapper;
import cn.bunny.services.service.UserLoginLogService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 用户登录日志 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19 01:01:01
 */
@Service
public class UserLoginLogServiceImpl extends ServiceImpl<UserLoginLogMapper, UserLoginLog> implements UserLoginLogService {

    @Autowired
    private UserLoginLogFactory factory;

    /**
     * * 用户登录日志 服务实现类
     *
     * @param pageParams 用户登录日志分页查询page对象
     * @param dto        用户登录日志分页查询对象
     * @return 查询分页用户登录日志返回对象
     */
    @Override
    public PageResult<UserLoginLogVo> getUserLoginLogList(Page<UserLoginLog> pageParams, UserLoginLogDto dto) {
        // 分页查询菜单图标
        IPage<UserLoginLog> page = baseMapper.selectListByPage(pageParams, dto);

        return factory.getUserLoginLogVoPageResult(page);
    }

    /**
     * 删除|批量删除用户登录日志
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteUserLoginLog(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 获取本地用户登录日志
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    @Override
    public PageResult<UserLoginLogVo> getUserLoginLogListByLocalUser(Page<UserLoginLog> pageParams) {
        Long userId = BaseContext.getUserId();
        IPage<UserLoginLog> page = baseMapper.selectListByPageWithLocalUser(pageParams, userId);

        return factory.getUserLoginLogVoPageResult(page);
    }
}
