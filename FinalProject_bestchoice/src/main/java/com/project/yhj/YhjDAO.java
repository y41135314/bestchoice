package com.project.yhj;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class YhjDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	public String getDate() {

		String date = sqlsession.selectOne("yhjMapper.getDate");
		return date;
	}

	
	
	
}
