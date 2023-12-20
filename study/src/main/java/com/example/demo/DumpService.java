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
        	int page=0;
        	int cnt=1;
        	for(int i =0 ; i < 13; i++) {
        		page = i * 300;
	            List<HashMap<String, Object>> items = dumpDao.alpha2select(page);	            
	            if(items != null && items.size() > 0) {
		            for (HashMap<String, Object> item : items) {
		                System.out.println("인서트:"+cnt++);
		                dumpDao.alpha1insert(item);
		            }
	            }
        	}
        } catch (Exception e) {
            logger.error("Exception during test", e);
        }
    }
}


