package cn.bunny.services.domain.system.system.vo.user;

import cn.bunny.services.domain.common.vo.BaseUserVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AdminUserVo对象", title = "用户信息", description = "用户信息")
public class AdminUserVo extends BaseUserVo {

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickname", title = "昵称")
    private String nickname;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

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

    @Schema(name = "deptId", title = "部门")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long deptId;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;
}