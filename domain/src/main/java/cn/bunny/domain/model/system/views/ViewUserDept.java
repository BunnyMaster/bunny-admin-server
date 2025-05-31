package cn.bunny.domain.model.system.views;

import cn.bunny.domain.common.model.entity.BaseUserEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 管理员用户信息
 * </p>
 *
 * @author Bunny
 * @since 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@TableName("sys_user")
@Schema(name = "AdminUserAndDept对象", title = "用户信息和部门Id", description = "用户信息和部门Id")
public class ViewUserDept extends BaseUserEntity {

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickname", title = "昵称")
    private String nickname;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "password", title = "密码")
    private String password;
 
    @Schema(name = "avatar", title = "头像")
    private String avatar;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "ipAddress", title = "登录Ip")
    private String ipAddress;

    @Schema(name = "ipRegion", title = "登录Ip归属地")
    private String ipRegion;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;

    @Schema(name = "deptId", title = "部门")
    private Long deptId;
}