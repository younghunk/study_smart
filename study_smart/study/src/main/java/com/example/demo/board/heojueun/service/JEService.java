package com.example.demo.board.heojueun.service;

import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.board.heojueun.dao.JEBoardDao;
import com.example.demo.board.heojueun.vo.JEBoardVo;

@Service
public class JEService {
	

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private JEBoardDao jeBoardDao;
	
	public JEService(JEBoardDao jeBoardDao) 
	{
		this.jeBoardDao = jeBoardDao;
	}
	
	
	// 게시글 리스트 불러오기
	public List<JEBoardVo> boardList(Map<String, String> map) {
		try {
			return jeBoardDao.boardList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 새글쓰기
	public int newPost(Map<String, Object> map) {
		try {
			return jeBoardDao.newPost(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 업데이트
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int updatePost(List<JEBoardVo> list) throws Exception {
		int count = 0;
		for(JEBoardVo jeBoardVo : list) {
			if(jeBoardVo.getDate() == null || jeBoardVo.getDate().equals("")) 
			    jeBoardVo.setDate(null);

			/* 
			 if(seq != null)
			 	update
			 else
			 	insert
			 */
			//int return 타입을 사용해서 업데이트가 완료됐을 때 카운트가 증가되야 하기 때문에 넣어줌
			count += jeBoardDao.updatePost(jeBoardVo);
		}
		return count;
    }
}
























