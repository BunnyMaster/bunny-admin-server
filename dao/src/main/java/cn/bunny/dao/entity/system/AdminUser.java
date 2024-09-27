package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
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
@Schema(name = "AdminUser对象", title = "用户信息", description = "用户信息")
public class AdminUser extends BaseEntity {
    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickName", title = "昵称")
    private String nickName;

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

    @Schema(name = "lastLoginIp", title = "最后登录IP")
    private String lastLoginIp;

    @Schema(name = "lastLoginIpAddress", title = "最后登录ip归属地")
    private String lastLoginIpAddress;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Byte status;
}
