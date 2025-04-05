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
        return dto.getPath().stream().map(path -> {
            StringWriter writer = new StringWriter();

            String vmsPath = "vms/" + path + ".vm";
            String tableName = dto.getTableName();

            TableInfoVo tableMetaData = tableService.getTableMetaData(tableName);
            List<ColumnMetaData> columnInfo = tableService.getColumnInfo(tableName);


            VelocityContext context = new VelocityContext();
            context.put("tableName", tableMetaData.getComment());
            context.put("package", dto.getPackageName());
            context.put("columnInfo", columnInfo);

            // VmsUtil.commonVms(writer, context, "vms/server/controller.vm", dto);
            VmsUtil.commonVms(writer, context, vmsPath, dto);
            String code = writer.toString();

            return GeneratorVo.builder()
                    .code(code)
                    .comment(tableMetaData.getComment())
                    .tableName(tableMetaData.getTableName())
                    .path(vmsPath)
                    .build();
        }).toList();
    }
}
