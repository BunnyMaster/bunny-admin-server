package cn.bunny.dao.entity.log;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户登录日志
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("log_user_login")
@Schema(name = "UserLogin对象", title = "用户登录日志", description = "用户登录日志")
public class UserLoginLog extends BaseEntity {

    @Schema(name = "userId", title = "用户Id")
    private Long userId;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "token", title = "登录token")
    private String token;

    @Schema(name = "ipAddress", title = "登录Ip")
    private String ipAddress;

    @Schema(name = "ipRegion", title = "登录Ip归属地")
    private String ipRegion;

    @Schema(name = "userAgent", title = "登录时代理")
    private String userAgent;

    @Schema(name = "type", title = "操作类型")
    private String type;

    @Schema(name = "xRequestedWith", title = "标识客户端是否是通过Ajax发送请求的")
    private String xRequestedWith;

    @Schema(name = "secChUa", title = "用户代理的品牌和版本")
    private String secChUa;

    @Schema(name = "secChUaMobile", title = "用户代理是否在手机设备上运行")
    private String secChUaMobile;

    @Schema(name = "secChUaPlatform", title = "用户代理的底层操作系统/平台")
    private String secChUaPlatform;

}