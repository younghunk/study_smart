package com.example.demo.board.jinyoung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.jinyoung.service.JYBoardService;
import com.example.demo.board.jinyoung.vo.JYBoardVO;



@Controller
public class JYBoardController {

	
	@Autowired // Bean 주입
	private JYBoardService service;
	
	// 그리드테스트 페이지
	@GetMapping("grid.test")
	public ModelAndView grid(ModelAndView mav) {
		
		mav.setViewName("board/jinyoung/gridTest");
		
		return mav;
	}
	
	// 메인페이지 요청
	@GetMapping("list.action")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("board/jinyoung/list");
		
		return mav;
		
	}
	
	// Grid에 전달할 글목록 ajax
	@GetMapping(value = "/searchList.action", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ModelAndView searchList(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		// 게시판 검색시
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<JYBoardVO>boardList = service.boardList(paraMap);

		mav.addObject("rows", boardList);
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	// 글 1개를 조회한다.
	@GetMapping("view.action")
	public ModelAndView getMethodName(ModelAndView mav, HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		JYBoardVO boardvo = service.getView(seq);
		
		mav.addObject("boardvo", boardvo);
		mav.setViewName("board/jinyoung/view");
		
		return mav;
	}
	
	// 글쓰기 페이지 요청
	@GetMapping("add.action")
	public ModelAndView add(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("board/jinyoung/add");
		
		return mav;
		
	}
	
	// 글쓰기 요청 완료
	@PostMapping("addEnd.action")
	public ModelAndView addEnd(ModelAndView mav, HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		int n = service.addEnd(paraMap);
		
		if (n == 0) {
			mav.addObject("msg", "글쓰기에 실패했습니다.");
			mav.addObject("loc", "/add.action");
		}
		else {
			mav.addObject("msg", "글쓰기에 성공했습니다.");
			mav.addObject("loc", "/list.action");
		}
		
		mav.setViewName("board/jinyoung/msg");
		return mav;
		
	}
	
	// 글삭제 요청 완료
	@PostMapping("del.action")
	public ModelAndView del(ModelAndView mav, HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		int n = service.del(seq);
		
		if (n == 0) {
			mav.addObject("msg", "글삭제에 실패했습니다.");
			mav.addObject("loc", "/view.action?seq="+seq);
		}
		else {
			mav.addObject("msg", "글삭제에 성공했습니다.");
			mav.addObject("loc", "/list.action");
		}
		
		mav.setViewName("board/jinyoung/msg");
		return mav;
		
	}
	
	// 글수정 페이지 요청
	@GetMapping("edit.action")
	public ModelAndView edit(ModelAndView mav, HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		JYBoardVO boardvo = service.getView(seq);
		
		mav.addObject("boardvo", boardvo);
		mav.setViewName("board/jinyoung/edit");
		
		return mav;
		
	}
	
	// 글수정 요청 완료
	@PostMapping("editEnd.action")
	public ModelAndView editEnd(ModelAndView mav, HttpServletRequest request) {
		
		Map<String, String> paraMap = new HashMap<>();
		
		String seq = request.getParameter("seq");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		paraMap.put("seq", seq);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		int n = service.editEnd(paraMap);
		
		if (n == 0) {
			mav.addObject("msg", "글수정에 실패했습니다.");
			mav.addObject("loc", "/view.action?seq="+seq);
		}
		else {
			mav.addObject("msg", "글수정에 성공했습니다.");
			mav.addObject("loc", "/view.action?seq="+seq);
		}
		
		mav.setViewName("board/jinyoung/msg");
		return mav;
		
	}
	
	
	// jqGrid 데이터 업데이트 처리
	@PostMapping("subjectChange.action")
	@ResponseBody
	public String subjectChange(@RequestParam("subject") String subject,
	                       		@RequestParam("seq") String seq) {
		// jsp에서 subject 컬럼의 값만 보내주기 때문에 seq 값도 같이 보내줘서 받는다
        System.out.println("수정된 셀 컬럼 이름: " + subject);
        System.out.println("수정할 셀의 seq 값: " + seq);

        Map<String, String> paraMap = new HashMap<>();
        
        paraMap.put("subject", subject);
        paraMap.put("seq", seq);
        
        int n = service.subjectChange(paraMap);
        
        if (n==1) {
        	return "success";
        }
        else {
        	return "";
        }
	}
	
	
	
}


