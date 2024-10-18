package cn.bunny.dao.dto.log;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "UserLoginLogDto对象", title = "用户登录日志分页查询", description = "用户登录日志分页查询")
public class UserLoginLogUpdateDto {

    @Schema(name = "userId", title = "用户Id")
    private Long userId;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "token", title = "登录token")
    private String token;

    @Schema(name = "ip", title = "登录Ip")
    private String ip;

    @Schema(name = "ipAddress", title = "登录Ip地点")
    private String ipAddress;

    @Schema(name = "userAgent", title = "登录时代理")
    private String userAgent;

}