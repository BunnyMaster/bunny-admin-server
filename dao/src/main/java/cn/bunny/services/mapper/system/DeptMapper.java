package cn.bunny.services.mapper.system;

import cn.bunny.services.domain.system.dto.dept.DeptDto;
import cn.bunny.services.domain.system.entity.Dept;
import cn.bunny.services.domain.system.vo.DeptVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
     * 分页查询部门内容
     *
     * @param pageParams 部门分页参数
     * @param dto        部门查询表单
     * @return 部门分页结果
     */
    IPage<DeptVo> selectListByPage(@Param("page") Page<Dept> pageParams, @Param("dto") DeptDto dto);

}
