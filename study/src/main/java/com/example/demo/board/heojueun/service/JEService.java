package com.example.demo.board.heojueun.service;

import java.util.*;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.board.heojueun.dao.JEBoardDao;
import com.example.demo.board.heojueun.vo.JEBoardVo;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

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
			return jeBoardDao.insertPost(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 게시글 수정
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int updatePost(Map<String, Object> map) throws Exception {
		int count = 0;
		ObjectMapper objectMapper = new ObjectMapper();
		List<JEBoardVo> list = objectMapper.readValue(map.get("board").toString(), new TypeReference<List<JEBoardVo>>() {});
        JEBoardVo jeBoardVo = null;
		System.out.println(list.toString());
        
		if(list != null && list.size() > 0)
		{
			for(int i = 0; i < list.size(); i++)
			{
				jeBoardVo = objectMapper.convertValue(list.get(i), JEBoardVo.class);
				if (jeBoardVo.getSeq() != null && jeBoardVo.getSeq().length() > 0) 
					count += jeBoardDao.updatePost(jeBoardVo);
				else 
					count += jeBoardDao.gridInsertPost(jeBoardVo);
			}
		}
		
		if(map.get("delArr") != null && ((List<Long>) map.get("delArr")).size() > 0)
		{
			for(String seq : (List<String>) map.get("delArr"))
			{
				count += jeBoardDao.deleteBoard(new JEBoardVo(seq));
			}
		}
		
//		for(JEBoardVo jeBoardVo : list) {
//			if(jeBoardVo.getDate() == null || jeBoardVo.getDate().equals("")) 
//			    jeBoardVo.setDate(null);
//			
//			if (jeBoardVo.getSeq() != null && jeBoardVo.getSeq() > 0) {
//				count += jeBoardDao.updatePost(jeBoardVo);
//			} else {
//				count += jeBoardDao.gridInsertPost(jeBoardVo);
//			}
//			//int return 타입을 사용해서 업데이트가 완료됐을 때 카운트가 증가되야 하기 때문에 넣어줌
//			count += jeBoardDao.updatePost(jeBoardVo);
//		}
		return count;
    }
	
	// 답글쓰기
	public int newComment(JEBoardVo jeBoardVo) {
		try {
			return jeBoardDao.insertComment(jeBoardVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 게시물 삭제
	public int deletePost(List<JEBoardVo> list) throws Exception {
        int count = 0;
        for (JEBoardVo jeBoardVo : list) {
            count += jeBoardDao.deleteBoard(jeBoardVo);
        }
        return count;
    }
	
	// 테이블에서 groupno 컬럼의 최대값 알아오기
	public int getGroupnoMax() {
		
		int maxgrouno = jeBoardDao.getGroupnoMax();
		
		return maxgrouno;
	}
}
























