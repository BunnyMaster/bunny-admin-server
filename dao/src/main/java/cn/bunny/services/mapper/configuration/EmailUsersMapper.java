package cn.bunny.services.mapper.configuration;

import cn.bunny.services.domain.email.dto.EmailUsersDto;
import cn.bunny.services.domain.email.entity.EmailUsers;
import cn.bunny.services.domain.email.vo.EmailUsersVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 邮箱用户发送配置 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 15:19:22
 */
@Mapper
public interface EmailUsersMapper extends BaseMapper<EmailUsers> {

    /**
     * * 分页查询邮箱用户发送配置内容
     *
     * @param pageParams 邮箱用户发送配置分页参数
     * @param dto        邮箱用户发送配置查询表单
     * @return 邮箱用户发送配置分页结果
     */
    IPage<EmailUsersVo> selectListByPage(@Param("page") Page<EmailUsers> pageParams, @Param("dto") EmailUsersDto dto);

}
