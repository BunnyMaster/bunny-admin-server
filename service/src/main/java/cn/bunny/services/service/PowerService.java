package cn.bunny.services.service;

import cn.bunny.dao.dto.system.rolePower.PowerAddDto;
import cn.bunny.dao.dto.system.rolePower.PowerDto;
import cn.bunny.dao.dto.system.rolePower.PowerUpdateDto;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.rolePower.PowerVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 权限 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
public interface PowerService extends IService<Power> {

    /**
     * * 获取权限列表
     *
     * @return 权限返回列表
     */
    PageResult<PowerVo> getPowerList(Page<Power> pageParams, PowerDto dto);

    /**
     * * 添加权限
     *
     * @param dto 添加表单
     */
    void addPower(@Valid PowerAddDto dto);

    /**
     * * 更新权限
     *
     * @param dto 更新表单
     */
    void updatePower(@Valid PowerUpdateDto dto);

    /**
     * * 删除|批量删除权限类型
     *
     * @param ids 删除id列表
     */
    void deletePower(List<Long> ids);

    /**
     * * 获取所有权限
     *
     * @return 所有权限列表
     */
    List<PowerVo> getAllPowers();

}
