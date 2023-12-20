package com.example.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;


@Controller
public class DumpController {
    Logger logger = LoggerFactory.getLogger(DumpController.class);

    @Autowired
    DumpService dumpService;

    //글읽기
    @RequestMapping ("/dump")
    public ModelAndView selectBoardList(@RequestParam HashMap<String, Object> data) throws Exception{
        ModelAndView mv = new ModelAndView("board_select"); //jsp 파일을 가리킴
        dumpService.dump();
        return mv;
    }
}

