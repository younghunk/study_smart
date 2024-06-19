package com.example.demo.board.heojueun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.heojueun.service.JEService;
import com.example.demo.board.heojueun.vo.JEBoardVo;
import com.example.demo.board.jinyoung.vo.JYBoardVO;

@Controller
@RequestMapping("/heojueun")
public class JEController {
	
	private JEService jeService;
	
	public JEController(JEService jeService) {
		this.jeService = jeService;
	}
	
	
	@RequestMapping("list")
	public String title() {
		return "board/heojueun/je_list.tiles-study";
	}
	
	@GetMapping(value = "/getList.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<JEBoardVo> getList(HttpServletRequest request) {
		System.out.println("AAAAAAAAAAAAAAAAAAA");
	    Map<String, String> map = new HashMap<>();
	    return jeService.boardList(map);
	}

}
