package com.example.demo.board.chosumin.dao;

import com.example.demo.board.chosumin.dto.SMBoardDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
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
    public List<SMBoardDTO> getBoardList(){
        List<SMBoardDTO> boardList = SMsqlsession.selectList("Sumin.boardSelect");
        return boardList;
    }

}
