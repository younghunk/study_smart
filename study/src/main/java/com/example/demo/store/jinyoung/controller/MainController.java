package com.example.demo.store.jinyoung.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@GetMapping("/")
	public String mainAPI() {	
		return "/store/jinyoung/main";
		
	}
	
}
