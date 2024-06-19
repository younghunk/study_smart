package com.example.demo.board.heojueun.service;

import java.util.*;

import org.springframework.stereotype.Service;

import com.example.demo.board.heojueun.dao.JEBoardDao;
import com.example.demo.board.heojueun.vo.JEBoardVo;

@Service
public class JEService {
	
	private JEBoardDao jeBoardDao;
	
	public JEService(JEBoardDao jeBoardDao) 
	{
		this.jeBoardDao = jeBoardDao;
	}
	
	
	// 게시글 리스트 불러오기
	public List<JEBoardVo> boardList(Map<String, String> map) {
		return jeBoardDao.boardList(map);
	}
}
