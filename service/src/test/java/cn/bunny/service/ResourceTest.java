package cn.bunny.service;

import org.junit.jupiter.api.Test;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class ResourceTest {

    // 读取resource下目录方式1
    @Test
    void test1() {
        try (InputStream resourceAsStream = getClass().getClassLoader().getResourceAsStream("static/backup.sh")) {
            if (resourceAsStream == null) return;

            // 文件存储一共的内容
            StringBuilder builder = new StringBuilder();

            // 读取文件内容
            BufferedReader reader = new BufferedReader(new InputStreamReader(resourceAsStream));
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line).append("\n");
            }

            // 输出文件内容
            System.out.println(builder);
            reader.close();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    // 读取resource下目录方式2
    @Test
    void test2() {
        try (InputStream inputStream = getClass().getResourceAsStream("/static/backup.sh")) {
            if (inputStream == null) return;

            // 获取所有数组内容
            byte[] bytes = inputStream.readAllBytes();

            // 读取文件中内容
            String string = new String(bytes, StandardCharsets.UTF_8);
            System.out.println(string);

            // 读取文件转成Base64
            String str = Base64.getEncoder().encodeToString(bytes);
            System.out.println(str);

        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    // 读取resource下目录方式3
    @Test
    void test3() {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        try (InputStream inputStream = classLoader.getResourceAsStream("static/backup.sh")) {
            if (inputStream == null) return;

            // 获取所有数组内容
            byte[] bytes = inputStream.readAllBytes();

            // 读取文件中内容
            String string = new String(bytes, StandardCharsets.UTF_8);
            System.out.println(string);

            // 读取文件转成Base64
            String str = Base64.getEncoder().encodeToString(bytes);
            System.out.println(str);

        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }
}
