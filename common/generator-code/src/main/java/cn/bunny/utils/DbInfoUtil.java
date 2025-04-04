package cn.bunny.utils;

import cn.bunny.config.DatabaseMetadataHolder;
import cn.bunny.entity.ColumnMetaData;
import cn.bunny.entity.TableMetaData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
public class DbInfoUtil {
    @Autowired
    private DatabaseMetadataHolder metadataHolder;

    /**
     * 获取表注释信息
     *
     * @param tableName 数据库表名
     * @return 表信息
     * @throws SQLException SQLException
     */
    public TableMetaData tableInfo(String tableName) throws SQLException {
        TableMetaData tableMetaData = null;
        DatabaseMetaData metaData = metadataHolder.getMetaData();
        ResultSet tables = metaData.getTables(null, null, tableName, new String[]{"TABLE"});

        // 获取表的注释信息
        if (tables.next()) {
            String remarks = tables.getString("REMARKS" );
            String tableCat = tables.getString("TABLE_CAT" );
            String tableSchem = tables.getString("TABLE_SCHEM" );
            String tableType = tables.getString("TABLE_TYPE" );
            String typeCat = tables.getString("TYPE_CAT" );
            String typeSchem = tables.getString("TYPE_SCHEM" );
            String typeName = tables.getString("TYPE_NAME" );
            String selfReferencingColName = tables.getString("SELF_REFERENCING_COL_NAME" );
            String refGeneration = tables.getString("REF_GENERATION" );

            tableMetaData = TableMetaData.builder()
                    .tableName(tableName)
                    .remarks(remarks)
                    .tableCat(tableCat)
                    .tableSchem(tableSchem)
                    .tableType(tableType)
                    .typeCat(typeCat)
                    .typeSchem(typeSchem)
                    .typeName(typeName)
                    .selfReferencingColName(selfReferencingColName)
                    .refGeneration(refGeneration)
                    .build();
        }

        return tableMetaData;
    }

    /**
     * 数据库列信息
     *
     * @param tableName 表名
     * @return 列表信息
     * @throws SQLException SQLException
     */
    public List<ColumnMetaData> columnInfo(String tableName) throws SQLException {
        DatabaseMetaData metaData = metadataHolder.getMetaData();
        List<ColumnMetaData> columns = new ArrayList<>();

        try (ResultSet columnsRs = metaData.getColumns(null, null, tableName, null)) {
            while (columnsRs.next()) {
                ColumnMetaData column = new ColumnMetaData();
                column.setColumnName(columnsRs.getString("COLUMN_NAME" ));
                column.setFieldName(ConvertUtil.convertToFieldName(column.getColumnName()));
                column.setJdbcType(columnsRs.getString("TYPE_NAME" ));
                column.setJavaType(ConvertUtil.convertToJavaType(column.getJdbcType()));
                column.setComment(columnsRs.getString("REMARKS" ));

                columns.add(column);
            }
        }

        return columns;
    }

    /**
     * 数据库所有的信息
     *
     * @param tableName 表名
     * @return 表内容
     * @throws SQLException SQLException
     */
    public TableMetaData dbInfo(String tableName) throws SQLException {
        List<ColumnMetaData> columnMetaData = columnInfo(tableName);
        TableMetaData tableMetaData = tableInfo(tableName);

        tableMetaData.setColumns(columnMetaData);

        return tableMetaData;
    }
}
