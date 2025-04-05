package cn.bunny.utils;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class DbInfoUtil {

    @Autowired
    private DataSource dataSource;

    /**
     * 获取表的所有主键列名
     *
     * @param tableName 表名
     * @return 主键列名的集合
     */
    public Set<String> getPrimaryKeyColumns(String tableName) throws SQLException {
        Set<String> primaryKeys = new HashSet<>();

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet pkResultSet = metaData.getPrimaryKeys(null, null, tableName);

            while (pkResultSet.next()) {
                primaryKeys.add(pkResultSet.getString("COLUMN_NAME").toLowerCase());
            }

            return primaryKeys;
        }
    }

    public List<TableMetaData> getAllTableInfo() throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "%", new String[]{"TABLE"});

            List<TableMetaData> list = new ArrayList<>();

            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                TableMetaData tableMetaData = tableInfo(tableName);
                list.add(tableMetaData);
            }

            return list;
        }
    }

    /**
     * 获取表注释信息
     *
     * @param tableName 数据库表名
     * @return 表信息
     * @throws SQLException SQLException
     */
    public TableMetaData tableInfo(String tableName) throws SQLException {
        TableMetaData tableMetaData;

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, tableName, new String[]{"TABLE"});

            // 获取表的注释信息
            if (tables.next()) {
                String remarks = tables.getString("REMARKS");
                String tableCat = tables.getString("TABLE_CAT");
                String tableSchem = tables.getString("TABLE_SCHEM");
                String tableType = tables.getString("TABLE_TYPE");
                String typeCat = tables.getString("TYPE_CAT");
                String typeSchem = tables.getString("TYPE_SCHEM");
                String typeName = tables.getString("TYPE_NAME");
                String selfReferencingColName = tables.getString("SELF_REFERENCING_COL_NAME");
                String refGeneration = tables.getString("REF_GENERATION");

                tableMetaData = TableMetaData.builder()
                        .tableName(tableName)
                        .comment(remarks)
                        .tableCat(tableCat)
                        .tableSchem(tableSchem)
                        .tableType(tableType)
                        .typeCat(typeCat)
                        .typeSchem(typeSchem)
                        .typeName(typeName)
                        .selfReferencingColName(selfReferencingColName)
                        .refGeneration(refGeneration)
                        .build();
            } else {
                throw new RuntimeException("数据表不存在");
            }

            return tableMetaData;
        }
    }

    /**
     * 数据库列信息
     *
     * @param tableName 表名
     * @return 列表信息
     * @throws SQLException SQLException
     */
    public List<ColumnMetaData> columnInfo(String tableName) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            List<ColumnMetaData> columns = new ArrayList<>();

            Set<String> primaryKeyColumns = getPrimaryKeyColumns(tableName);

            try (ResultSet columnsRs = metaData.getColumns(null, null, tableName, null)) {
                while (columnsRs.next()) {
                    ColumnMetaData column = new ColumnMetaData();
                    String columnName = columnsRs.getString("COLUMN_NAME");

                    column.setColumnName(columnName);
                    column.setFieldName(ConvertUtil.convertToFieldName(column.getColumnName()));
                    column.setJdbcType(columnsRs.getString("TYPE_NAME"));
                    column.setJavaType(ConvertUtil.convertToJavaType(column.getJdbcType()));
                    column.setComment(columnsRs.getString("REMARKS"));

                    // 确保 primaryKeyColumns 不为空
                    if (!primaryKeyColumns.isEmpty()) {
                        column.setIsPrimaryKey(primaryKeyColumns.contains(columnName));
                    }

                    columns.add(column);
                }
            }

            columns.get(0).setIsPrimaryKey(true);

            return columns;
        }
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
