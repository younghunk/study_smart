package com.example.demo.board.chosumin.dao;

import com.example.demo.board.chosumin.vo.SMBoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.logging.Logger;

@Repository
public class SMBoardDAO {

    Logger logger = Logger.getLogger(SMBoardDAO.class.getName());

    @Autowired
    @Qualifier("orgSqlSession")
    private SqlSession SMsqlsession;

    // 전체 게시글 조회
    public List<SMBoardVO> getBoardList(){
        List<SMBoardVO> boardList = SMsqlsession.selectList("Sumin.boardSelectAll");
        return boardList;
    }

    // 게시글 작성
    public int addBoard(SMBoardVO boardvo){
        int result = SMsqlsession.insert("Sumin.boardInsert", boardvo);
        return result;
    }

    // 전체 게시글 조회
    public SMBoardVO getBoard(int seq){
        SMBoardVO boardList = SMsqlsession.selectOne("Sumin.boardSelect", seq);
        return boardList;
    }

    // 게시글 수정
    public int editBoard(SMBoardVO boardvo){
        int result = SMsqlsession.update("Sumin.boardUpdate", boardvo);
        return result;
    }

    // 답변 작성
    public int addReply(SMBoardVO boardvo){
        int result = SMsqlsession.insert("Sumin.replyInsert", boardvo);
        return result;
    }
}
