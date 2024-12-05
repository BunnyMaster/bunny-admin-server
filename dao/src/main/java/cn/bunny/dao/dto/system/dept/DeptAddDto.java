package cn.bunny.dao.dto.system.dept;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "DeptAddDto对象", title = "添加部门", description = "添加部门")
public class DeptAddDto {

    @Schema(name = "parentId", title = "父级id")
    private String parentId;

    @Schema(name = "managerId", title = "管理者")
    @NotNull(message = "管理者不能为空")
    @NotEmpty(message = "管理者不能为空")
    private List<String> manager;

    @Schema(name = "deptName", title = "部门名称")
    @NotBlank(message = "部门名称不能为空")
    @NotNull(message = "部门名称不能为空")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

}

