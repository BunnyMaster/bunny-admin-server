package cn.bunny.dao.entity.log;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户登录日志
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("log_user_login")
@ApiModel(value = "UserLogin对象", description = "用户登录日志")
public class UserLoginLog extends BaseEntity {

    @ApiModelProperty("用户Id")
    private Long userId;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("登录token")
    private String token;

    @ApiModelProperty("登录Ip")
    private String ip;

    @ApiModelProperty("登录Ip地点")
    private String ipAddress;

    @ApiModelProperty("登录时代理")
    private String userAgent;

}
