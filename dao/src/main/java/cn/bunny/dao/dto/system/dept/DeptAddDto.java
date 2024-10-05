package cn.bunny.dao.dto.system.dept;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "DeptAddDto对象", title = "部门", description = "部门管理")
public class DeptAddDto {

    @Schema(name = "parentId", title = "父级id")
    private String parentId;

    @Schema(name = "managerId", title = "管理者id")
    @NotBlank(message = "管理者id不能为空")
    private String managerId;

    @Schema(name = "deptName", title = "部门名称")
    @NotBlank(message = "部门名称不能为空")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

}

