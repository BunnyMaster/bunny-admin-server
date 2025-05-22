package cn.bunny.services.service.file.impl;

import cn.bunny.services.domain.files.entity.Files;
import cn.bunny.services.domain.files.entity.FilesParDetail;
import cn.bunny.services.mapper.file.FilesMapper;
import cn.bunny.services.mapper.file.FilesParDetailMapper;
import cn.bunny.services.utils.FileUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import lombok.SneakyThrows;
import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.recorder.FileRecorder;
import org.dromara.x.file.storage.core.upload.FilePartInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 文件详情服务类，实现文件记录器接口(FileRecorder)
 * 提供文件的上传、更新、查询、删除以及分片操作等功能
 * 主要与数据库中的文件表和文件分片表进行交互
 * <a href="https://x-file-storage.xuyanwu.cn/#/">
 * 官网文档
 * </a>
 */
@Service
public class FileDetailService extends ServiceImpl<FilesMapper, Files> implements FileRecorder {

    @Resource
    private FilesParDetailMapper filesParDetailMapper;

    /**
     * 上传时保存文件，并存入到数据库
     * <a href="https://x-file-storage.xuyanwu.cn/#/%E5%9F%BA%E7%A1%80%E5%8A%9F%E8%83%BD?id=%e4%b8%8a%e4%bc%a0">
     * 上传文件文档
     * </a>
     * 如果是下载、删除、复制、移动等方法，手动构造 FileInfo 对象即可（需要实现 {@link FileRecorder})
     * 如果不需要上面的功能可以不要实现
     * 如果不需要（下载、删除、复制、移动等方法）但是需要存储到数据库的，上传时需要手动保存记录
     * 在这个方法中的 fileInfo 是上传时候拿到的
     * <p>
     *
     * @param fileInfo 文件信息
     */
    @SneakyThrows
    @Override
    public boolean save(FileInfo fileInfo) {
        Files files = new Files();
        BeanUtils.copyProperties(fileInfo, files);

        // 保存文件filepath，对应是fileInfo的 path
        String path = fileInfo.getPath();
        files.setFilepath(path);

        // 设置保存文件大小
        Long fileSize = fileInfo.getSize();
        String fileSizeStr = FileUtil.getSize(fileSize);
        files.setFileSizeStr(fileSizeStr);

        save(files);
        return true;
    }

    /**
     * 应该是没有用到这个方法的
     *
     * @param fileInfo 信息
     */
    @Override
    public void update(FileInfo fileInfo) {
        // 查询原来的文件信息
        LambdaUpdateWrapper<Files> updateWrapper = new LambdaUpdateWrapper<Files>().eq(fileInfo.getUrl() != null, Files::getUrl, fileInfo.getUrl())
                .eq(fileInfo.getId() != null, Files::getId, fileInfo.getId());
        Files files = getOne(updateWrapper);
        BeanUtils.copyProperties(fileInfo, files);

        // 保存文件filepath，对应是fileInfo的 path
        String path = fileInfo.getPath();
        files.setFilepath(path);

        // 设置保存文件大小
        Long fileSize = fileInfo.getSize();
        String fileSizeStr = FileUtil.getSize(fileSize);
        files.setFileSizeStr(fileSizeStr);

        updateById(files);
    }

    /**
     * 接口需要实现
     *
     * @param url 地址
     * @return 信息
     */
    @Override
    public FileInfo getByUrl(String url) {
        LambdaQueryWrapper<Files> queryWrapper = Wrappers.<Files>lambdaQuery().eq(Files::getUrl, url);
        Files files = getOne(queryWrapper);

        FileInfo fileInfo = new FileInfo();
        BeanUtils.copyProperties(files, fileInfo);
        return fileInfo;
    }

    /**
     * 删除时的操作
     *
     * @param url 地址
     * @return 是否删除成功
     */
    @Override
    public boolean delete(String url) {
        LambdaQueryWrapper<Files> queryWrapper = Wrappers.<Files>lambdaQuery().eq(Files::getUrl, url);
        return remove(queryWrapper);
    }

    /**
     * 保存分片
     *
     * @param filePartInfo 分片信息
     */
    @Override
    public void saveFilePart(FilePartInfo filePartInfo) {
        FilesParDetail filesParDetail = new FilesParDetail();
        BeanUtils.copyProperties(filePartInfo, filesParDetail);

        filesParDetailMapper.insert(filesParDetail);
    }

    /**
     * 更具上传id删除
     *
     * @param url url地址
     */
    @Override
    public void deleteFilePartByUploadId(String url) {
        LambdaQueryWrapper<FilesParDetail> queryWrapper = Wrappers.<FilesParDetail>lambdaQuery().eq(FilesParDetail::getUploadId, url);
        filesParDetailMapper.delete(queryWrapper);
    }
}