package cn.bunny.services.service.file;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.files.dto.FilesParDetailDto;
import cn.bunny.services.domain.system.files.entity.FilesParDetail;
import cn.bunny.services.domain.system.files.vo.FilesParDetailVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 文件分片信息表，仅在手动分片上传时使用 服务类
 * </p>
 *
 * @author Bunny
 * @since 2025-05-08 23:01:19
 */
public interface FilesParDetailService extends IService<FilesParDetail> {

    /**
     * 分页查询文件分片信息表，仅在手动分片上传时使用
     *
     * @return {@link FilesParDetailVo}
     */
    PageResult<FilesParDetailVo> getFilesParDetailPage(Page<FilesParDetail> pageParams, FilesParDetailDto dto);

    /**
     * 添加文件分片信息表，仅在手动分片上传时使用
     *
     * @param dto 添加表单
     */
    void addFilesParDetail(FilesParDetailDto dto);

    /**
     * 更新文件分片信息表，仅在手动分片上传时使用
     *
     * @param dto {@link FilesParDetailDto}
     */
    void updateFilesParDetail(FilesParDetailDto dto);

    /**
     * 删除|批量删除文件分片信息表，仅在手动分片上传时使用类型
     *
     * @param ids 删除id列表
     */
    void deleteFilesParDetail(List<Long> ids);
}
