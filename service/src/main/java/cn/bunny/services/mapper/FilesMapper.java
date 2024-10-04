package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.Files;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 系统文件表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Mapper
public interface FilesMapper extends BaseMapper<Files> {

}
