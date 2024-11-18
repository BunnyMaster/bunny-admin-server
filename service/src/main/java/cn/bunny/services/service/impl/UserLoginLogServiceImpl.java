package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.dto.log.UserLoginLogDto;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.log.UserLoginLogLocalVo;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import cn.bunny.services.mapper.UserLoginLogMapper;
import cn.bunny.services.service.UserLoginLogService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
public class UserLoginLogServiceImpl extends ServiceImpl<UserLoginLogMapper, UserLoginLog> implements UserLoginLogService {

    /**
     * * 用户登录日志 服务实现类
     *
     * @param pageParams 用户登录日志分页查询page对象
     * @param dto        用户登录日志分页查询对象
     * @return 查询分页用户登录日志返回对象
     */
    @Override
    public PageResult<UserLoginLogVo> getUserLoginLogList(Page<UserLoginLog> pageParams, UserLoginLogDto dto) {
        IPage<UserLoginLogVo> page = baseMapper.selectListByPage(pageParams, dto);

        List<UserLoginLogVo> voList = page.getRecords().stream().map(userLoginLog -> {
            UserLoginLogVo userLoginLogVo = new UserLoginLogVo();
            BeanUtils.copyProperties(userLoginLog, userLoginLogVo);
            return userLoginLogVo;
        }).toList();

        return PageResult.<UserLoginLogVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 删除|批量删除用户登录日志
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteUserLoginLog(List<Long> ids) {
        // // 逻辑删除
        // removeBatchByIds(ids);

        // 物理删除
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 获取本地用户登录日志
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    @Override
    public PageResult<UserLoginLogLocalVo> getUserLoginLogListByLocalUser(Page<UserLoginLog> pageParams) {
        Long userId = BaseContext.getUserId();
        IPage<UserLoginLog> page = baseMapper.selectListByPageWithLocalUser(pageParams, userId);

        List<UserLoginLogLocalVo> voList = page.getRecords().stream().map(userLoginLog -> {
            UserLoginLogLocalVo userLoginLogVo = new UserLoginLogLocalVo();
            BeanUtils.copyProperties(userLoginLog, userLoginLogVo);
            return userLoginLogVo;
        }).toList();

        return PageResult.<UserLoginLogLocalVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }
}
