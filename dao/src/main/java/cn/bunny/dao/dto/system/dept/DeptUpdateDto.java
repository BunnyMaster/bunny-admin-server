package cn.bunny.dao.dto.system.dept;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
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
@Schema(name = "DeptUpdateDto对象", title = "部门", description = "部门管理")
public class DeptUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "managerId", title = "管理者")
    @NotNull(message = "管理者不能为空")
    private List<String> manager;

    @Schema(name = "deptName", title = "部门名称")
    @NotBlank(message = "部门名称不能为空")
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

}

