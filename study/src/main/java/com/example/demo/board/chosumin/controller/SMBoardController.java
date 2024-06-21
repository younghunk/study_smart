package com.example.demo.board.chosumin.controller;

import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.vo.SMBoardVO;
import com.example.demo.board.chosumin.service.SMBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.logging.Logger;

@Controller
@RequestMapping("/chosumin")
public class SMBoardController {

    Logger logger = Logger.getLogger(SMBoardDAO.class.getName());

    @Autowired
    SMBoardService smBoardService;

    //게시판 페이지
    @RequestMapping("/SMBoard")
    public ModelAndView selectSMBoardList(ModelAndView mv) throws Exception{
         mv.setViewName("/board/chosumin/chosumin_list.tiles-study");
        return mv;
    }

    //게시판 전체글 조회
    @GetMapping("/getSMBoard")
    @ResponseBody
    public List<SMBoardVO> getSMBoard(){
        List<SMBoardVO> boardList = smBoardService.getBoardList();
        return boardList;
    }

    //글작성 페이지
    @RequestMapping("/SMWrite")
    public ModelAndView create(ModelAndView mv) throws Exception{
        mv.setViewName("/board/chosumin/chosumin_write");
        return mv;
    }

    //글작성
    @PostMapping("/write.action")
    @ResponseBody
    public ModelAndView write(SMBoardVO boardvo, ModelAndView mv){
        int result = smBoardService.addBoard(boardvo);
        mv.setViewName("redirect:/chosumin/SMBoard");
        if(result == 1){
            mv.addObject("result","등록되었습니다.");
        }else{
            mv.addObject("result","처리 중 문제가 발생했습니다..");
        }
        return mv;
    }

    //글수정
    @PostMapping("/edit.action")
    @ResponseBody
    public String edit(SMBoardVO boardvo, ModelAndView mv){
        int result = smBoardService.editBoard(boardvo);
        if (result == 1) {
            return "수정되었습니다.";
        }
        else {
            return "처리 중 문제가 발생했습니다.";
        }
    }

    //답글작성 페이지
    @GetMapping("/SMReply")
    public ModelAndView reply(ModelAndView mv,@RequestParam("seq") int seq) throws Exception{
        SMBoardVO boardVO = smBoardService.getBoard(seq);
        boardVO.setDepthno(boardVO.getDepthno()+1);
        boardVO.setFk_seq(boardVO.getSeq());
        mv.addObject("boardVO",boardVO);
        mv.setViewName("/board/chosumin/chosumin_reply");
        return mv;
    }

    //답글작성
    @PostMapping("/reply.action")
    @ResponseBody
    public ModelAndView reply(SMBoardVO boardvo, ModelAndView mv){
        int result = smBoardService.addReply(boardvo);
        mv.setViewName("redirect:/chosumin/SMBoard");
        if(result == 1){
            mv.addObject("result","등록되었습니다.");
        }else{
            mv.addObject("result","처리 중 문제가 발생했습니다..");
        }
        return mv;
    }
}
