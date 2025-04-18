package cn.bunny.dao.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TableInfoVo {

    /* 表目录 */
    private String tableCat;

    /* 表名 */
    private String tableName;

    /* 表类型（通常是"TABLE"） */
    private String tableType;

    /* 注释内容 */
    private String comment;

    /* 类名 */
    private String className;

}
