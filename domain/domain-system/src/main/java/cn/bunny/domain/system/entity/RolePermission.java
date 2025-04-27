package cn.bunny.domain.system.entity;

import cn.bunny.domain.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Setter
@Getter
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_role_permission")
@Schema(name = "RolePower对象", title = "角色权限关系", description = "角色权限关系")
public class RolePermission extends BaseEntity {

    @Schema(name = "roleId", title = "角色id")
    private Long roleId;

    @Schema(name = "powerId", title = "权限id")
    private Long powerId;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}