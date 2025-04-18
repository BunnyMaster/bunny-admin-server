package cn.bunny.service.impl;

import cn.bunny.dao.dto.VmsArgumentDto;
import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.vo.GeneratorVo;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.dao.vo.VmsPathVo;
import cn.bunny.service.TableService;
import cn.bunny.service.VmsService;
import cn.bunny.utils.ResourceFileUtil;
import cn.bunny.utils.VmsUtil;
import cn.hutool.crypto.digest.MD5;
import lombok.SneakyThrows;
import org.apache.velocity.VelocityContext;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
            List<ColumnMetaData> columnInfoList = tableService.getColumnInfo(tableName).stream().distinct().toList();
            List<String> list = columnInfoList.stream().map(ColumnMetaData::getColumnName).toList();

            // 添加要生成的属性
            VelocityContext context = new VelocityContext();

            // 当前的表名
            context.put("tableName" , tableMetaData.getTableName());

            // 表字段的注释内容
            context.put("comment" , dto.getComment());

            // 设置包名称
            context.put("package" , dto.getPackageName());

            // 当前表的列信息
            context.put("columnInfoList" , columnInfoList);

            // 数据库sql列
            context.put("baseColumnList" , String.join("," , list));

            // 生成模板
            VmsUtil.commonVms(writer, context, "vms/" + path, dto);

            // 处理 vm 文件名
            path = VmsUtil.handleVmFilename(path, dto.getClassName());

            return GeneratorVo.builder()
                    .code(writer.toString())
                    .comment(tableMetaData.getComment())
                    .tableName(tableMetaData.getTableName())
                    .path(path)
                    .build();
        }).toList();
    }

    /**
     * 获取vms文件路径
     *
     * @return vms下的文件路径
     */
    @SneakyThrows
    @Override
    public Map<String, List<VmsPathVo>> getVmsPathList() {
        // 读取当前项目中所有的 vm 模板发给前端
        List<String> vmsRelativeFiles = ResourceFileUtil.getRelativeFiles("vms" );

        return vmsRelativeFiles.stream().map(vmFile -> {
                    String[] filepathList = vmFile.split("/" );
                    String filename = filepathList[filepathList.length - 1].replace(".vm" , "" );

                    return VmsPathVo.builder().name(vmFile).label(filename).type(filepathList[0]).build();
                })
                .collect(Collectors.groupingBy(VmsPathVo::getType));
    }

    /**
     * 打包成zip下载
     *
     * @param dto VmsArgumentDto
     * @return zip 文件
     */
    @Override
    public ResponseEntity<byte[]> downloadByZip(VmsArgumentDto dto) {
        // 需要下载的数据
        List<GeneratorVo> generatorVoList = generator(dto);

        // 1. 创建临时ZIP文件
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {
            // 2. 遍历并创建
            generatorVoList.forEach(generatorVo -> {
                // zip中的路径
                String path = generatorVo.getPath().replace(".vm" , "" );

                // zip中的文件
                String code = generatorVo.getCode();

                ZipEntry zipEntry = new ZipEntry(path);
                try {
                    // 如果有 / 会转成文件夹
                    zipOutputStream.putNextEntry(zipEntry);

                    // 写入文件
                    zipOutputStream.write(code.getBytes(StandardCharsets.UTF_8));
                    zipOutputStream.closeEntry();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 2.1 文件不重名
        long currentTimeMillis = System.currentTimeMillis();
        String digestHex = MD5.create().digestHex(currentTimeMillis + "" );

        // 3. 准备响应
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition" , "attachment; filename=" + "vms-" + digestHex + ".zip" );
        headers.add("Cache-Control" , "no-cache, no-store, must-revalidate" );
        headers.add("Pragma" , "no-cache" );
        headers.add("Expires" , "0" );

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        return new ResponseEntity<>(byteArrayInputStream.readAllBytes(), headers, HttpStatus.OK);
    }
}
