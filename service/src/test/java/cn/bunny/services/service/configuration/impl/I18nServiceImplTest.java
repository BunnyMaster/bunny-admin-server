package cn.bunny.services.service.configuration.impl;

import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.services.mapper.configuration.I18nMapper;
import cn.bunny.services.utils.system.I18nUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@SpringBootTest
class I18nServiceImplTest extends ServiceImpl<I18nMapper, I18n> {

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
}