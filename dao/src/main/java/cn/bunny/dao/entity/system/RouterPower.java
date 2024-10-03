package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Setter
@Getter
@Accessors(chain = true)
@TableName("sys_router_power")
@Schema(name = "RouterPower对象", title = "路由和权限关系表", description = "路由和权限关系表")
public class RouterPower extends BaseEntity {

    @Schema(name = "routerId", title = "路由ID")
    private Long routerId;

    @Schema(name = "powerId", title = "角色ID")
    private Long powerId;

}