package com.example.demo.util;

import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

public class Util {

     public static void makePageData(int perRow, int perBlock, int nowPage, ModelAndView mv, HashMap<String,Object> data,int allCount ){
        int startRow = ((nowPage-1) * perRow );
        data.put("startRow",startRow);
        data.put("perRow",perRow);


        int totalPage = (allCount / perRow) +(allCount%perRow==0?0:1);
        int startPage = (((nowPage-1)/3) *3)+1;
        int endPage = (((nowPage+2)/3) *3);
        if(endPage >totalPage){
            endPage = totalPage;
        }
        mv.addObject("startPage", startPage);
        mv.addObject("endPage", endPage);
        mv.addObject("totalPage",totalPage);
        mv.addObject("perBlock",perBlock);
        mv.addObject("nowPage",nowPage);
    }
}
