package cn.bunny.service.impl;

import cn.bunny.dao.dto.VmsArgumentDto;
import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.vo.GeneratorVo;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import cn.bunny.service.VmsService;
import cn.bunny.utils.VmsUtil;
import org.apache.velocity.VelocityContext;
import org.springframework.stereotype.Service;

import java.io.StringWriter;
import java.util.List;

@Service

public class VmsServiceImpl implements VmsService {
    private final TableService tableService;

    public VmsServiceImpl(TableService tableService) {
        this.tableService = tableService;
    }

    /**
     * 生成服务端代码
     *
     * @param dto VmsArgumentDto
     * @return 生成内容
     */
    @Override
    public List<GeneratorVo> generator(VmsArgumentDto dto) {
        String tableName = dto.getTableName();

        return dto.getPath().stream().map(path -> {
            StringWriter writer = new StringWriter();

            // 表格属性名 和 列信息
            TableInfoVo tableMetaData = tableService.getTableMetaData(tableName);
            List<ColumnMetaData> columnInfoList = tableService.getColumnInfo(tableName);
            List<String> list = columnInfoList.stream().map(ColumnMetaData::getColumnName).toList();

            // 添加要生成的属性
            VelocityContext context = new VelocityContext();

            // 当前的表名
            context.put("tableName", tableMetaData.getTableName());

            // 表字段的注释内容
            context.put("comment", tableMetaData.getComment());

            // 设置包名称
            context.put("package", dto.getPackageName());

            // 当前表的列信息
            context.put("columnInfoList", columnInfoList);

            // 数据库sql列
            context.put("baseColumnList", String.join(",", list));

            VmsUtil.commonVms(writer, context, "vms/" + path + ".vm", dto);

            return GeneratorVo.builder()
                    .code(writer.toString())
                    .comment(tableMetaData.getComment())
                    .tableName(tableMetaData.getTableName())
                    .path(path)
                    .build();
        }).toList();
    }
}
