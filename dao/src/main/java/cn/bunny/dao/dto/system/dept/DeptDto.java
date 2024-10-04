package cn.bunny.dao.dto.system.dept;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "DeptDto对象", title = "部门", description = "部门管理")
public class DeptDto {

    @Schema(name = "parentId", title = "父级id")
    private String parentId;

    @Schema(name = "managerId", title = "管理者id")
    private String managerId;

    @Schema(name = "deptName", title = "部门名称")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

    @Schema(name = "remarks", title = "备注信息")
    private String remarks;

}

