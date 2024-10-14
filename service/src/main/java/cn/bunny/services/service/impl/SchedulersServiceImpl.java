package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.dto.schedulers.SchedulersUpdateDto;
import cn.bunny.dao.entity.schedulers.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import cn.bunny.services.mapper.SchedulersMapper;
import cn.bunny.services.service.SchedulersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * Schedulers视图 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-14 20:59:25
 */
@Service
public class SchedulersServiceImpl extends ServiceImpl<SchedulersMapper, Schedulers> implements SchedulersService {

    /**
     * * Schedulers视图 服务实现类
     *
     * @param pageParams Schedulers视图分页查询page对象
     * @param dto        Schedulers视图分页查询对象
     * @return 查询分页Schedulers视图返回对象
     */
    @Override
    public PageResult<SchedulersVo> getSchedulersList(Page<Schedulers> pageParams, SchedulersDto dto) {
        // 分页查询菜单图标
        IPage<Schedulers> page = baseMapper.selectListByPage(pageParams, dto);

        List<SchedulersVo> voList = page.getRecords().stream().map(schedulers -> {
            SchedulersVo schedulersVo = new SchedulersVo();
            BeanUtils.copyProperties(schedulers, schedulersVo);
            return schedulersVo;
        }).toList();

        return PageResult.<SchedulersVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加Schedulers视图
     *
     * @param dto Schedulers视图添加
     */
    @Override
    public void addSchedulers(@Valid SchedulersAddDto dto) {
        // 保存数据
        Schedulers schedulers = new Schedulers();
        BeanUtils.copyProperties(dto, schedulers);
        save(schedulers);
    }

    /**
     * 更新Schedulers视图
     *
     * @param dto Schedulers视图更新
     */
    @Override
    public void updateSchedulers(@Valid SchedulersUpdateDto dto) {
        // 更新内容
        Schedulers schedulers = new Schedulers();
        BeanUtils.copyProperties(dto, schedulers);
        updateById(schedulers);
    }

    /**
     * 删除|批量删除Schedulers视图
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteSchedulers(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void pauseScheduler(SchedulersOperationDto dto) {
        
    }

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void resumeScheduler(SchedulersOperationDto dto) {

    }

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void removeScheduler(SchedulersOperationDto dto) {

    }
}
