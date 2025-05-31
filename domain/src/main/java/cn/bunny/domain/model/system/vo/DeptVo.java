package cn.bunny.domain.model.system.vo;

import cn.bunny.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "DeptVo对象", title = "部门", description = "部门管理")
public class DeptVo extends BaseUserVo {

    @Schema(name = "parentId", title = "父级id")
    private String parentId;

    @Schema(name = "manager", title = "管理者")
    private String manager;

    @Schema(name = "deptName", title = "部门名称")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

}