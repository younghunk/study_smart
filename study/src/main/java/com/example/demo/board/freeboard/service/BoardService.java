package com.example.demo.board.freeboard.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.freeboard.dao.BoardDao;
import com.example.demo.util.Util;

@Service
public class BoardService {
    Logger logger = LoggerFactory.getLogger(BoardService.class);

    @Autowired
    BoardDao boardDao;

    public ModelAndView selectBoardList(ModelAndView mv, HashMap<String, Object> data) throws Exception{
        int perRow = 10;
        int perBlock =3;
        int nowPage=1;
        if (data.get("nowPage") != null){
            nowPage = Integer.parseInt(data.get("nowPage")+"");
        }

        //전체 행 갯수 가져오기
        int allCount = boardDao.getTotalPage();

        Util.makePageData(perRow,perBlock,nowPage,mv,data,allCount);

        List<HashMap<String, Object>> res = boardDao.selectBoardList(data);
        logger.debug("selectBoardList: {}", data);
        mv.addObject("result","success");
        mv.addObject("list", res);
        mv.addObject("data", data);
        //데이터값
        return mv;
    }

    public ModelAndView saveBoard(ModelAndView mv, HashMap<String, Object> data) throws Exception{
        //테이블에 저장하기

        int saveResult = boardDao.saveBoard(data);
        boardDao.updateRef(data);
        logger.debug("saveBoard: {}", data.toString());
        if (saveResult != 1) {
            mv.addObject("result", "save_error");}
        else
        {
            mv.addObject("result", "success");}
        return mv;
    }

    // 상제정보출력
    public HashMap<String, Object> selectBoardDetail(int id) throws Exception {
        // 게시물 ID를 사용하여 상세 정보를 가져옵니다.
        HashMap<String, Object> res = boardDao.selectBoardDetail(id);
        logger.debug("selectBoardDetail: {}", id);

        boardDao.upHitCnt(id);
        // 데이터와 결과를 반환합니다.
        return res;
    }

    //게시글 업데이트
    public ModelAndView updateBoard(ModelAndView mv, HashMap<String, Object> data){

        int updateResult = boardDao.updateBoard(data);
        logger.debug("updateBoard: {}", data.toString());

        if (updateResult != 1) {
            mv.addObject("update", "수정실패");}
        else
        {
            mv.addObject("update", "수정성공");}
        return mv;

    }

    public ModelAndView deleteBoard(ModelAndView mv, HashMap<String, Object> data){
        int delete = boardDao.delteBoard(data);
        if(delete == 1 ){
            mv.addObject("result", "success");
        }else {
            mv.addObject("result", "error");
        }
        return mv;
    }

    public ModelAndView passwordCheck(ModelAndView mv, HashMap<String, Object> data){
        // 게시물 ID를 사용하여 패스워드 가져옴
        String id = data.get("id").toString();
        String pw = boardDao.getPwd(id);

        //현재 유저가 입력한 비밀번호
        String userPwd = data.get("password").toString();

        if(!pw.equals(userPwd)){ //비밀번호가 틀리다면
            mv.addObject("result","error");
        }
        else{
            mv.addObject("result", "success");
            mv.addObject("id", id);
        }
        return mv;
    }

    //게시글 답글 저장
    public ModelAndView saveReBoard(ModelAndView mv, HashMap<String, Object> data) throws Exception{
        int saveResult = 0;

        //답글 저장 및 순서 업데이트

//        saveResult += boardDao.saveReBoard(data);
//        saveResult+=boardDao.updateStep(data);

        int step = 0;
        int root = 0;
        int depth = 0;

        int ref = Integer.parseInt(data.get("id")+"");
        depth = Integer.parseInt(data.get("depth")+"")+1;
        step = Integer.parseInt(data.get("step")+"")+1;

        data.put("depth", depth);
        data.put("ref", ref);

        int extraStep = boardDao.refDepthCount(data);
        step = step+extraStep; //마지막 스텝
        data.put("step",step);
        boardDao.saveReBoard(data);

        logger.debug("saveBoard: {}", data);
        if (saveResult > 0) {
            mv.addObject("result", "success");}
        else
        {
            mv.addObject("result", "error");}
        return mv;
    }

//    댓글 작성 저장
    public ModelAndView commentBoard(ModelAndView mv, HashMap<String, Object> data) throws Exception{

        int saveResult = boardDao.commentBoard(data);

        logger.debug("commentBoard: {}", data.toString());
        if (saveResult != 1) {
            mv.addObject("result", "comment_error");}
        else
        {
            mv.addObject("result", "success");}
        return mv;
    }

    public List<HashMap<String, Object>> selectComment(int board_id) throws Exception {
        List<HashMap<String, Object>> comment = boardDao.selectComment(board_id);
        logger.debug("selectBoardList: {}", board_id);
        //데이터값
        return comment;
    }

    public ModelAndView deleteCom(ModelAndView mv, HashMap<String, Object> data){
        int delete = boardDao.deleteCom(data);
        if(delete == 1 ){
            mv.addObject("result", "success");
        }else {
            mv.addObject("result", "error");
        }
        return mv;
    }

    // 공지사항 저장
    public ModelAndView saveNoticeBoard(ModelAndView mv, HashMap<String, Object> data) throws Exception{
        //테이블에 저장하기
        int saveResult = boardDao.saveNoticeBoard(data);
        boardDao.updateRef(data);
        logger.debug("saveNoticeBoard: {}", data.toString());
        if (saveResult != 1) {
            mv.addObject("result", "save_error");}
        else
        {
            mv.addObject("result", "success");}
        return mv;
    }
}


