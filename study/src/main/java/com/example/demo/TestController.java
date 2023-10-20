package com.example.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController { 
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	TestDao dao;
	
	@GetMapping("/index")
    public ModelAndView getList(@RequestParam HashMap<String,Object> data) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Map<String, Object>> list= dao.selectList(data);
        //System.out.println(">>11>data:"+list);
        logger.debug(">>>>>>>>>11>>>>>>:"+list);
        mv.setViewName("/index.blank");
        return mv;
    }
}
