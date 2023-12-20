package com.example.demo;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class DumpDao {

    Logger logger = LoggerFactory.getLogger(DumpDao.class);

    private static final String DumpMapper = "DumpMapper";

    @Autowired
    @Qualifier(value = "ap2SqlSession")
    private SqlSession ap2SqlSession;

    @Autowired
    @Qualifier(value = "batchSqlSession")
    private SqlSession batchSqlSession;

    public List<HashMap<String, Object>> alpha2select(int page) {
        return ap2SqlSession.selectList(DumpMapper+".alpha2select",page);
    }

    public void alpha1insert(HashMap<String, Object> item) {
        batchSqlSession.insert(DumpMapper+".alpha1insert", item);
    }
}
