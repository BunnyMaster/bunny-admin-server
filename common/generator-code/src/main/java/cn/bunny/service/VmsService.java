package cn.bunny.service;

import cn.bunny.dao.dto.VmsArgumentDto;
import cn.bunny.dao.vo.GeneratorVo;

import java.util.List;

public interface VmsService {
    /**
     * 生成服务端代码
     *
     * @param dto VmsArgumentDto
     * @return 生成内容
     */
    List<GeneratorVo> generator(VmsArgumentDto dto);
}
