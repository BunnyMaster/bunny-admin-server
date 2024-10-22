package cn.bunny.service;

import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

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
}
