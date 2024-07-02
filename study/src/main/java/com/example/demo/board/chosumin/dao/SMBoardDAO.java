package com.example.demo.board.chosumin.dao;

import com.example.demo.board.chosumin.vo.SMBoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class SMBoardDAO {

    @Autowired
    @Qualifier("orgSqlSession")
    private SqlSession SMsqlsession;

    // 전체 게시글 조회
    public List<SMBoardVO> selectBoardAll(){
        List<SMBoardVO> boardList = SMsqlsession.selectList("Sumin.selectBoardAll");
        return boardList;
    }

    // 게시글 작성
    public int insertBoard(SMBoardVO boardvo){
        int result = SMsqlsession.insert("Sumin.insertBoard", boardvo);
        return result;
    }

    // 게시글 조회
    public SMBoardVO selectBoard(int seq){
        SMBoardVO boardList = SMsqlsession.selectOne("Sumin.selectBoard", seq);
        return boardList;
    }

    // 게시글 수정
    public int updateBoard(SMBoardVO boardvo){
        int result = SMsqlsession.update("Sumin.updateBoard", boardvo);
        return result;
    }

    // 답변 작성
    public int insertReply(SMBoardVO boardvo){
        int result = SMsqlsession.insert("Sumin.insertReply", boardvo);
        return result;
    }

    // 게시글 삭제
    public int deleteBoard(int seq){
        int result = SMsqlsession.update("Sumin.deleteBoard", seq);
        return result;
    }
}
