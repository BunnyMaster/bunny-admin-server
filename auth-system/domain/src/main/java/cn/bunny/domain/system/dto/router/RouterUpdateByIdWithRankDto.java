package cn.bunny.domain.system.dto.router;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RouterUpdateByIdWithRankDto对象", title = "根据菜单Id更新菜单排序", description = "根据菜单Id更新菜单排序")
public class RouterUpdateByIdWithRankDto {

    @Schema(name = "id", title = "唯一标识")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "routerRank", title = "等级")
    @JsonProperty("rank")
    private Integer routerRank;

}