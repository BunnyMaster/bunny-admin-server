package cn.bunny.service;

import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;
import org.springframework.core.io.ResourceLoader;
import org.springframework.data.redis.core.script.ScriptExecutor;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Objects;

public class TestPath {
    @SneakyThrows
    @Test
    void testPath() {
        String scriptPath = Objects.requireNonNull(getClass().getClassLoader().getResource("static/backup.sh")).getPath();
        String path = ScriptExecutor.class.getClassLoader().getResource("static/backup.sh").getPath();
        System.out.println(path);
        // 执行脚本
        ProcessBuilder processBuilder = new ProcessBuilder("bash", scriptPath);
        processBuilder.redirectErrorStream(true);
        Process process = processBuilder.start();

        // 执行后读取内容
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {System.out.println(line);}
    }

    @SneakyThrows
    @Test
    void test2() {
        ClassLoader classLoader = ResourceLoader.class.getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("static/backup.sh");
        try (java.util.Scanner s = new java.util.Scanner(inputStream)) {
            while (s.hasNext()) {
                System.out.println(s.nextLine());
            }
        }


        byte[] bytes = inputStream.readAllBytes();
        String string = new String(bytes, StandardCharsets.UTF_8);
        System.out.println(string);
    }
}
