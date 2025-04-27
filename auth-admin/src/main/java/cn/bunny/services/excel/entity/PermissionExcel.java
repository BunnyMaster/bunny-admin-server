package cn.bunny.services.excel.entity;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.*;
import com.alibaba.excel.enums.BooleanEnum;
import com.alibaba.excel.enums.poi.FillPatternTypeEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@HeadFontStyle(fontHeightInPoints = 22, color = 14, bold = BooleanEnum.TRUE)
@HeadStyle(fillForegroundColor = 9, fillPatternType = FillPatternTypeEnum.SOLID_FOREGROUND)
@HeadRowHeight(24)
public class PermissionExcel {

    @Schema(name = "id", title = "唯一标识")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "id"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 10, bold = BooleanEnum.TRUE)
    private Long id;

    @Schema(name = "parentId", title = "父级id")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "父级id"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 10, bold = BooleanEnum.TRUE)
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "权限编码"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 17, bold = BooleanEnum.TRUE)
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "权限名称"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 17, bold = BooleanEnum.TRUE)
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "请求路径"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 17, bold = BooleanEnum.TRUE)
    private String requestUrl;

    @Schema(name = "requestMethod", title = "请求方法")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "请求方法"})
    @ColumnWidth(66)
    @ContentFontStyle(fontHeightInPoints = 14, color = 17, bold = BooleanEnum.TRUE)
    private String requestMethod;

}