package cn.bunny.services.quartz;

import cn.bunny.services.aop.annotation.QuartzSchedulers;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.init.ResourceReader;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;


@Slf4j
@QuartzSchedulers(type = "backup", description = "数据库备份任务")
@Component
public class DatabaseBackupJob implements Job {

    @Autowired
    private Scheduler scheduler;

    @SneakyThrows
    @Override
    public void execute(JobExecutionContext context) {
        InputStream inputStream = ResourceReader.class.getResourceAsStream("static/backup.sh");
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
        // 执行脚本
        String scriptPath = Objects.requireNonNull(getClass().getClassLoader().getResource("static/backup.sh")).getPath();
        ProcessBuilder processBuilder = new ProcessBuilder("bash", scriptPath);
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

        // // 执行后读取内容
        // BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        // String line;
        // while ((line = reader.readLine()) != null) {System.out.println(line);}
    }
}
