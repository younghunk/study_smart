package com.example.demo.board.jinyoung.controller;

import java.util.*;

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

import com.example.demo.board.jinyoung.service.JYBoardService;
import com.example.demo.board.jinyoung.vo.JYBoardVO;
import org.springframework.web.bind.annotation.RequestMethod;




@Controller
@RequestMapping("/jinyoung")
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
	@RequestMapping("list.action")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("board/jinyoung/list.tiles-study");
		
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
	
	// 답글쓰기 요청 완료
	@PostMapping("addEnd.action")
	@ResponseBody
	public String addEnd(JYBoardVO boardvo) {
		
		int n = service.addEnd(boardvo);
		
		if (n == 1) {
			return "success";
		}
		else {
			return "false";
		}
		
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
	
	
	// 그리드에서 새 게시물 생성
	@PostMapping("createNewPost.action")
	@ResponseBody
	public String createNewPost(HttpServletRequest request, Model model) {

		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String date = request.getParameter("date");
		String userid = request.getParameter("userid");
		
		if(date == "") {
			date = null;
		}
		
		int groupno = service.getGroupnoMax()+1;
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("date", date);
		paraMap.put("userid", userid);
		paraMap.put("groupno", groupno);
		
		try {
			int n = service.createNewPost(paraMap, model);
			if (n == 1) {
				return "jsonView";
			}
			else {
				return "오류발생 insert 실패";
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 내용을 콘솔에 출력
			return "오류발생 insert 실패";
		}
	}
	
	
	// 그리드에서 새 게시물 생성
	@PostMapping("updatePost.action")
	@ResponseBody
	public String updatePost(HttpServletRequest request, Model model) {

		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String date = request.getParameter("date");
		String userid = request.getParameter("userid");
		String seq = request.getParameter("seq");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("date", date);
		paraMap.put("userid", userid);
		paraMap.put("seq", seq);
		
		try {
			int n = service.updatePost(paraMap, model);
			if (n == 1) {
				return "jsonView";
			}
			else {
				return "오류발생 update 실패";
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 내용을 콘솔에 출력
			return "오류발생 update 실패";
		}
		
	}
		
	
	// 그리드에서 게시물 삭제
	@PostMapping("deletePost.action")
	@ResponseBody
	public String deletePost(HttpServletRequest request, Model model) {

		String seq = request.getParameter("seq");
		
		try {
			int n = service.deletePost(seq, model);
			if (n == 1) {
				return "jsonView";
			}
			else {
				return "오류발생 delete 실패";
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 내용을 콘솔에 출력
			return "오류발생 delete 실패";
		}
		
	}	
	
	
	@RequestMapping("reply.action")
	public ModelAndView reply(ModelAndView mav, HttpServletRequest request) {
		
		String subject = "답변_" + request.getParameter("subject");
		String groupno = request.getParameter("groupno");
		String fk_seq = request.getParameter("fk_seq");
		String depthno = request.getParameter("depthno");
		
		if(fk_seq == null) {
			fk_seq = "";
		}
		
		mav.addObject("subject", subject);
		mav.addObject("groupno", groupno);
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("depthno", depthno);
		
		mav.setViewName("board/jinyoung/reply");
		
		return mav;
		
	}
	
	
	
}


