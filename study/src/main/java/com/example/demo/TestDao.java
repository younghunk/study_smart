package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class TestDao {
	
	@Qualifier(value = "ap1SqlSession")
	private SqlSession ap1SqlSession;
	@Qualifier(value = "batchSqlSession")
	private SqlSession batchSqlSession;
	@Qualifier(value = "ap2SqlSession")
	private SqlSession ap2SqlSession;
	
	
	public List<Map<String, Object>> selectList1(Map<String, Object> map) throws Exception {
        return ap2SqlSession.selectList("test.selectList1", map);
    }
}
