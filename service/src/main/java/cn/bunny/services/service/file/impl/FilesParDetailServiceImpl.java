package cn.bunny.services.service.file.impl;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.files.dto.FilesParDetailDto;
import cn.bunny.services.domain.files.entity.FilesParDetail;
import cn.bunny.services.domain.files.vo.FilesParDetailVo;
import cn.bunny.services.mapper.file.FilesParDetailMapper;
import cn.bunny.services.service.file.FilesParDetailService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 文件分片信息表，仅在手动分片上传时使用 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2025-05-08 23:01:19
 */
@Service
@Transactional
public class FilesParDetailServiceImpl extends ServiceImpl<FilesParDetailMapper, FilesParDetail> implements FilesParDetailService {

    /**
     * * 文件分片信息表，仅在手动分片上传时使用 服务实现类
     *
     * @param pageParams 文件分片信息表，仅在手动分片上传时使用分页查询page对象
     * @param dto        文件分片信息表，仅在手动分片上传时使用分页查询对象
     * @return 查询分页文件分片信息表，仅在手动分片上传时使用返回对象
     */
    @Override
    public PageResult<FilesParDetailVo> getFilesParDetailPage(Page<FilesParDetail> pageParams, FilesParDetailDto dto) {
        IPage<FilesParDetailVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<FilesParDetailVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加文件分片信息表，仅在手动分片上传时使用
     *
     * @param dto 文件分片信息表，仅在手动分片上传时使用添加
     */
    @Override
    public void createFilesParDetail(@Valid FilesParDetailDto dto) {
        FilesParDetail filesPardetail = new FilesParDetail();
        BeanUtils.copyProperties(dto, filesPardetail);
        save(filesPardetail);
    }

    /**
     * 更新文件分片信息表，仅在手动分片上传时使用
     *
     * @param dto 文件分片信息表，仅在手动分片上传时使用更新
     */
    @Override
    public void updateFilesParDetail(@Valid FilesParDetailDto dto) {
        FilesParDetail filesPardetail = new FilesParDetail();
        BeanUtils.copyProperties(dto, filesPardetail);
        updateById(filesPardetail);
    }

    /**
     * 删除|批量删除文件分片信息表，仅在手动分片上传时使用
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteFilesParDetail(List<Long> ids) {
        removeByIds(ids);
    }

}