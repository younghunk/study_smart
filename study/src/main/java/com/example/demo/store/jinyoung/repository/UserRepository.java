package com.example.demo.store.jinyoung.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.store.jinyoung.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

	UserEntity findByUsername(String username);
	
}
