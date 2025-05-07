package cn.bunny.services.core.strategy.export;

import com.alibaba.excel.EasyExcel;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ExcelZipExportStrategy implements ExportStrategy<List<?>> {

    private final Class<?> clazz;
    private final String sheetName;

    public ExcelZipExportStrategy(Class<?> clazz, String sheetName) {
        this.clazz = clazz;
        this.sheetName = sheetName;
    }

    @Override
    public void export(List<?> data, ZipOutputStream zipOutputStream, String filename) {
        try {
            ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();
            EasyExcel.write(excelOutputStream, clazz).sheet(sheetName).doWrite(data);

            // 将Excel写入到Zip中
            ZipEntry zipEntry = new ZipEntry(filename);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(excelOutputStream.toByteArray());
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}