package com.example.demo;

import java.util.HashMap;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import com.example.demo.dto.Greeting;
import com.example.demo.dto.HelloMessage;

@Controller
public class GreetingController {


	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public Greeting greeting(HelloMessage message) throws Exception {
		Thread.sleep(500); // simulated delay
		System.out.println(">>>>>>>message:"+message.getName());
		return new Greeting("Hello, " + HtmlUtils.htmlEscape(message.getName()) + "!");
	}
	
	@GetMapping("/websocket")
	public String websocket(@RequestParam HashMap<String,Object> param) {
		
		return "/websocket/index";
	}
	@GetMapping("/websocket2")
	public String websocket2(@RequestParam HashMap<String,Object> param) {
		
		return "/websocket/index2";
	}
}
