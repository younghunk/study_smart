package com.example.demo.config;

import com.zaxxer.hikari.HikariDataSource;
import jakarta.annotation.Nullable;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
//@PropertySource("classpath:/application.properties")
//application.properties에서 작성한 내용을 사용
//데이터베이스와 Mybatis 설정을 구성하는 자바 설정 파일
public class DatabaseConfig {

    //MyBatis의 SqlSessionFactory 설정
    //데이터베이스의 연결정보와 매퍼 파일 위치를 설정
    //데이터 연결 정보는 dataSource에서 가져옴
    @Bean
    public SqlSessionFactory apSqlSessionFactoryBean() throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(apDataSource());
        return getSqlSessionFactory(sqlSessionFactoryBean);
    }

    @Bean
    public SqlSessionFactory apSqlSessionFactoryBean2() throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(apDataSource2());
        return getSqlSessionFactory(sqlSessionFactoryBean);
    }

    @Nullable
    private SqlSessionFactory getSqlSessionFactory(SqlSessionFactoryBean sqlSessionFactoryBean) throws Exception {
        Resource[] resources = new PathMatchingResourcePatternResolver()
                .getResources("classpath:mapper/**/**.xml");

        sqlSessionFactoryBean.setMapperLocations(resources);
        SqlSessionFactory sqlSessionFactory = sqlSessionFactoryBean.getObject();
        org.apache.ibatis.session.Configuration configuration = sqlSessionFactory != null ? sqlSessionFactory.getConfiguration() : null;
        if (configuration != null) {
            configuration.setMapUnderscoreToCamelCase(true);
            return sqlSessionFactory;
        }
        return null;
    }

    //apSqlSession을 생성하고 반환하는 메서드
    //SqlSession은 Mybatis와 데이터베이스간의 상호작용 담당
    @Bean
    public SqlSession apSqlSession() throws Exception {
        return new SqlSessionTemplate(apSqlSessionFactoryBean());
    }

    @Bean
    public SqlSession apSqlSession2() throws Exception {
        return new SqlSessionTemplate(apSqlSessionFactoryBean2());
    }

    @Bean
    @ConfigurationProperties("spring.datasource.hikari.ap")
    public DataSource apDataSource() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean
    @ConfigurationProperties("spring.datasource.hikari.ap2")
    public DataSource apDataSource2() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean
    public SqlSession batchSqlSession2() throws Exception {
        return new SqlSessionTemplate(apSqlSessionFactoryBean2(), ExecutorType.BATCH);
    }

    @Bean
    public SqlSession batchSqlSession1() throws Exception {
        return new SqlSessionTemplate(apSqlSessionFactoryBean(), ExecutorType.BATCH);
    }

}
