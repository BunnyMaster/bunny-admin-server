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
public class UserLoginLogAddDto {

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

    @Schema(name = "secChUaArch", title = "用户代理的底层平台架构")
    private String secChUaArch;

    @Schema(name = "secChUaBitness", title = "用户代理的底层CPU架构位数")
    private String secChUaBitness;

    @Schema(name = "secChUaMobile", title = "用户代理是否在手机设备上运行")
    private String secChUaMobile;

    @Schema(name = "secChUaModel", title = "用户代理的设备模型")
    private String secChUaModel;

    @Schema(name = "secChUaPlatform", title = "用户代理的底层操作系统/平台")
    private String secChUaPlatform;

    @Schema(name = "secChUaPlatformVersion", title = "用户代理的底层操作系统版本")
    private String secChUaPlatformVersion;

    @Schema(name = "contentDpr", title = "客户端设备像素比")
    private String contentDpr;

    @Schema(name = "deviceMemory", title = "客户端RAM内存的近似值")
    private String deviceMemory;

    @Schema(name = "dpr", title = "客户端设备像素比")
    private String dpr;

    @Schema(name = "viewportWidth", title = "布局视口宽度")
    private String viewportWidth;

    @Schema(name = "width", title = "所需资源宽度")
    private String width;

    @Schema(name = "downlink", title = "客户端连接到服务器的近似带宽")
    private String downlink;

    @Schema(name = "ect", title = "有效连接类型")
    private String ect;

    @Schema(name = "rtt", title = "应用层往返时间")
    private String rtt;

}

