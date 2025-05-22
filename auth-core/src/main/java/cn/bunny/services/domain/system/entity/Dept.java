package cn.bunny.services.domain.system.entity;

import cn.bunny.services.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 部门表
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_dept")
@Schema(name = "Dept对象", title = "部门", description = "部门管理")
public class Dept extends BaseEntity {

    @Schema(name = "parentId", title = "父级id")
    private String parentId;

    @Schema(name = "manager", title = "管理者")
    private String manager;

    @Schema(name = "deptName", title = "部门名称")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}

