package cn.bunny.service.impl;

import cn.bunny.core.SqlParserCore;
import cn.bunny.dao.entity.TableMetaData;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.SqlParserService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class SqlParserServiceImpl implements SqlParserService {

    /**
     * 解析SQL内容
     *
     * @param sql Sql语句
     * @return 表信息内容
     */
    @Override
    public TableInfoVo tableInfo(String sql) {
        TableInfoVo tableInfoVo = new TableInfoVo();

        TableMetaData tableMetaData = SqlParserCore.parserTableInfo(sql);
        BeanUtils.copyProperties(tableMetaData, tableInfoVo);
        return tableInfoVo;
    }
}
