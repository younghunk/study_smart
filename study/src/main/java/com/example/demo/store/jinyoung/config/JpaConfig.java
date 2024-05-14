package com.example.demo.store.jinyoung.config;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class JpaConfig {

	@Bean
	public EntityManagerFactory entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.store.jinyoung.entity"); // 엔티티 패키지 설정
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter()); // JPA 벤더 어댑터 설정
        entityManagerFactoryBean.afterPropertiesSet(); // 속성 설정 완료
        return entityManagerFactoryBean.getObject(); // EntityManagerFactory 반환
    }
	
	@Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
        dataSource.setUrl("jdbc:log4jdbc:mariadb://10.10.10.224:23306/Board");
        dataSource.setUsername("root");
        dataSource.setPassword("Smart1q2w3e$R");
        return dataSource;
    }
	
}
