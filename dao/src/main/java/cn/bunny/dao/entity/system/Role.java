package cn.bunny.dao.entity.system;

import cn.bunny.dao.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_role")
@Schema(name = "Role对象", title = "角色", description = "角色")
public class Role extends BaseEntity {

    @Schema(name = "roleCode", title = "角色代码")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    private String description;

}

