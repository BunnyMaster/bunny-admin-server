package cn.bunny.services.quartz;

import cn.bunny.dao.pojo.constant.LocalDateTimeConstant;
import cn.bunny.services.aop.annotation.QuartzSchedulers;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@Slf4j
@QuartzSchedulers(type = "backup", description = "数据库备份任务")
@Component
public class DatabaseBackupJob implements Job {

    @Value("${spring.datasource.dynamic.datasource.master.username}")
    private String masterUsername;

    @Value("${spring.datasource.dynamic.datasource.master.password}")
    private String masterPassword;

    @Value("${bunny.master.database}")
    private String masterDatabase;

    @Value("${bunny.master.databaseBackupDir}")
    private String databaseBackupDir;

    @Override
    public void execute(JobExecutionContext context) {
        // 格式化时间
        LocalDateTime localStartExecuteTime = LocalDateTime.now();
        DateTimeFormatter sqlTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_UNDERLINE);
        String sqlTimeNow = localStartExecuteTime.format(sqlTimeFormatter);

        // 命令行参数
        String dockerCommand = "docker exec -it bunny_auth_server bash";
        String mysqldumpCommand = "mysqldump -u " + masterUsername + " -p" + masterPassword + " " + masterDatabase + " > " + databaseBackupDir + "backup_auth_admin_" + sqlTimeNow + ".sql";
        ProcessBuilder processBuilder = new ProcessBuilder(dockerCommand, mysqldumpCommand);

        try {
            // 执行命令
            Process process = processBuilder.start();

            // 执行后读取内容
            InputStream inputStream = process.getInputStream();
            StringBuilder output = new StringBuilder();
            byte[] bytes = new byte[1024];
            int bytesRead;

            while ((bytesRead = inputStream.read(bytes)) != -1) {
                output.append(new String(bytes, 0, bytesRead));
            }
            System.out.println(output);
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
    }
}
