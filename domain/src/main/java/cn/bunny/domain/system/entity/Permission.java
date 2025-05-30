package cn.bunny.domain.system.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_permission")
@Schema(name = "Power对象", title = "权限", description = "权限")
public class Permission extends BaseEntity {

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

    @Schema(name = "requestMethod", title = "请求方法")
    private String requestMethod;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}

