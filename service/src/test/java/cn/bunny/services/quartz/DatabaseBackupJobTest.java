package cn.bunny.services.quartz;

import org.junit.jupiter.api.Test;

import java.io.BufferedReader;
import java.io.InputStreamReader;

class DatabaseBackupJobTest {
    @Test
    void testProcess() {
        // 执行备份命令
        ProcessBuilder processBuilder = new ProcessBuilder("java", "--version");

        try {
            Process process = processBuilder.start();

            // 使用输出流读取命令的输出
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            reader.lines().forEach(System.out::println);

            // 等待进程结束并获取退出值
            int exitCode = process.waitFor();
            System.out.println("Exit code: " + exitCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}