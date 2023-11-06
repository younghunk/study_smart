package com.example.demo.board.freeboard.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.SimpleTimeZone;

@Repository
public class BoardDao {

    Logger logger = LoggerFactory.getLogger(BoardDao.class);

    private static final String BoardMapper = "FreeBoardMapper";

    @Autowired
    private SqlSession apSqlSession;

    public List<HashMap<String, Object>> selectBoardList(HashMap<String, Object> data){
        return apSqlSession.selectList(BoardMapper+".selectBoardList",data); //쿼리호출
    }
    public Integer saveBoard(HashMap<String, Object> data) throws Exception{
        return apSqlSession.insert(BoardMapper+".saveBoard",data );
    }

    public HashMap<String, Object> selectBoardDetail(int id){
        HashMap<String, Object> data = new HashMap<>();
        data.put("id", id);
        return apSqlSession.selectOne(BoardMapper+".selectBoardDetail",data); //상세보기
    }

    public Integer updateBoard(HashMap<String, Object> data){
        return apSqlSession.update(BoardMapper+".updateBoard",data ); //업데이트
    }

    public Integer delteBoard(HashMap<String, Object> data){
        return apSqlSession.delete(BoardMapper+".deleteBoard", data); //삭제
    }

    //기존 비밀번호 가져오기
    public String getPwd (String id) {
        return apSqlSession.selectOne(BoardMapper+".getPwd", id);
    }

    //조회수 증가
    public void upHitCnt(int id) throws Exception{
        apSqlSession.update(BoardMapper+".upHitCnt", id);
    }

    //전체 행 개수 가져오기
    public int getTotalPage(){
        return apSqlSession.selectOne(BoardMapper+".getTotalPage");
    }

    //게시글 답글 순서 정보 업데이트
    public int updateStep(HashMap<String, Object> data){
        return apSqlSession.update(BoardMapper+".updateStep", data);
    }

    //게시글 답글 정보 조회
    public HashMap<String, Object> getBoardReInfo(int id){
        HashMap<String, Object> data = new HashMap<>();
        data.put("id", id);
        return apSqlSession.selectOne(BoardMapper+".getBoardReInfo",data);
    }

    //게시물 답글 작성
    public Integer saveReBoard(HashMap<String, Object> data) throws Exception{
        return apSqlSession.insert(BoardMapper+".saveReBoard",data );
    }

    public int updateRef(HashMap<String, Object> data){
        return apSqlSession.update(BoardMapper+".updateRef", data);
    }

    public int refDepthCount(HashMap<String, Object> data){
        return apSqlSession.selectOne(BoardMapper+".refDepthCount", data);
    }

    public void updateReplyStep(HashMap<String, Object> data){
        apSqlSession.update(BoardMapper+".updateReplyStep", data);
    }

    //댓글저장
    public Integer commentBoard(HashMap<String, Object> data){
        return apSqlSession.insert(BoardMapper+".commentBoard", data);
    }

    //댓글출력
    public List<HashMap<String, Object>> selectComment(int board_id){
        HashMap<String, Object> data = new HashMap<>();
        data.put("board_id", board_id);
        return apSqlSession.selectList(BoardMapper+".selectComment",data);
        //댓글 호출
    }

    public Integer deleteCom(HashMap<String, Object> data){
        return apSqlSession.delete(BoardMapper+".deleteCom", data); //삭제
    }

    public Integer saveNoticeBoard(HashMap<String, Object> data) throws Exception{
//        HashMap<String, Object> id = data.get("id");
        System.out.println("공지사항 글쓰기"+data.get("id"));
        return apSqlSession.insert(BoardMapper+".saveNoticeBard", data );
    }
}
