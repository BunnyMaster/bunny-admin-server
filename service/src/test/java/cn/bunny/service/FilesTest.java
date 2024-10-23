package cn.bunny.service;

import lombok.SneakyThrows;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;

public class FilesTest {

    @Test
    void test1() throws IOException {
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/backup.sh")) {
            if (inputStream == null) return;

            byte[] bytes = inputStream.readAllBytes();
            Files.write(Path.of("H:\\资料\\backup.sh"), bytes);
        }
    }

    @SneakyThrows
    @Test
    void test2() {
        // 读取资源目录下脚本文件并写入到主机中
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/backup.sh");
        if (inputStream == null) return;
        byte[] bytes = inputStream.readAllBytes();
        Files.write(Path.of("H:/资料" + "/backup.sh"), bytes);
        inputStream.close();
    }

    @Test
    void test3() throws IOException {
        String string = Files.readString(Path.of("E:\\data.js"));
        System.out.println(string);
    }

    @Test
    void test4() throws IOException {
        File file = FileUtils.listFiles(new File("E:\\资料\\其她\\分析日记\\2024\\10月"), null, true).stream()
                .max(Comparator.comparing(File::lastModified))
                .orElse(new File(""));
        System.out.println(file.getPath());
    }
}
