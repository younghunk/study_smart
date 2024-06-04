
package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;




@Configuration
@EnableMethodSecurity
public class SpringSecurityConfig {
	


     
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	http.httpBasic().disable()
    	.csrf().disable()
    	.cors().and()
    	.authorizeHttpRequests()
    	.antMatchers("/index","/static","*/board/**", "/", "/oauth2/**", "/login/**").permitAll();
    
    	
        return http.build();
    }
}
