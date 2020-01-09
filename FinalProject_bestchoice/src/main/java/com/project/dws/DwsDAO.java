package com.project.dws;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DwsDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	
	
}
