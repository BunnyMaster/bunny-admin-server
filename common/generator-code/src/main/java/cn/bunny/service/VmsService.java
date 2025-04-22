package cn.bunny.service;

import cn.bunny.dao.dto.VmsArgumentDto;
import cn.bunny.dao.vo.GeneratorVo;
import cn.bunny.dao.vo.VmsPathVo;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface VmsService {
    /**
     * 生成服务端代码
     *
     * @param dto VmsArgumentDto
     * @return 生成内容
     */
    List<GeneratorVo> generator(VmsArgumentDto dto);

    /**
     * 获取vms文件路径
     *
     * @return vms下的文件路径
     */
    Map<String, List<VmsPathVo>> vmsResourcePathList();

    /**
     * 打包成zip下载
     *
     * @param dto VmsArgumentDto
     * @return zip 文件
     */
    ResponseEntity<byte[]> downloadByZip(@Valid VmsArgumentDto dto);


}
