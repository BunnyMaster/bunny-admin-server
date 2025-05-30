package cn.bunny.services.mapper.system;

import cn.bunny.domain.system.dto.user.AdminUserDto;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.domain.system.views.ViewUserDept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 用户信息 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface UserMapper extends BaseMapper<AdminUser> {

    /**
     * * 分页查询用户信息内容
     *
     * @param pageParams 用户信息分页参数
     * @param dto        用户信息查询表单
     * @return 用户信息分页结果
     */
    IPage<ViewUserDept> selectListByPage(@Param("page") Page<AdminUser> pageParams, @Param("dto") AdminUserDto dto);

    /**
     * * 查询用户
     *
     * @param keyword 查询关键字
     * @return 用户信息列表
     */
    List<AdminUser> queryUser(String keyword);
}
