package cn.bunny.services.domain.common.excel;

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
public class I18nExcel {

    @Schema(name = "keyName", title = "多语言key")
    @ExcelProperty("keyName/多语言主键")
    // 列宽
    @ColumnWidth(66)
    // fontHeightInPoints：字体大小，颜色：color 【绿色】
    @ContentFontStyle(fontHeightInPoints = 18, color = 17, bold = BooleanEnum.TRUE)
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    @ExcelProperty("translation/多语言翻译")
    // 列宽
    @ColumnWidth(106)
    // fontHeightInPoints：字体大小，颜色：color 【天蓝色】
    @ContentFontStyle(fontHeightInPoints = 18, color = 40, bold = BooleanEnum.TRUE)
    private String translation;

}
