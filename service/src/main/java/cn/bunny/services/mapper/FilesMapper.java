package cn.bunny.services.mapper;

import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.entity.system.Files;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统文件表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Mapper
public interface FilesMapper extends BaseMapper<Files> {

    /**
     * * 分页查询系统文件表内容
     *
     * @param pageParams 系统文件表分页参数
     * @param dto        系统文件表查询表单
     * @return 系统文件表分页结果
     */
    IPage<Files> selectListByPage(@Param("page") Page<Files> pageParams, @Param("dto") FilesDto dto);

    /**
     * 物理删除系统文件表
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
