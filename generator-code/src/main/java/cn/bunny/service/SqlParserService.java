package cn.bunny.service;

import cn.bunny.dao.vo.TableInfoVo;

public interface SqlParserService {
    /**
     * 解析SQL内容
     *
     * @param sql Sql语句
     * @return 表信息内容
     */
    TableInfoVo tableInfo(String sql);
}
