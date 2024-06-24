package com.example.demo.board.heojueun.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.demo.board.heojueun.vo.JEBoardVo;


@Repository
public class JEBoardDao {
	
	@Autowired
	@Qualifier("orgSqlSession")
	private SqlSessionTemplate JEsqlSession;
	
	// 전체 List 가져오기
	public List<JEBoardVo> boardList (Map<String, String> map) {
		return JEsqlSession.selectList("heojueun.boardList", map);
	}
	
	// 글쓰기
	public int newPost(Map<String, Object> map) {
		return JEsqlSession.insert("heojueun.boardInsert", map);
	}
	
	// 게시글 수정하기
	public int updatePost(JEBoardVo jeBoardVo) {
		return JEsqlSession.update("heojueun.boardUpdate", jeBoardVo);
	}
	
	// 답글쓰기
	public int newComment(JEBoardVo jeBoardVo) {
		return JEsqlSession.insert("heojueun.newComment", jeBoardVo);
	}
	
	// 테이블에서 groupno 컬럼의 최대값 알아오기
		public int getGroupnoMax() {
			int maxgrouno = JEsqlSession.selectOne("heojueun.getGroupnoMax");
			return maxgrouno;
		}
}
