package com.example.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class DumpService {
    Logger logger = LoggerFactory.getLogger(DumpService.class);

    @Autowired
    DumpDao dumpDao;

    public void dump() {
        try {
            List<HashMap<String, Object>> items = dumpDao.alpha2select();
            for (HashMap<String, Object> item : items) {
                //logger.error("인서트: {}", String.valueOf(item));
//                Blob mf = (Blob)item.get("image_blob");
//                item.put("image_blob", mf);
//                logger.error(">>mf>>>size:{}", mf);
                dumpDao.alpha1insert(item);
            }
        } catch (Exception e) {
            logger.error("Exception during test", e);
        }
    }
}


