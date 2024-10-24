package cn.bunny.services.quartz;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.concurrent.TimeUnit;


@Slf4j
// @QuartzSchedulers(type = "backup", description = "数据库备份(仅限本地docker中MySQL)")
@Component
public class DatabaseBackupJob implements Job {

    @Value("${bunny.backPath}")
    private String backPath;

    @SneakyThrows
    @Override
    public void execute(JobExecutionContext context) {
        // 读取资源目录下脚本文件并写入到主机中
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/backup.sh")) {
            if (inputStream == null) return;
            byte[] bytes = inputStream.readAllBytes();
            Files.write(Path.of(backPath + "/backup.sh"), bytes);
        }

        // 执行脚本
        System.setProperty("TERM", "xterm");
        ProcessBuilder processBuilder = new ProcessBuilder("sh", backPath + "/backup.sh");
        processBuilder.redirectErrorStream(true);
        Process process = processBuilder.start();

        // 执行命令
        ProcessHandle handle = process.toHandle();

        // 执行任务的pid
        long pid = handle.pid();

        // 执行任务系统信息
        JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
        Map<String, String> environment = processBuilder.environment();
        String info = handle.info().toString();
        jobDataMap.put("pid", pid);
        jobDataMap.put("systemInfo", info);
        jobDataMap.put("environment", environment);

        // 进程是否结束
        if (process.waitFor(5, TimeUnit.MINUTES)) {
            int waitedFor = process.waitFor();
            jobDataMap.put("existCode", waitedFor);
        } else process.destroyForcibly();

        // 执行后读取内容
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line;
        StringBuilder stringBuilder = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            System.out.println(line);
        }
        jobDataMap.put("output", stringBuilder.toString());
    }
}
