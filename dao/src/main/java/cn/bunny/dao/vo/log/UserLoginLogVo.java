package cn.bunny.dao.vo.log;

import cn.bunny.dao.vo.common.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "UserLoginLogVo对象", title = "用户登录日志", description = "用户登录日志")
public class UserLoginLogVo extends BaseVo {

    @Schema(name = "userId", title = "用户Id")
    private Long userId;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "token", title = "登录token")
    private String token;

    @Schema(name = "ipAddress", title = "登录Ip地点")
    private String ipAddress;

    @Schema(name = "ipRegion", title = "登录Ip")
    private String ipRegion;

    @Schema(name = "userAgent", title = "登录时代理")
    private String userAgent;

    @Schema(name = "type", title = "操作类型")
    private String type;

}