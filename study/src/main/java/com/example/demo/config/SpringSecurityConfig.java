
package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.example.demo.store.jinyoung.service.CustomOAuth2UserService;


@Configuration
@EnableMethodSecurity
public class SpringSecurityConfig {
	
	private final CustomOAuth2UserService customOAuth2UserService;

	public SpringSecurityConfig(CustomOAuth2UserService customOAuth2UserService) {

		this.customOAuth2UserService = customOAuth2UserService;
	}

     
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	http.httpBasic().disable()
    	.csrf().disable()
    	.cors().and()
    	.authorizeHttpRequests()
    	.antMatchers("/index","/static","*/board/**", "/", "/oauth2/**", "/login/**").permitAll()
    	.and()
    	.oauth2Login()
    	 .userInfoEndpoint()
         .userService(customOAuth2UserService);
    	
        return http.build();
    }
}
