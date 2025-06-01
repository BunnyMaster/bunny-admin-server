package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
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
@Schema(name = "DeptDto对象", title = "部门分页查询", description = "部门分页查询")
public class DeptDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "managerId", title = "管理者")
    @NotEmpty(message = "管理者不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private List<String> manager;

    @Schema(name = "deptName", title = "部门名称")
    @NotBlank(message = "部门名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String deptName;

    @Schema(name = "summary", title = "部门简介")
    private String summary;

}

