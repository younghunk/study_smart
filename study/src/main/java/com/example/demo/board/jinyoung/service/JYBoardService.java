package com.example.demo.board.jinyoung.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
			boardvo.setReadCount(String.valueOf(Integer.parseInt(boardvo.getReadCount())+1));
		}
		
		return boardvo;
	}
	
	// 글쓰기 요청 완료
	public int addEnd(Map<String, String> paraMap) {

		int n = dao.addEnd(paraMap);
		
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
	
}
