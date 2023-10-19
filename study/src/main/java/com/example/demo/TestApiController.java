package com.example.demo;

import java.util.HashMap;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TestApiController {
	@GetMapping("/rest")
    public HashMap<String,Object> rest() {
		HashMap<String,Object> data = new HashMap<>();
		data.put("1", 1);
		data.put("a", "a");
        return data;
    }
}
