package cn.bunny.services.mapper.configuration;

import cn.bunny.dao.dto.system.email.template.EmailTemplateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    /**
     * 物理删除邮件模板表
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
