package cn.bunny.services.domain.system.entity;

import cn.bunny.services.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
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

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}

