package cn.bunny.system.mapper;

import cn.bunny.domain.system.dto.FilesDto;
import cn.bunny.domain.system.entity.Files;
import cn.bunny.domain.system.vo.FilesVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    IPage<FilesVo> selectListByPage(@Param("page" ) Page<Files> pageParams, @Param("dto" ) FilesDto dto);

}
