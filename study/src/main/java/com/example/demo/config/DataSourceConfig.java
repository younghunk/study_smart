package com.example.demo.config;

import com.zaxxer.hikari.HikariDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {
    // @ConfigurationProperties : 프로퍼티 설절파일을 읽어들이는 어노테이션
    // application.properties의 설정한 커스텀데이터소스 설정부분을 prefix의 값으로 설정한다.

    @Bean
    @ConfigurationProperties("spring.datasource.org")
    public DataSource orgDataSource() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }
    
    @Bean
    @ConfigurationProperties("spring.datasource.ap1")
    public DataSource ap1DataSource() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }
    @Bean
    @ConfigurationProperties("spring.datasource.ap2")
    public DataSource ap2DataSource() {
    	return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean
    @ConfigurationProperties("spring.datasource.hikari.ap")
    public DataSource apDataSource1() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean
    @ConfigurationProperties("spring.datasource.hikari.ap2")
    public DataSource apDataSource2() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }


}