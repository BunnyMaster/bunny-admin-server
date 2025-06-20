package cn.bunny.domain.system.dto.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "UserLoginLogDto对象" , title = "用户登录日志分页查询" , description = "用户登录日志分页查询" )
public class UserLoginLogDto {

    @Schema(name = "userId" , title = "用户Id" )
    private Long userId;

    @Schema(name = "username" , title = "用户名" )
    private String username;

    @Schema(name = "token" , title = "登录token" )
    private String token;

    @Schema(name = "ipAddress" , title = "登录Ip" )
    private String ipAddress;

    @Schema(name = "ipRegion" , title = "登录Ip归属地" )
    private String ipRegion;

    @Schema(name = "userAgent" , title = "登录时代理" )
    private String userAgent;

    @Schema(name = "type" , title = "操作类型" )
    private String type;

    @Schema(name = "xRequestedWith" , title = "标识客户端是否是通过Ajax发送请求的" )
    private String xRequestedWith;

}

