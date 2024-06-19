package com.example.demo.board.heojueun.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.demo.board.heojueun.vo.JEBoardVo;
import com.example.demo.board.jinyoung.vo.JYBoardVO;


@Repository
public class JEBoardDao {
	
	@Autowired
	@Qualifier("orgSqlSession")
	private SqlSessionTemplate JEsqlSession;
	
	// 전체 List 가져오기
	public List<JEBoardVo> boardList (Map<String, String> map) {
		return JEsqlSession.selectList("heojueun.boardList", map);
	}
	
}
