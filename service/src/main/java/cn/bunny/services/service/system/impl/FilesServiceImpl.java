package cn.bunny.services.service.system.impl;

import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.files.FilesAddDto;
import cn.bunny.dao.dto.system.files.FilesDto;
import cn.bunny.dao.dto.system.files.FilesUpdateDto;
import cn.bunny.dao.entity.system.Files;
import cn.bunny.dao.model.file.MinioFilePath;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.files.FilesVo;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.FilesMapper;
import cn.bunny.services.service.system.FilesService;
import cn.bunny.services.utils.minio.MinioProperties;
import cn.bunny.services.utils.minio.MinioUtil;
import cn.bunny.services.utils.system.FileUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import lombok.SneakyThrows;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

    @Value("${spring.servlet.multipart.max-file-size}")
    private String maxFileSize;

    @Autowired
    private MinioProperties properties;

    @Autowired
    private MinioUtil minioUtil;

    @Autowired
    private FilesMapper filesMapper;

    /**
     * * 系统文件表 服务实现类
     *
     * @param pageParams 系统文件表分页查询page对象
     * @param dto        系统文件表分页查询对象
     * @return 查询分页系统文件表返回对象
     */
    @Override
    public PageResult<FilesVo> getFilesList(Page<Files> pageParams, FilesDto dto) {
        IPage<FilesVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<FilesVo>builder()
                .list(page.getRecords())
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
    public void addFiles(FilesAddDto dto) {
        List<Files> list = dto.getFiles().stream().map(file -> {
            try {
                MinioFilePath minioFilePath = minioUtil.uploadObjectReturnFilePath(file, dto.getFilepath());

                Files files = new Files();
                files.setFileType(file.getContentType());
                files.setFileSize(file.getSize());
                files.setFilepath("/" + properties.getBucketName() + minioFilePath.getFilepath());
                files.setFilename(minioFilePath.getFilename());
                files.setDownloadCount(dto.getDownloadCount());
                return files;
            } catch (IOException e) {
                throw new AuthCustomerException(e.getMessage());
            }
        }).toList();

        // 保存数据
        saveBatch(list);
    }

    /**
     * 更新系统文件表
     *
     * @param dto 系统文件表更新
     */
    @Override
    public void updateFiles(@Valid FilesUpdateDto dto) {
        Long id = dto.getId();
        MultipartFile file = dto.getFiles();
        Files files = getOne(Wrappers.<Files>lambdaQuery().eq(Files::getId, id));

        if (file != null) {
            // 文件路径
            String filePath = files.getFilepath().replace("/" + properties.getBucketName() + "/", "");
            minioUtil.updateFile(properties.getBucketName(), filePath, file);

            // 设置文件信息
            files.setFileSize(file.getSize());
            files.setFileType(file.getContentType());
        }

        // 更新内容
        files = new Files();
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
        // 上传的文件
        MultipartFile file = dto.getFile();
        // 上传文件类型
        String type = dto.getType();
        // 管理员Id
        Long userId = BaseContext.getUserId();
        // 文件大小
        long fileSize = file.getSize();
        // 文件类型
        String contentType = file.getContentType();
        // 文件名
        String filename = file.getOriginalFilename();

        // 上传文件
        MinioFilePath minioFIlePath = minioUtil.uploadObjectReturnFilePath(file, type);
        String bucketNameFilepath = minioFIlePath.getBucketNameFilepath();

        // 盘读研数据是否过大
        String mb = maxFileSize.replace("MB", "");
        if (fileSize / 1024 / 1024 > Long.parseLong(mb)) throw new AuthCustomerException(ResultCodeEnum.DATA_TOO_LARGE);

        // 插入文件信息
        Files adminFiles = new Files();
        adminFiles.setFileSize(fileSize);
        adminFiles.setFileType(contentType);
        adminFiles.setFilename(filename);
        adminFiles.setFilepath(bucketNameFilepath);
        adminFiles.setCreateUser(userId);
        filesMapper.insert(adminFiles);

        // 返回信息内容化
        return FileInfoVo.builder()
                .size(FileUtil.getSize(fileSize))
                .filepath(bucketNameFilepath)
                .fileSize(fileSize)
                .fileType(contentType)
                .filename(filename)
                .url(minioUtil.getObjectNameFullPath(bucketNameFilepath))
                .build();
    }

    /**
     * 删除|批量删除系统文件表
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteFiles(List<Long> ids) {
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 查询文件路径
        List<String> list = list(Wrappers.<Files>lambdaQuery().in(Files::getId, ids)).stream()
                .map(files -> {
                    String filepath = files.getFilepath();
                    int end = filepath.indexOf("/", 1);
                    return filepath.substring(end + 1);
                }).toList();

        // 删除目标文件
        minioUtil.removeObjects(list);

        // 删除数据库内容
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 下载文件
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
        String filepath = files.getFilepath();
        int end = filepath.indexOf("/", 1);
        filepath = filepath.substring(end + 1);
        byte[] bytes = minioUtil.getBucketObjectByte(filepath);

        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", files.getFilename());

        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }

    /**
     * * 下载文件
     *
     * @param filepath 文件路径
     * @return 文件字节数组
     */
    @Override
    public ResponseEntity<byte[]> downloadFilesByFilepath(String filepath) {
        // 截取文件路径
        int start = filepath.indexOf("/", 1);
        filepath = filepath.substring(start + 1);
        byte[] bytes = minioUtil.getBucketObjectByte(filepath);

        // 设置文件名称
        int end = filepath.lastIndexOf("/");
        String filename = filepath.substring(end + 1);

        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", filename);

        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }

    /**
     * * 获取所有文件类型
     *
     * @return 媒体文件类型列表
     */
    @Override
    public Set<String> getAllMediaTypes() {
        Set<String> valueList = new HashSet<>();
        Class<?> mediaTypeClass = MediaType.class;

        try {
            for (Field declaredField : mediaTypeClass.getDeclaredFields()) {
                // 获取字段属性值
                declaredField.setAccessible(true);
                String value = declaredField.get(null).toString();

                if (value.matches("\\w+/.*")) {
                    valueList.add(value);
                }
            }
            return valueList;
        } catch (Exception exception) {
            return Set.of();
        }
    }
}
