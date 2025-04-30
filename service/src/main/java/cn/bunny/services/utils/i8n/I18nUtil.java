package cn.bunny.services.utils.i8n;

import cn.bunny.services.domain.common.excel.I18nExcel;
import cn.bunny.services.domain.system.i18n.entity.I18n;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import org.jetbrains.annotations.NotNull;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class I18nUtil {
    @NotNull
    public static HashMap<String, Object> getMap(@NotNull List<I18n> i18nList) {
        // 整理集合
        Map<String, Map<String, String>> map = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.toMap(I18n::getKeyName, I18n::getTranslation)));

        // 返回集合
        return new HashMap<>(map);
    }

    /**
     * 使用zip写入json
     *
     * @param i18nList        i18nList
     * @param zipOutputStream zipOutputStream
     */
    public static void writeJson(List<I18n> i18nList, ZipOutputStream zipOutputStream) {
        HashMap<String, Object> hashMap = getMap(i18nList);

        hashMap.forEach((k, v) -> {
            try {
                ZipEntry zipEntry = new ZipEntry(k + ".json");
                zipOutputStream.putNextEntry(zipEntry);

                zipOutputStream.write(JSON.toJSONString(v).getBytes(StandardCharsets.UTF_8));
                zipOutputStream.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }

    /**
     * 使用zip写入excel
     *
     * @param i18nList        i18nList
     * @param zipOutputStream zipOutputStream
     */
    public static void writeExcel(List<I18n> i18nList, ZipOutputStream zipOutputStream) {
        Map<String, List<I18nExcel>> hashMap = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.mapping((I18n i18n) -> {
                            String keyName = i18n.getKeyName();
                            String translation = i18n.getTranslation();
                            return I18nExcel.builder().keyName(keyName).translation(translation).build();
                        }, Collectors.toList())
                ));


        hashMap.forEach((key, value) -> {
            try {
                // 创建临时ByteArrayOutputStream
                ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();

                ZipEntry zipEntry = new ZipEntry(key + ".xlsx");
                zipOutputStream.putNextEntry(zipEntry);

                // 先写入到临时流
                EasyExcel.write(excelOutputStream, I18nExcel.class).sheet(key).doWrite(value);
                zipOutputStream.write(excelOutputStream.toByteArray());
                zipOutputStream.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }
}
