package cn.bunny.services.domain.common.model.dto.excel;

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
// fontHeightInPoints：字体大小，颜色：color 【绿色】
@HeadFontStyle(fontHeightInPoints = 22, color = 14, bold = BooleanEnum.TRUE)
// fillForegroundColor 将背景填充为【白色】
@HeadStyle(fillForegroundColor = 9, fillPatternType = FillPatternTypeEnum.SOLID_FOREGROUND)
@HeadRowHeight(24)
public class RoleExcel {

    @Schema(name = "id", title = "唯一标识")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "id/唯一标识(添加不填写)"})
    @ColumnWidth(66)
    // 字体颜色红色
    @ContentFontStyle(fontHeightInPoints = 14, color = 10, bold = BooleanEnum.TRUE)
    private String id;

    @Schema(name = "roleCode", title = "角色代码")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "roleCode/角色代码"})
    // 列宽
    @ColumnWidth(66)
    // fontHeightInPoints：字体大小，颜色：color 【绿色】
    @ContentFontStyle(fontHeightInPoints = 14, color = 17, bold = BooleanEnum.TRUE)
    private String roleCode;

    @Schema(name = "description", title = "描述")
    @ExcelProperty({"修改时不要修改id列，如需更新不填写此列", "description/描述"})
    @ColumnWidth(66)
    // fontHeightInPoints：字体大小，颜色：color 【天蓝色】
    @ContentFontStyle(fontHeightInPoints = 14, color = 40, bold = BooleanEnum.TRUE)
    private String description;

}
