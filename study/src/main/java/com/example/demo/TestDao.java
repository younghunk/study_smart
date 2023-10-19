package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<Map<String, Object>> selectList(Map<String, Object> map) throws Exception {
        return sqlSession.selectList("test.selectList", map);
    }
}
