package com.example.demo.board.freeboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.freeboard.service.BoardService;


@Controller
@RequestMapping("/board")
public class FreeBoardController {
    Logger logger = LoggerFactory.getLogger(FreeBoardController.class);

    @Autowired
    BoardService boardService;

    //글읽기
    @RequestMapping ("/freeboard/select")
    public ModelAndView selectBoardList(@RequestParam HashMap<String, Object> data) throws Exception{
        logger.debug("/board/select {}", data);
        ModelAndView mv = new ModelAndView("/board/freeboard/board_select"); //jsp 파일을 가리킴
        boardService.selectBoardList(mv, data);
        System.out.println("보드셀렉"+mv);
        return mv;
    }

    //게시글 작성
    @GetMapping ("/freeboard/write")
    public ModelAndView saveBoardForm(@RequestParam HashMap<String, Object> data) throws Exception {
        logger.debug("/board/write {} " , data);
        ModelAndView mv = new ModelAndView("/board/freeboard/board_write");
        System.out.println("보드에 작성"+mv);
        return mv;
    }

    //게시글 저장
    //GetMapping으로 들어오는 요청을 처리함
    @PostMapping ("/freeboard/write")
    public ModelAndView saveBoard(@RequestParam HashMap<String, Object> data) throws Exception {
        System.out.println("PostMapping saveboard controller " + data);
        ModelAndView mv = new ModelAndView("jsonView");

        String checkValue = (String) data.get("check");
        boolean check = Boolean.parseBoolean(checkValue);

        System.out.println("체크체크"+check);
        boardService.saveBoard(mv,data);
        System.out.println("데베에 저장"+ mv);
        mv.setViewName("redirect:/board/freeboard/select");
        //게시글 저장 후 select로 이동하기
        return mv;

    }

    //글 눌렀을 때 자세히 보기
    @GetMapping ("/freeboard/selectdetail")
    public ModelAndView selectBoardDetailForm(@RequestParam("id") int id, Model model, @RequestParam HashMap<String, Object> data) throws Exception {
        System.out.println("글번호 selectDetail" + id);
        ModelAndView mv = new ModelAndView("/board/freeboard/board_detail");


        // 게시물 ID를 사용하여 상세 정보와 댓글을 를 가져옵니다.
        HashMap<String, Object> boardDetail = boardService.selectBoardDetail(id);
        List<HashMap<String, Object>> commentList = boardService.selectComment(id);

        // Model에 상세 정보를 추가하여 뷰로 전달합니다.
        // "board" = jsp에 가서 쓸 데이터 이름
        model.addAttribute("board", boardDetail);
        model.addAttribute("comment", commentList);

        System.out.println("셀렉트디테일입니다"+ boardDetail);
        System.out.println("셀렉트디테일입니다"+ commentList);
        System.out.println("셀렉트디테일입니다"+ mv);
        // 상세 페이지의 JSP 파일명을 반환합니다.
        return mv; // 상세 정보를 보여줄 JSP 파일명
    }

    //댓글 저장
    @PostMapping("/freeboard/commentBoard")
    public ModelAndView commentBoard(@RequestParam HashMap<String, Object> data) throws Exception {
        System.out.println("커멘드보드"+ data);

        ModelAndView mv = new ModelAndView("jsonView");
        boardService.commentBoard(mv,data);
        System.out.println("commentBoard" + data);
        mv.setViewName("redirect:/board/freeboard/select"); //저장 후 목록페이지로 이동
        return mv;
    }

//    댓글 삭제
    @PostMapping("/freeboard/deleteCom")
    public ModelAndView deleteCom(@RequestParam HashMap<String, Object> data) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        boardService.deleteCom(mv, data);
        mv.setViewName("redirect:/board/freeboard/select"); // 삭제 후 목록페이지로 이동
        return mv;
    }

    //수정 게시물 받기
    @GetMapping("/freeboard/update")
    public ModelAndView updateBoardForm(@RequestParam("id") int id, Model model) throws Exception {
        //기존에 있는 내용 넣기
        System.out.println("글번호 update" + id);
        // 게시물 ID를 사용하여 상세 정보를 가져옵니다.
        HashMap<String, Object> board = boardService.selectBoardDetail(id);
        model.addAttribute("board", board);
        System.out.println("updateBoardForm" + board);
        //기존에 있는 내용 불러옴
        ModelAndView mv = new ModelAndView("/board/freeboard/board_update");
        return mv;
    }

    //수정 게시물 업데이트 처리하는 요청 처리
    @PostMapping("/freeboard/update")
    public ModelAndView updateBoard(@RequestParam HashMap<String, Object> data) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        boardService.updateBoard(mv,data);
        System.out.println("updateBoard" + data);
        mv.setViewName("redirect:/board/freeboard/select"); //수정 후 목록페이지로 이동
        return mv;
    }

    @PostMapping("/freeboard/delete")
    public ModelAndView deleteBoard(@RequestParam HashMap<String, Object> data) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        boardService.deleteBoard(mv, data);
        mv.setViewName("redirect:/board/freeboard/select"); // 삭제 후 목록페이지로 이동
        return mv;
    }

    //비밀번호 값 받기
    @GetMapping("/freeboard/check")
    public ModelAndView checkPwdForm(@RequestParam("id") int id, Model model) throws Exception {
        //기존에 있는 내용 넣기
        System.out.println("checkPwdForm" + id);
        HashMap<String, Object> board = boardService.selectBoardDetail(id);
        model.addAttribute("board", board);
        //기존에 있는 비밀번호 불러오기
        ModelAndView mv = new ModelAndView("/board/freeboard/board_check");
        return mv;
    }

    //비밀번호 기능 처리
    @PostMapping("/freeboard/check")
    public ModelAndView checkPwd(@RequestParam HashMap<String, Object> data){
        ModelAndView mv = new ModelAndView("jsonView");
        //비동기 작업을 수행하거나 동적으로 실행할때 사용

        boardService.passwordCheck(mv,data);
        Map<String,Object> resultData = mv.getModel();

        System.out.println("checkPwd" + resultData);
        String res = resultData.get("result").toString();
        System.out.println("checkPwd" + res);
        String url="/board/freeboard/update";

        //result가 error라면 리스트로 이동
        if(res.equals("error")){
            url= "/board/freeboard/select";
        }
        mv.setViewName("redirect:"+url); //비밀번호 확인 후 페이지로 이동
        return mv;
    }

    //답글 게시물 글 받기
    @GetMapping("/freeboard/reply")
    public ModelAndView saveReBoardForm(@RequestParam("id") int id, Model model) throws Exception {
        HashMap<String, Object> reid = boardService.selectBoardDetail(id);


        int depth = Integer.parseInt(reid.get("depth")+"")+1;
        String re = "";
        for (int i=0; i<depth;i++){
            String s = "Re:";
            re = re + s;
        }

        reid.put("re", re);
        System.out.println("ㄹㄹ번호"+reid);
        model.addAttribute("ref",reid);
        //ref는 jsp가서 사용해야 할 데이터

        ModelAndView mv = new ModelAndView("/board/freeboard/board_reply");
        System.out.println("답글 작성 컨트롤러 get" + mv);
        return mv;
    }

    //답글 게시물 업데이트 처리하는 요청 처리
    @PostMapping("/freeboard/reply")
    public ModelAndView saveReBoard(@RequestParam HashMap<String, Object> data) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        System.out.println("board/freeboard/reply" + data);
        boardService.saveReBoard(mv,data);
//        System.out.println("board/reply" + data);
        mv.setViewName("redirect:/board/freeboard/select"); //수정 후 해당페이지로 이동
        return mv;
    }

//    공지사항


}

