package cn.bunny.config;

import jakarta.annotation.PostConstruct;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

@Component
public class DatabaseMetadataHolder {
    @Getter
    private DatabaseMetaData metaData;

    @Autowired
    private DataSource dataSource;

    @PostConstruct
    public void init() throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            this.metaData = connection.getMetaData();
        }
    }
}