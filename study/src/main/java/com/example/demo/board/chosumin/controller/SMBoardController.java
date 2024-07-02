package com.example.demo.board.chosumin.controller;
import com.example.demo.board.chosumin.vo.SMBoardVO;
import com.example.demo.board.chosumin.service.SMBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

@Controller
@RequestMapping("/chosumin")
public class SMBoardController {

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
        List<SMBoardVO> boardList = smBoardService.selectBoardAll();
        return boardList;
    }

    //글작성 페이지
    @RequestMapping("/SMWrite")
    public ModelAndView SMWrite(ModelAndView mv) throws Exception{
        mv.setViewName("/board/chosumin/chosumin_write");
        return mv;
    }

    //글작성 + 글수정 + 글삭제 동시적용
    @PostMapping("/updateBoardList")
    @ResponseBody
    public String updateBoardList(@RequestBody List<SMBoardVO> boardvo){
        String result = smBoardService.updateBoardList(boardvo);
        return result;
    }

    //글작성
    @PostMapping("/insertBoard")
    @ResponseBody
    public ModelAndView insertBoard(SMBoardVO boardvo, ModelAndView mv){
        if(boardvo.getDate() == null){
            boardvo.setDate(null);
        }
        int result = smBoardService.insertBoard(boardvo);
        if(result == 1){
            mv.addObject("result","등록되었습니다.");
        }else{
            mv.addObject("result","처리 중 문제가 발생했습니다..");
        }
        return mv;
    }

    //글수정
    @PostMapping("/updateBoard")
    @ResponseBody
    public String updateBoard(SMBoardVO boardvo, ModelAndView mv){
        boardvo.setSubject(boardvo.getSubject());
        int result = smBoardService.updateBoard(boardvo);
        if (result == 1) {
            return "수정되었습니다.";
        }
        else {
            return "처리 중 문제가 발생했습니다.";
        }
    }

    //글삭제
    @PostMapping("/deleteBoard")
    @ResponseBody
    public String deleteBoard(int seq){
        int result = smBoardService.deleteBoard(seq);
        if (result == 1) {
            return "삭제되었습니다.";
        }
        else {
            return "처리 중 문제가 발생했습니다.";
        }
    }

    //답글작성 페이지
    @GetMapping("/replyBoard")
    public ModelAndView replyBoard(ModelAndView mv,@RequestParam("seq") int seq) throws Exception{
        SMBoardVO boardVO = smBoardService.selectBoard(seq);
        boardVO.setDepthno(boardVO.getDepthno()+1);
        boardVO.setFk_seq(boardVO.getGroupno());
        mv.addObject("boardVO",boardVO);
        mv.setViewName("/board/chosumin/chosumin_reply");
        return mv;
    }

    //답글작성
    @PostMapping("/insertReply")
    @ResponseBody
    public ModelAndView insertReply(SMBoardVO boardvo, ModelAndView mv){
        int result = smBoardService.insertReply(boardvo);
        mv.setViewName("redirect:/chosumin/SMBoard");
        if(result == 1){
            mv.addObject("result","등록되었습니다.");
        }else{
            mv.addObject("result","처리 중 문제가 발생했습니다..");
        }
        return mv;
    }
}
