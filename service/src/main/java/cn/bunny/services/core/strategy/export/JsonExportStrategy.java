package cn.bunny.services.core.strategy.export;

import com.alibaba.fastjson2.JSON;

import java.nio.charset.StandardCharsets;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class JsonExportStrategy implements ExportStrategy<Object> {

    @Override
    public void export(Object data, ZipOutputStream zipOutputStream, String filename) {
        try {
            ZipEntry zipEntry = new ZipEntry(filename);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(JSON.toJSONString(data).getBytes(StandardCharsets.UTF_8));
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}