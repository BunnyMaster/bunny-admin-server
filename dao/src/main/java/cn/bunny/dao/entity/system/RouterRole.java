package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_router_role")
@Schema(name = "RouterRole对象", title = "路由角色关系", description = "路由角色关系")
public class RouterRole extends BaseEntity {
    @Schema(name = "routerId", title = "路由ID")
    private Long routerId;

    @Schema(name = "roleId", title = "角色ID")
    private Long roleId;
}