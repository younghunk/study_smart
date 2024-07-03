package com.example.demo.board.heojueun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public JEController(JEService jeService) {
		this.jeService = jeService;
	}
	
	
	@RequestMapping ("list")
	public String title() {
		return "board/heojueun/je_list.tiles-study";
	}
	
	// 게시판 리스트 불러오기
	@PostMapping (value = "/getList.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<JEBoardVo> getList(HttpServletRequest request) {
	    Map<String, String> map = new HashMap<String, String>();
	    logger.debug("게시판 리스트 불러오기");
	    return jeService.boardList(map);
	}
	
	// 새글쓰기
	@PostMapping (value = "/newPost.do")
	public ModelAndView newPost(HttpServletRequest request) {
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String date = request.getParameter("date") == "" ? null : request.getParameter("date");
		
		int groupno = jeService.getGroupnoMax()+1;
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("subject", subject);
		map.put("content", content);
		map.put("date", date);
		map.put("groupno", groupno);
		
		try {
			jeService.newPost(map);
			return new ModelAndView("redirect:/heojueun/list");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error", "message", "An error occurred while processing your request.");
		}
	}
	
	
	// 새글쓰기 페이지 이동
	@GetMapping("/newPostPage.do")
	public String newPostPage(HttpServletRequest request) {
		return "board/heojueun/je_newPost.tiles-study";
	}
	
	
	// 게시판 수정하기
	@PostMapping("/updatePost.do")
	public ResponseEntity<Object> updatePost(@RequestBody Map<String, Object> map) {
		try {
		  if (jeService.updatePost(map) > 0) 
			  return new ResponseEntity<Object>(200, HttpStatus.OK); 
		  else 
			  return new ResponseEntity<Object>(500, HttpStatus.OK);
		} 
		catch (Exception e) {
			e.printStackTrace();
			logger.debug(e.toString());
			return new ResponseEntity<Object>(500, HttpStatus.OK);
		}
	} 
	
	// 답글쓰기
	@PostMapping("/newComment.do")
	public ResponseEntity<Object> newComent(@RequestBody JEBoardVo jeBoardVo) {
		try {
			if (jeService.newComment(jeBoardVo) > 0) {
				return new ResponseEntity<Object>(200, HttpStatus.OK);
			}else {
				return new ResponseEntity<Object>(500, HttpStatus.OK);
			}
		} catch (Exception e) {
			logger.debug(e.toString());
			return new ResponseEntity<Object>(500, HttpStatus.OK);
		}
	}
	
	// 답글쓰기 페이지 이동
	@GetMapping("/newCommentPage.do")
	public ModelAndView newComentPage(ModelAndView mav, HttpServletRequest request) {
	    String subject = "답변_" + request.getParameter("subject");
	    String groupno = request.getParameter("groupno");
	    String fk_seq = request.getParameter("fk_seq");
	    String depthno = request.getParameter("depthno");

	    mav.addObject("subject", subject);
	    mav.addObject("groupno", groupno);
	    mav.addObject("fk_seq", fk_seq);
	    mav.addObject("depthno", depthno);
	    
	    mav.setViewName("board/heojueun/je_reply");
	    
	    return mav;
	}

	// 게시글 삭제
	@PostMapping("/deletePost.do")
	public ResponseEntity<Object> deletePost(@RequestBody List<JEBoardVo> jeBoardVo) {
	    try {
	    	for (JEBoardVo vo : jeBoardVo) {
                System.out.println("Received Data: " + vo.getContent());
            }
	        int result = jeService.deletePost(jeBoardVo);
	        if (result > 0) {
	        	System.out.println("Delete Result: " + result);
	            return new ResponseEntity<>(HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("No posts deleted", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } catch (Exception e) {
	        logger.error("Error deleting post", e);
	        return new ResponseEntity<>("Internal Server Error", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	
}
