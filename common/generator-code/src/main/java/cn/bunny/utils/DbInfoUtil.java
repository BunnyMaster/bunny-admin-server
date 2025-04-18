package cn.bunny.utils;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import org.apache.commons.lang3.StringUtils;
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

    private final DataSource dataSource;

    public DbInfoUtil(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * 获取表的所有主键列名
     *
     * @param tableName 表名
     * @return 主键列名的集合
     */
    public Set<String> getPrimaryKeyColumns(String tableName) throws SQLException {
        // 主键的key
        Set<String> primaryKeys = new HashSet<>();

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();

            // 当前表的主键
            ResultSet pkResultSet = metaData.getPrimaryKeys(null, null, tableName);

            while (pkResultSet.next()) {
                // 列字段
                String columnName = pkResultSet.getString("COLUMN_NAME").toLowerCase();
                primaryKeys.add(columnName);
            }

            return primaryKeys;
        }
    }

    /**
     * 获取数据库中所有的表
     *
     * @param dbName 数据库名称，如果不传为数据库中所有的表
     * @return 当前/所有 的数据库表
     */
    public List<TableMetaData> getDbTableList(String dbName) throws SQLException {
        // 所有的表属性
        List<TableMetaData> list = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();

            // 当前数据库中所有的表
            ResultSet tables = metaData.getTables(dbName, null, "%", new String[]{"TABLE"});

            while (tables.next()) {
                // 表名称
                dbName = tables.getString("TABLE_NAME");

                // 设置表信息
                TableMetaData tableMetaData = tableInfo(dbName);
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
                // 备注信息
                String remarks = tables.getString("REMARKS");

                // 数组名称
                String tableCat = tables.getString("TABLE_CAT");

                // 通常是"TABLE"
                String tableType = tables.getString("TABLE_TYPE");

                tableMetaData = TableMetaData.builder()
                        .tableName(tableName)
                        .comment(remarks)
                        .tableCat(tableCat)
                        .tableType(tableType)
                        .build();
            } else {
                throw new RuntimeException("数据表不存在");
            }

            return tableMetaData;
        }
    }

    /**
     * 数据库表列信息
     *
     * @param tableName 表名
     * @return 列表信息
     * @throws SQLException SQLException
     */
    public List<ColumnMetaData> columnInfo(String tableName) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();

            List<ColumnMetaData> columns = new ArrayList<>();

            // 当前表的主键
            Set<String> primaryKeyColumns = getPrimaryKeyColumns(tableName);

            // 当前表的列信息
            try (ResultSet columnsRs = metaData.getColumns(null, null, tableName, null)) {
                while (columnsRs.next()) {
                    ColumnMetaData column = new ColumnMetaData();

                    // 列字段
                    String columnName = columnsRs.getString("COLUMN_NAME");

                    // 将当前表的列类型转成 Java 类型
                    String javaType = ConvertUtil.convertToJavaType(column.getJdbcType());

                    // 设置列字段
                    column.setColumnName(columnName);
                    // 列字段转成 下划线 -> 小驼峰
                    column.setFieldName(ConvertUtil.convertToCamelCase(column.getColumnName()));

                    // 字段类型
                    column.setJdbcType(columnsRs.getString("TYPE_NAME"));
                    // 字段类型转 Java 类型
                    column.setJavaType(javaType);
                    // 字段类型转 JavaScript 类型
                    column.setJavascriptType(StringUtils.uncapitalize(javaType));

                    // 备注信息
                    column.setComment(columnsRs.getString("REMARKS"));

                    // 确保 primaryKeyColumns 不为空
                    if (!primaryKeyColumns.isEmpty()) {
                        // 是否是主键
                        boolean isPrimaryKey = primaryKeyColumns.contains(columnName);
                        column.setIsPrimaryKey(isPrimaryKey);
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
