package cn.bunny.services.domain.common.model.vo.result;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 封装分页查询结果
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PageResult 对象", title = "分页返回结果", description = "分页返回结果")
public class PageResult<T> implements Serializable {

    @Schema(name = "pageNo", title = "当前页")
    private Long pageNo;

    @Schema(name = "pageSize", title = "每页记录数")
    private Long pageSize;

    @Schema(name = "total", title = "总记录数")
    private Long total;

    @Schema(name = "list", title = "当前页数据集合")
    private List<T> list;

}