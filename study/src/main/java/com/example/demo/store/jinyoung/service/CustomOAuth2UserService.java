package com.example.demo.store.jinyoung.service;


import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.demo.store.jinyoung.dto.CustomOAuth2User;
import com.example.demo.store.jinyoung.dto.GoogleResponse;
import com.example.demo.store.jinyoung.dto.NaverResponse;
import com.example.demo.store.jinyoung.dto.OAuth2Response;
import com.example.demo.store.jinyoung.entity.UserEntity;
import com.example.demo.store.jinyoung.repository.UserRepository;


@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	private final UserRepository userRepository;
	
	// UserRepository를 주입받는 생성자
	public CustomOAuth2UserService(UserRepository userRepository) {

		this.userRepository = userRepository;
	}
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
		System.out.println(oAuth2User);
		
		// OAuth2UserRequest로부터 클라이언트 등록 ID 가져오기
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		OAuth2Response oAuth2Response = null;
		
		// 클라이언트 등록 ID에 따라 사용자 정보 가져오는 방법 설정
		if(registrationId.equals("naver")) {
			
			oAuth2Response = new NaverResponse(oAuth2User.getAttributes());
			
		}
		else if (registrationId.equals("google")) {
			
			oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
		}
		else {
			
			return null;
		}
		
		// 사용자 식별을 위한 username 생성
		String username = oAuth2Response.getProvider()+" "+oAuth2Response.getProviderId();
		
		// username을 이용하여 DB에서 사용자 정보 조회
		UserEntity existData = userRepository.findByUsername(username);
		
		String role = "ROLE_USER";
		if (existData == null) { // DB에 해당 사용자 정보가 없는 경우 새로운 UserEntity 생성하여 저장
			
            UserEntity userEntity = new UserEntity();
            
            userEntity.setUsername(username);
            userEntity.setEmail(oAuth2Response.getEmail());
            userEntity.setRole(role);

            userRepository.save(userEntity);
        }
        else { // DB에 해당 사용자 정보가 있는 경우 정보 업데이트

            existData.setUsername(username);
            existData.setEmail(oAuth2Response.getEmail());

            role = existData.getRole();

            userRepository.save(existData);
        }
		
		// 사용자 정보와 역할(role)을 이용하여 CustomOAuth2User 객체 생성하여 반환
        return new CustomOAuth2User(oAuth2Response, role);
		
	}
	
}
