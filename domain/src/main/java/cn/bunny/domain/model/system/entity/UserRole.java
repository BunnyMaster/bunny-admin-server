package cn.bunny.domain.model.system.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_user_role")
@Schema(name = "UserRole对象", title = "用户角色关系", description = "用户角色关系")
public class UserRole extends BaseEntity {

    @Schema(name = "userId", title = "用户id")
    private Long userId;

    @Schema(name = "roleId", title = "角色id")
    private Long roleId;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}