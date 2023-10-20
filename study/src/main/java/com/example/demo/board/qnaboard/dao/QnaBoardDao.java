package com.example.demo.board.qnaboard.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.board.vo.PageVo;

@Repository
public class QnaBoardDao {
	
	@Autowired
    private SqlSession apSqlSession;

    public List<HashMap<String, Object>> getQnaList(PageVo pvo) {
        return apSqlSession.selectList("QnaBoardMapper.getQnaList", pvo);
    }

    public int countPost(String searchValue) {
        return apSqlSession.selectOne("QnaBoardMapper.countPost", searchValue);
    }

    public int write(HashMap<String, Object> data) {
        return apSqlSession.insert("QnaBoardMapper.write", data);
    }

    public HashMap<String, Object> getDetail(String seq) {
        return apSqlSession.selectOne("QnaBoardMapper.getDetail", seq);
    }

    public int delete(String seq) {
        return apSqlSession.delete("QnaBoardMapper.delete", seq);
    }

    public int edit(HashMap<String, Object> data) {
        return apSqlSession.update("QnaBoardMapper.edit", data);
    }

    public int writeAnswer(HashMap<String, Object> data) {
        int result = apSqlSession.insert("QnaBoardMapper.writeAnswer", data);
        return result;
    }

    //원글의 부모번호 업데이트
    public void updateParentNo(HashMap<String, Object> data) {
        apSqlSession.update("QnaBoardMapper.updateParentNo", data);
    }

    //답글 순서 업데이트
    public void updateChildNo(HashMap<String, Object> data) {
        apSqlSession.update("QnaBoardMapper.updateChildNo", data);
    }

    public int writeReply(HashMap<String, Object> data) {
        return apSqlSession.insert("QnaBoardMapper.writeReply", data);
    }

    public List<HashMap<String, Object>> getReplyList(HashMap<String, Object> data) {
        return apSqlSession.selectList("QnaBoardMapper.getReplyList", data);
    }

    public int deleteReply(HashMap<String, Object> data) {
        return apSqlSession.delete("QnaBoardMapper.deleteReply", data);
    }

}
