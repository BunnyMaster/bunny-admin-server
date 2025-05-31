package cn.bunny.services.mapper.configuration;

import cn.bunny.domain.model.configuration.dto.EmailTemplateDto;
import cn.bunny.domain.model.configuration.entity.EmailTemplate;
import cn.bunny.domain.model.configuration.vo.EmailTemplateVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 邮件模板表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
@Mapper
public interface EmailTemplateMapper extends BaseMapper<EmailTemplate> {

    /**
     * * 分页查询邮件模板表内容
     *
     * @param pageParams 邮件模板表分页参数
     * @param dto        邮件模板表查询表单
     * @return 邮件模板表分页结果
     */
    IPage<EmailTemplateVo> selectListByPage(@Param("page") Page<EmailTemplate> pageParams, @Param("dto") EmailTemplateDto dto);
}
