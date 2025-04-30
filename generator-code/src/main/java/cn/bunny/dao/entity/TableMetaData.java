package cn.bunny.dao.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TableMetaData {

    /* 表名 */
    private String tableName;

    /* 注释内容 */
    private String comment;

    /* 表目录 */
    private String tableCat;

    /* 表类型（通常是"TABLE"） */
    private String tableType;

    /* 类名 */
    private String className;

    /* 列名称 */
    private List<ColumnMetaData> columns;
}