package cn.bunny.service.impl;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import cn.bunny.utils.DbInfoUtil;
import lombok.SneakyThrows;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableServiceImpl implements TableService {

    private final DbInfoUtil dbInfoUtil;

    public TableServiceImpl(DbInfoUtil dbInfoUtil) {
        this.dbInfoUtil = dbInfoUtil;
    }

    /**
     * 获取表属性
     *
     * @param tableName 表名称
     * @return 表属性
     */
    @SneakyThrows
    @Override
    public TableInfoVo getTableMetaData(String tableName) {
        TableInfoVo tableInfoVo = new TableInfoVo();

        TableMetaData tableMetaData = dbInfoUtil.tableInfo(tableName);
        BeanUtils.copyProperties(tableMetaData, tableInfoVo);

        return tableInfoVo;
    }

    /**
     * 获取[当前/所有]数据库表
     *
     * @return 所有表信息
     */
    @SneakyThrows
    @Override
    public List<TableInfoVo> getDbTables(String dbName) {
        // 当前数据库数据库所有的表
        List<TableMetaData> allTableInfo = dbInfoUtil.getDbTableList(dbName);

        return allTableInfo.stream().map(tableMetaData -> {
            TableInfoVo tableInfoVo = new TableInfoVo();
            BeanUtils.copyProperties(tableMetaData, tableInfoVo);

            return tableInfoVo;
        }).toList();
    }

    /**
     * 获取当前表的列属性
     *
     * @param tableName 表名称
     * @return 当前表所有的列内容
     */
    @SneakyThrows
    @Override
    public List<ColumnMetaData> getColumnInfo(String tableName) {
        return dbInfoUtil.columnInfo(tableName);
    }
}
