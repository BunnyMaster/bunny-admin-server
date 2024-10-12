package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.files.FilesAddDto;
import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.dto.system.files.FilesUpdateDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.files.FilesVo;
import cn.bunny.services.factory.FileFactory;
import cn.bunny.services.mapper.FilesMapper;
import cn.bunny.services.service.FilesService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.SneakyThrows;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * <p>
 * 系统文件表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Service
public class FilesServiceImpl extends ServiceImpl<FilesMapper, Files> implements FilesService {

    private final FileFactory fileFactory;
    private final MinioUtil minioUtil;

    public FilesServiceImpl(FileFactory fileFactory, MinioUtil minioUtil) {
        this.fileFactory = fileFactory;
        this.minioUtil = minioUtil;
    }

    /**
     * * 系统文件表 服务实现类
     *
     * @param pageParams 系统文件表分页查询page对象
     * @param dto        系统文件表分页查询对象
     * @return 查询分页系统文件表返回对象
     */
    @Override
    public PageResult<FilesVo> getFilesList(Page<Files> pageParams, FilesDto dto) {
        // 分页查询菜单图标
        IPage<Files> page = baseMapper.selectListByPage(pageParams, dto);

        List<FilesVo> voList = page.getRecords().stream().map(files -> {
            FilesVo filesVo = new FilesVo();
            BeanUtils.copyProperties(files, filesVo);
            return filesVo;
        }).toList();

        return PageResult.<FilesVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加系统文件表
     *
     * @param dto 系统文件表添加
     */
    @Override
    public void addFiles(@Valid FilesAddDto dto) {
        // 保存数据
        Files files = new Files();
        BeanUtils.copyProperties(dto, files);
        save(files);
    }

    /**
     * 更新系统文件表
     *
     * @param dto 系统文件表更新
     */
    @Override
    public void updateFiles(@Valid FilesUpdateDto dto) {
        // 更新内容
        Files files = new Files();
        BeanUtils.copyProperties(dto, files);
        updateById(files);
    }

    /**
     * * 上传文件
     *
     * @param dto 文件上传
     * @return 管理端返回文件信息
     */
    @SneakyThrows
    @Override
    public FileInfoVo upload(FileUploadDto dto) {
        MultipartFile file = dto.getFile();
        String type = dto.getType();

        return fileFactory.uploadFile(file, type);
    }

    /**
     * 删除|批量删除系统文件表
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteFiles(List<Long> ids) {
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 下载文件
     *
     * @param response response
     * @param fileId   文件名
     */
    @Override
    public void downloadFiles(HttpServletResponse response, Long fileId) {
        // 查询数据库文件信息
        Files files = getOne(Wrappers.<Files>lambdaQuery().eq(Files::getId, fileId));

        // 判断文件是否存在
        if (files == null) throw new BunnyException(ResultCodeEnum.FILE_NOT_EXIST);

        // 从Minio获取文件
        String filepath = files.getFilepath();
        int end = filepath.indexOf("/", 1);
        filepath = filepath.substring(end + 1);
        byte[] buffer = minioUtil.getBucketObjectByte(filepath);

        // 设置响应头
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + files.getFilename() + "\"");

        // 写入字节数组到输出流
        try (OutputStream os = response.getOutputStream()) {
            os.write(buffer);
            os.flush();
        } catch (IOException exception) {
            throw new BunnyException(exception.getMessage());
        }
    }
}
