package impl;

import cn.bunny.domain.i18n.entity.I18n;
import cn.bunny.services.excel.entity.I18nExcel;
import cn.bunny.services.mapper.configuration.I18nMapper;
import cn.bunny.services.utils.i8n.I18nUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class I18nServiceImplTest extends ServiceImpl<I18nMapper, I18n> {

    @Test
    void downloadI18n() {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream);

        // 查找默认语言内容
        List<I18n> i18nList = list();
        HashMap<String, Object> hashMap = I18nUtil.getMap(i18nList);

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

        try {
            zipOutputStream.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void downloadI18nByExcel() {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {
            // 查找默认语言内容
            List<I18n> i18nList = list();
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
                // EasyExcel.write(key + ".xlsx", I18nExcel.class).sheet(key).doWrite(value);

                try {
                    ZipEntry zipEntry = new ZipEntry(key + ".xlsx");
                    zipOutputStream.putNextEntry(zipEntry);

                    // 直接写入到ZipOutputStream
                    EasyExcel.write(zipOutputStream, I18nExcel.class).sheet(key).doWrite(value);
                    zipOutputStream.closeEntry();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}