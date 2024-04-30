package com.example.demo.board.jinyoung.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.board.jinyoung.dao.JYBoardDAO;
import com.example.demo.board.jinyoung.vo.JYBoardVO;


@Service
public class JYBoardService {

	@Autowired // Bean 주입
	private JYBoardDAO dao;
	
	// 전체 게시글 목록
	public List<JYBoardVO> boardList(Map<String, String> paraMap) {
		
		List<JYBoardVO> boardList = dao.boardList(paraMap);
		
		return boardList;
	}

	// 글 1개를 조회
	public JYBoardVO getView(String seq) {
		
		JYBoardVO boardvo = dao.getView(seq);
		
		// 조회수 증가
		int n = dao.increase_readCount(seq);
		
		if(n == 1) {
			boardvo.setReadCount(boardvo.getReadCount()+1);
		}
		
		return boardvo;
	}
	
	// 답글쓰기 요청 완료
	public int addEnd(JYBoardVO boardvo) {
		
		int n = dao.addEnd(boardvo);
		
		return n;
	}

	// 글삭제 요청 완료
	public int del(String seq) {
		
		int n = dao.del(seq);
		
		return n;
	}

	// 글수정 요청 완료
	public int editEnd(Map<String, String> paraMap) {

		int n = dao.editEnd(paraMap);
		
		return n;
	}

	// 제목 수정
	public int subjectChange(Map<String, String> paraMap) {

		int n = dao.subjectChange(paraMap);
		
		return n;
	}

	// 그리드에서 새 게시물 생성
	public int createNewPost(Map<String, Object> paraMap, Model model) {

		int n = dao.createNewPost(paraMap);
		
		try {
			if(n==1) {
				model.addAttribute("status", "success");
			}
		} catch (Exception e) {
			model.addAttribute("status", "error");
			model.addAttribute("cause", e.getCause());
		}
		
		return n;
		
	}

	// 그리드에서 게시물 수정
	public int updatePost(Map<String, String> paraMap, Model model) {

		int n = dao.updatePost(paraMap);
		
		try {
			if(n==1) {
				model.addAttribute("status", "success");
			}
		} catch (Exception e) {
			model.addAttribute("status", "error");
			model.addAttribute("cause", e.getCause());
		}
		
		return n;
		
	}

	// 그리드에서 게시물 삭제
	public int deletePost(String seq, Model model) {
		
		int n = dao.deletePost(seq);
		
		try {
			if(n==1) {
				model.addAttribute("status", "success");
			}
		} catch (Exception e) {
			model.addAttribute("status", "error");
			model.addAttribute("cause", e.getCause());
		}
		
		return n;
		
	}

	// 테이블에서 groupno 컬럼의 최대값 알아오기
	public int getGroupnoMax() {
		
		int maxgrouno = dao.getGroupnoMax();
		
		return maxgrouno;
	}

}
