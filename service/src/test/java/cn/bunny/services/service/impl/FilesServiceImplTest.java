package cn.bunny.services.service.impl;

import cn.bunny.dao.pojo.constant.MinioConstant;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;

class FilesServiceImplTest {
    @Test
    void stringTest() {
        String filepath = "/auth-admin/avatar/2024/10-04/5a56ad8f-4468-4780-8a61-424e7de54e04.png";
        int start = filepath.indexOf("/", 1);
        filepath = filepath.substring(start + 1);
        System.out.println(filepath);

        int end = filepath.lastIndexOf("/");
        String filename = filepath.substring(end + 1);
        System.out.println(filename);
    }

    @SneakyThrows
    @Test
    void getAllMediaTypeTest() {
        Class<?> mediaTypeClass = MediaType.class;
        for (Field declaredField : mediaTypeClass.getDeclaredFields()) {
            declaredField.setAccessible(true);
            String value = declaredField.get(null).toString();
            if (value.matches("\\w+/.*")) {
                System.out.println(value);
            }
        }
    }

    @Test
    void getAllPaths() {
        Map<String, String> typeMap = MinioConstant.typeMap;
        List<Map.Entry<String, String>> list = typeMap.entrySet().stream().toList();
        System.out.println(list);
    }
}