package com.example.demo.board.hyeonsik.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.demo.board.jinyoung.vo.JYBoardVO;

@Repository
public class PostDao {

	@Autowired
	@Qualifier("orgSqlSession")
	private SqlSessionTemplate sqlSqlsession;
	

	 public HashMap<String,Object> getPostById(Long id) {
		 return sqlSqlsession.selectOne("hyeonsik.getPostById", id);
	    }
	
	// 게시글 리스트 출력
	public List<HashMap<String,Object>> getAllPosts(Map<String, Object> data) {
        return sqlSqlsession.selectList("hyeonsik.getAllPosts", data);
    }
	
	// 게시글 등록
	 public void insertPost(HashMap<String, Object> data) {
		 sqlSqlsession.insert("hyeonsik.insertPost", data);
	}	
	 
	 // 게시글 업데이트
	 public void updatePost(HashMap<String, Object> data) {
		 sqlSqlsession.update("hyeonsik.updatePost", data);
	}
	 
	 // 게시글 삭제
	 public void deletePost(HashMap<String, Object> data) {
		 sqlSqlsession.delete("hyeonsik.deletePost", data);
	}
	
	 // 조회수 증가
	 public void viewUp(Long id) {
		 sqlSqlsession.update("hyeonsik.viewUp", id);
	}
	 
	 // 게시글에따른 댓글 조회
	 public List<HashMap<String,Object>> getCommentsByPostId(Long postId) {
	        return sqlSqlsession.selectList("hyeonsik.getCommentsByPostId", postId);
	    }
	 // 댓글 등록
	 public void insertComment(HashMap<String, Object> data) {
		 sqlSqlsession.insert("hyeonsik.insertComment", data);
	}	
	 
	 // 댓글 삭제
	 public void deleteComment(HashMap<String, Object> data) {
		 sqlSqlsession.delete("hyeonsik.deletePost",  data);
	}
	 
	 //답글 작성
	 public void insertPostReq(HashMap<String, Object> data) {
		 sqlSqlsession.insert("hyeonsik.insertPostReq", data);
	}	 
	 
	 //답글 우선순위
	 public void updatePostReq(HashMap<String, Object> data) {
		 sqlSqlsession.update("hyeonsik.updatePostReq", data);
	}
	 
    // 답글을 달기 위한 게시물 등록간 orginNo 번호를 id 값으로 넣는다
	 public void insert2Post(HashMap<String, Object> data) {
		 sqlSqlsession.update("hyeonsik.insert2Post", data);
	}
	 
	 
	 
	 
	 
	
}
