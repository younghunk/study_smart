package com.example.demo.board.qnaboard.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.qnaboard.dao.QnaBoardDao;
import com.example.demo.board.vo.PageVo;

@Service
public class QnaBoardService {
	
	@Autowired
    QnaBoardDao dao;

    public ModelAndView getBoardList(ModelAndView mv, PageVo pvo) {
        List<HashMap<String, Object>> dataList = dao.getQnaList(pvo);
        mv.addObject("dataList", dataList);
        mv.addObject("pvo", pvo);
        return mv;
    }

    public int countPost (String searchValue) {
        return dao.countPost(searchValue);
    }

    public void write(HashMap<String, Object> data,Model model) {
        int result = dao.write(data);

        System.out.println(result);
        System.out.println(data.get("SEQ"));

        if(result == 1){
            model.addAttribute("result","success");

            //selectkey로 받은 SEQ 값을 PARENT_NO에 세팅
            dao.updateParentNo(data);
        }
    }

    public ModelAndView getDetail(String seq, ModelAndView mv, HashMap<String, Object> data) {
        data = dao.getDetail(seq);

        System.out.println("Detail res" + data);

        if(data != null) {
            mv.addObject("data", data);
        }
        return mv;
    }

    public int delete(String seq) {
        return dao.delete(seq);
    }

    public ModelAndView edit(HashMap<String, Object> data, ModelAndView mv) {
        int result = dao.edit(data);
        if (result == 1) {
            mv.addObject("data", data);
        }

        return mv;
    }

    public ModelAndView writeAnswer(HashMap<String, Object> data, ModelAndView mv) {
        dao.updateChildNo(data);
        int result = dao.writeAnswer(data);
        if (result == 1) {
            mv.addObject("result", "success");
        }
        return mv;
    }

    public ModelAndView writeReply(HashMap<String, Object> data, ModelAndView mv) {
        int result = dao.writeReply(data);
        if (result == 1) {
            mv.addObject("result", "success");
        }
        else {
            mv.addObject("error", "error");
        }

        return mv;
    }

    public ModelAndView getReplyList(HashMap<String, Object> data, ModelAndView mv) {
        List<HashMap<String, Object>> replyList = dao.getReplyList(data);
        mv.addObject("replyList", replyList);
        System.out.println("replyList : " + replyList);
        return mv;
    }

    public ModelAndView deleteReply(HashMap<String, Object> data, ModelAndView mv) {
        int result = dao.deleteReply(data);
        if (result == 1) {
            mv.addObject("result", "success");
        }
        return mv;
    }
}
