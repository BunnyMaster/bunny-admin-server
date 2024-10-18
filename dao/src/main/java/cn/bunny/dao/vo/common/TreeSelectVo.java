package cn.bunny.dao.vo.common;

import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(name = "TreeSelectList对象", title = "树形结构数据", description = "树形结构数据")
public class TreeSelectVo {

    @Schema(name = "id", title = "主键")
    @JsonProperty("id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;

    @Schema(name = "value", title = "值内容")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Object value;

    @Schema(name = "key", title = "key内容")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Object key;

    @Schema(name = "label", title = "显示内容")
    private String label;

    @Schema(name = "parentId", title = "父级id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long parentId;

    @Schema(name = "children", title = "子级内容")
    private List<TreeSelectVo> children;
}