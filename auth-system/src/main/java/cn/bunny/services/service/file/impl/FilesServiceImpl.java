package cn.bunny.services.service.file.impl;

import cn.bunny.domain.common.constant.FileStorageConstant;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.files.dto.FileUploadDto;
import cn.bunny.domain.files.dto.FilesCreateOrUpdateDto;
import cn.bunny.domain.files.dto.FilesDto;
import cn.bunny.domain.files.dto.UploadThumbnail;
import cn.bunny.domain.files.entity.Files;
import cn.bunny.domain.files.vo.FileInfoVo;
import cn.bunny.domain.files.vo.FilesVo;
import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.services.mapper.file.FilesMapper;
import cn.bunny.services.service.file.FilesService;
import cn.bunny.core.utils.FileUtil;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.FileStorageService;
import org.dromara.x.file.storage.core.get.ListFilesSupportInfo;
import org.dromara.x.file.storage.core.get.RemoteDirInfo;
import org.dromara.x.file.storage.core.upload.UploadPretreatment;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 系统文件表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-09 16:28:01
 */
@Service
@Transactional
public class FilesServiceImpl extends ServiceImpl<FilesMapper, Files> implements FilesService {

    @Resource
    private FileStorageService fileStorageService;

    /**
     * 系统文件表 服务实现类
     *
     * @param pageParams 系统文件表分页查询page对象
     * @param dto        系统文件表分页查询对象
     * @return 查询分页系统文件表返回对象
     */
    @Override
    public PageResult<FilesVo> getFilesPage(Page<Files> pageParams, FilesDto dto) {
        IPage<FilesVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<FilesVo>builder()
                .list(page.getRecords()).pageNo(page.getCurrent())
                .pageSize(page.getSize()).total(page.getTotal())
                .build();
    }

    /**
     * 添加系统文件表
     *
     * @param dto 系统文件表添加
     */
    @Override
    public void createFiles(FilesCreateOrUpdateDto dto) {
        // 上传文件类型，设置自定义路径
        String preType = dto.getFilepath();
        String filepath = FileStorageConstant.getType(preType) + DateUtil.format(new Date(), "yyyy-MM-dd") + "/";

        dto.getFiles().forEach(file -> fileStorageService.of(file).setPath(filepath).upload());
    }

    /**
     * 更新系统文件表
     * 因为更新文件必须要保证原来的文件名是一样的，所以在更新时候要设置文件名
     *
     * @param dto 系统文件表更新
     */
    @Override
    public void updateFiles(FilesCreateOrUpdateDto dto) {
        MultipartFile file = dto.getFile();
        // 先查询文件
        Long id = dto.getId();

        // 查询原文件信息
        Files files = getOne(Wrappers.<Files>lambdaQuery().eq(Files::getId, id));

        // 看文件是否存在，
        if (Objects.isNull(files)) {
            throw new AuthCustomerException(ResultCodeEnum.FILE_NOT_EXIST);
        }

        // 更新数据
        dto.setFilepath(files.getFilepath());
        BeanUtils.copyProperties(dto, files);
        updateById(files);

        // 文件存在上傳文件并更新
        if (file == null) return;

        // 删除原来文件
        boolean delete = fileStorageService.delete(files.getUrl());
        if (!delete) {
            throw new AuthCustomerException(ResultCodeEnum.UPDATE_ERROR);
        }

        // 上传文件，修改源文件
        fileStorageService.of(file)
                // 设置旧文件的路径
                .setPath(files.getFilepath())
                // 设置旧文件的名称
                .setSaveFilename(files.getFilename())
                // 如果有缩略图的话
                .setSaveThFilename(files.getThFilename())
                .upload();

    }

    /**
     * 上传文件
     *
     * @param dto 文件上传
     * @return 管理端返回文件信息
     */
    @Override
    public FileInfoVo upload(FileUploadDto dto) {
        MultipartFile file = dto.getFile();

        // 设置自定义路径
        String preType = dto.getType();
        String filepath = FileStorageConstant.getType(preType) + DateUtil.format(new Date(), "yyyy-MM-dd") + "/";

        FileInfo fileInfo = fileStorageService.of(file).setPath(filepath).upload();

        // 返回信息内容化
        FileInfoVo fileInfoVo = new FileInfoVo();
        BeanUtils.copyProperties(fileInfo, fileInfoVo);

        // 设置保存文件大小
        Long fileSize = fileInfo.getSize();
        String fileSizeStr = FileUtil.getSize(fileSize);
        fileInfoVo.setFileSizeStr(fileSizeStr);
        return fileInfoVo;
    }

    /**
     * 删除|批量删除系统文件表
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteFiles(List<Long> ids) {
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 查询文件，并删除
        LambdaQueryWrapper<Files> wrapper = Wrappers.<Files>lambdaQuery().in(Files::getId, ids);
        list(wrapper).forEach(files -> fileStorageService.delete(files.getUrl()));
    }

    /**
     * 下载文件
     * 下载原文件 不是缩略图
     * <a href="https://x-file-storage.xuyanwu.cn/#/%E5%9F%BA%E7%A1%80%E5%8A%9F%E8%83%BD?id=%e4%b8%8b%e8%bd%bd">
     * 下载文件参考文档
     * </a>
     *
     * @param fileId 文件id
     * @return 文件字节数组
     */
    @Override
    public ResponseEntity<byte[]> downloadFilesByFileId(Long fileId) {
        // 查询数据库文件信息
        Files files = getOne(Wrappers.<Files>lambdaQuery().eq(Files::getId, fileId));

        // 判断文件是否存在
        if (files == null) throw new AuthCustomerException(ResultCodeEnum.FILE_NOT_EXIST);

        // 从Minio获取文件
        FileInfo fileInfo = new FileInfo();
        BeanUtils.copyProperties(files, fileInfo);

        String file = files.getFilepath() + files.getFilename();
        fileInfo.setFilename(file);
        byte[] bytes = fileStorageService.download(fileInfo).bytes();

        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", files.getFilename());

        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }

    /**
     * 上传文件縮略圖
     * 详细参考：
     * <a href="https://x-file-storage.xuyanwu.cn/#/%E5%9F%BA%E7%A1%80%E5%8A%9F%E8%83%BD?id=%e4%b8%8a%e4%bc%a0">
     * 上传文件文档
     * </a>
     *
     * @param dto 上传文件 {@link UploadThumbnail}
     */
    @Override
    public FileInfoVo uploadFileByThumbnail(FileUploadDto dto) {
        MultipartFile file = dto.getFile();
        String preType = dto.getType();
        String type = FileStorageConstant.getType(preType);
        if (file == null) return null;

        // 上传文件构造参数
        String filepath = type + DateUtil.format(new Date(), "yyyy-MM-dd") + "/";
        UploadPretreatment uploadPretreatment = fileStorageService.of(file)
                // 指定缩略图后缀，必须是 thumbnailator 支持的图片格式，默认使用全局的
                // .setThumbnailSuffix(".jpg")
                .setPath(filepath)
                .thumbnail(200, 200);

        FileInfo fileInfo = uploadPretreatment.upload();
        // 返回信息内容化
        FileInfoVo fileInfoVo = new FileInfoVo();
        BeanUtils.copyProperties(fileInfo, fileInfoVo);

        // 设置保存文件大小
        Long fileSize = fileInfo.getSize();
        String fileSizeStr = FileUtil.getSize(fileSize);
        fileInfoVo.setFileSizeStr(fileSizeStr);
        return fileInfoVo;
    }

    /**
     * 列举当前文件路径所有的文件
     *
     * @param path 路径
     * @return 文件列表
     */
    @Override
    public List<RemoteDirInfo> listFiles(String path) {
        // 是否支持列举文件
        ListFilesSupportInfo isSupportListFiles = fileStorageService.isSupportListFiles();

        // 是否支持列举文件
        Boolean isSupport = isSupportListFiles.getIsSupport();
        if (!isSupport) {
            return new ArrayList<>();
        }

        return fileStorageService.listFiles().setPath(path).listFiles().getDirList();
    }
}
