package cn.bunny.services.backup;

import cn.bunny.dao.pojo.constant.LocalDateTimeConstant;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MysqlBackupTest {
    @SneakyThrows
    @Test
    void testMysqlBackup() {
        LocalDateTime localDateTime = LocalDateTime.now();
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_UNDERLINE);
        String timeNow = localDateTime.format(timeFormatter);

        System.out.println(timeNow);

    }
}
