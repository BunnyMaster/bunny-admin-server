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

    /* 表目录 */
    private String tableCat;

    /* 表模式（可能为null） */
    private String tableSchem;

    /* 表类型（通常是"TABLE"） */
    private String tableType;

    /* 类型的目录（可能为null） */
    private String typeCat;

    /* 类型的模式（可能为null） */
    private String typeSchem;

    /* 类型名称（可能为null） */
    private String typeName;

    /* 自引用列名（可能为null） */
    private String selfReferencingColName;

    /* 引用生成（可能为null） */
    private String refGeneration;

    /* 表名 */
    private String tableName;

    /* 类名 */
    private String className;

    /* 注释内容 */
    private String comment;

    /* 列名称 */
    private List<ColumnMetaData> columns;
}