package com.example.demo.board.chosumin.controller;

import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.dto.SMBoardDTO;
import com.example.demo.board.chosumin.service.SMBoardService;
import com.nimbusds.oauth2.sdk.ErrorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
public class SMBoardController {

    Logger logger = Logger.getLogger(SMBoardDAO.class.getName());

    @Autowired
    SMBoardService smBoardService;

    //게시판 전체 조회
    @RequestMapping("/SMBoard")
    public ModelAndView selectSMBoardList(ModelAndView mv) throws Exception{
         mv.setViewName("/board/chosumin/chosumin_list");

        return mv;
    }

    @GetMapping("/getSMBoard")
    @ResponseBody
    public ResponseEntity getSMBoard(){

        List<SMBoardDTO> boardList = smBoardService.getBoardList();

        if(boardList == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("not found");
        }else{
            return ResponseEntity.status(HttpStatus.OK)
                    .body(boardList);
        }
    }
}
