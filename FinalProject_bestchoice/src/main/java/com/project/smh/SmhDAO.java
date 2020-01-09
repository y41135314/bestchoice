package com.project.smh;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SmhDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;


	
	
}
