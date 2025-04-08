package cn.bunny.service;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.vo.TableInfoVo;

import java.util.List;

public interface TableService {

    /**
     * 获取表属性
     *
     * @param tableName 表名称
     * @return 表属性
     */
    TableInfoVo getTableMetaData(String tableName);

    /**
     * 获取所有表
     *
     * @return 所有表信息
     */
    List<TableInfoVo> getAllTableMetaData();

    /**
     * 获取列属性
     *
     * @param tableName 表名称
     * @return 当前表所有的列内容
     */
    List<ColumnMetaData> getColumnInfo(String tableName);
}
