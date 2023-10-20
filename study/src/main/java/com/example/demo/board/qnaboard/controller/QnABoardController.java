package com.example.demo.board.qnaboard.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.qnaboard.service.QnaBoardService;
import com.example.demo.board.vo.PageVo;

@Controller
public class QnABoardController {

	@Autowired
	QnaBoardService service;

	// 글 목록 화면
	@GetMapping("/qnaboard/list")
	public ModelAndView getQnaList(@RequestParam(defaultValue = "1") String p, String searchValue) {
		ModelAndView mv = new ModelAndView("/qnaboard/list");
//        mv.setViewName("/qnaboard/list");

		int page = Integer.parseInt(p);
		int postCount = service.countPost(searchValue);

		PageVo pvo = new PageVo(page, 10, 5, postCount);
		pvo.setSearchValue(searchValue);

		service.getBoardList(mv, pvo);

		return mv;
	}

	// 글쓰기 화면
	@GetMapping("/qnaboard/write")
	public String writeView() {
		return "qnaboard/write";
	}

	// 글작성
	@PostMapping("/qnaboard/write")
	public String write(@RequestParam HashMap<String, Object> data, Model model) {
//		ModelAndView mv = new ModelAndView("/qnaboard/write");

		System.out.println("write");

		service.write(data, model);
		return "jsonView";
	}

	// 상세 화면
	@GetMapping("/qnaboard/detail")
	public ModelAndView getDetail(@RequestParam String seq) {
		ModelAndView mv = new ModelAndView("qnaboard/detail");

		System.out.println("getDetail String seq : " + seq);

		HashMap<String, Object> data = new HashMap<>();
		service.getDetail(seq, mv, data);
		return mv;
	}

	// 삭제
	@PostMapping("/qnaboard/delete")
	public String delete(String seq) {
		System.out.println("delete");
		int result = service.delete(seq);
		return "redirect:/qnaboard/list";
	}

	// 수정
	@PostMapping("/qnaboard/edit")
	public ModelAndView edit(@RequestParam HashMap<String, Object> data) {
		ModelAndView mv = new ModelAndView("qnaboard/detail");
		service.edit(data, mv);
		return mv;
	}

	// 답글
	@PostMapping("/qnaboard/answer")
	public ModelAndView writeAnswer(@RequestParam HashMap<String, Object> data) {
		ModelAndView mv = new ModelAndView("qnaboard/list");
		service.writeAnswer(data, mv);
		return mv;
	}

	// 댓글
	@PostMapping("/qnaboard/reply/write")
	public ModelAndView writeReply(@RequestParam HashMap<String, Object> data) {
		ModelAndView mv = new ModelAndView("qnaboard/detail");
		service.writeReply(data, mv);
		return mv;
	}

	@PostMapping("/freeboard/reply/list")
	public ModelAndView getReplyList(@RequestParam HashMap<String, Object> data) {
//        ModelAndView mv = new ModelAndView("qnaboard/detail");
		ModelAndView mv = new ModelAndView("jsonView");
		service.getReplyList(data, mv);
		return mv;
	}

	@PostMapping("/qnaboard/reply/delete")
	public ModelAndView deleteReply(@RequestParam HashMap<String, Object> data) {
		ModelAndView mv = new ModelAndView("jsonView");
		service.deleteReply(data, mv);
		return mv;
	}

}
