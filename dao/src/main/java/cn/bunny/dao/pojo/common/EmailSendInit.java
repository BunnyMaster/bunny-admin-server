package cn.bunny.dao.pojo.common;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 邮箱发送初始化参数
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "EmailSendInit", title = "邮件发送初始化", description = "邮件发送初始化")
public class EmailSendInit {

    @Schema(name = "port", title = "端口")
    private Integer port;

    @Schema(name = "host", title = "主机")
    private String host;

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "password", title = "密码")
    private String password;
}