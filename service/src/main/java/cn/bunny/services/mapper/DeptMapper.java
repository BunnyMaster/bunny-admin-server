package cn.bunny.services.mapper;

import cn.bunny.dao.dto.system.dept.DeptDto;
import cn.bunny.dao.entity.system.Dept;
import cn.bunny.dao.vo.system.DeptVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 部门 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04 10:39:08
 */
@Mapper
public interface DeptMapper extends BaseMapper<Dept> {

    /**
     * * 分页查询部门内容
     *
     * @param pageParams 部门分页参数
     * @param dto        部门查询表单
     * @return 部门分页结果
     */
    IPage<DeptVo> selectListByPage(@Param("page") Page<Dept> pageParams, @Param("dto") DeptDto dto);

    /**
     * 物理删除部门
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
