package cn.bunny.services.service.system;

import cn.bunny.dao.dto.system.rolePower.power.PowerAddDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerUpdateBatchByParentIdDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerUpdateDto;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.vo.result.PageResult;
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

    /**
     * * 批量修改权限父级
     *
     * @param dto 批量修改权限表单
     */
    void updateBatchByPowerWithParentId(PowerUpdateBatchByParentIdDto dto);
}
