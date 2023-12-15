package com.example.demo.service;

import com.example.demo.DAO.BoardDao;
import com.example.demo.util.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Service;

import org.springframework.ui.Model;
import org.springframework.util.xml.XmlValidationModeDetector;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Blob;
import java.util.HashMap;
import java.util.List;

@Service
public class BoardService {
    Logger logger = LoggerFactory.getLogger(BoardService.class);

    @Autowired
    BoardDao boardDao;

    public void test() {
        try {
            List<HashMap<String, Object>> items = boardDao.alpha2select();
            logger.error("셀렉트: {}", items);
            logger.error("test2:{}", boardDao.test2().toString());
            for (HashMap<String, Object> item : items) {
                //logger.error("인서트: {}", String.valueOf(item));
//                Blob mf = (Blob)item.get("image_blob");
//                item.put("image_blob", mf);
//                logger.error(">>mf>>>size:{}", mf);
                boardDao.alpha1insert(item);
            }
        } catch (Exception e) {
            logger.error("Exception during test", e);
        }
    }
}


