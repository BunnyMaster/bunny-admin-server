package cn.bunny.utils;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.SQLException;
import java.util.List;

@SpringBootTest
class DbInfoUtilTest {

    String tableName = "sys_i18n";

    @Autowired
    private DbInfoUtil dbInfoUtil;

    @Test
    void tableInfo() throws SQLException {
        TableMetaData tableMetaData = dbInfoUtil.tableInfo(tableName);
        System.out.println(tableMetaData);
    }

    @Test
    void columnInfo() throws SQLException {
        List<ColumnMetaData> columnMetaDataList = dbInfoUtil.columnInfo(tableName);
        columnMetaDataList.forEach(System.out::println);
    }

    @Test
    void dbInfo() throws SQLException {
        TableMetaData tableMetaData = dbInfoUtil.dbInfo(tableName);
        System.out.println(tableMetaData);
    }
}