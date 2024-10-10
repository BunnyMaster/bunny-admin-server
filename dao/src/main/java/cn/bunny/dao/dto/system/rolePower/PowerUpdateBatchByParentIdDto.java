package cn.bunny.dao.dto.system.rolePower;

import io.swagger.v3.oas.annotations.media.Schema;
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
@Schema(name = "PowerUpdateBatchByParentIdDto对象", title = "批量修改权限", description = "批量修改权限表单")
public class PowerUpdateBatchByParentIdDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private List<Long> ids;

    @Schema(name = "parentId", title = "父级id")
    @NotNull(message = "父级不能为空")
    private Long parentId;

}