package cn.bunny.services.mapper.file;

import cn.bunny.domain.model.files.dto.FilesParDetailDto;
import cn.bunny.domain.model.files.entity.FilesParDetail;
import cn.bunny.domain.model.files.vo.FilesParDetailVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 文件分片信息表，仅在手动分片上传时使用 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2025-05-08 23:01:19
 */
@Mapper
public interface FilesParDetailMapper extends BaseMapper<FilesParDetail> {

    /**
     * * 分页查询文件分片信息表，仅在手动分片上传时使用内容
     *
     * @param pageParams 文件分片信息表，仅在手动分片上传时使用分页参数
     * @param dto        文件分片信息表，仅在手动分片上传时使用查询表单
     * @return 文件分片信息表，仅在手动分片上传时使用分页结果
     */
    IPage<FilesParDetailVo> selectListByPage(@Param("page") Page<FilesParDetail> pageParams, @Param("dto") FilesParDetailDto dto);
}
