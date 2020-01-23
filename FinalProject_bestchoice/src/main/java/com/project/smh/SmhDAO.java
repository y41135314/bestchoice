package com.project.smh;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SmhDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 회원가입 
	public void memberInsert(SmhMemberVO smhvo) {
		

		sqlsession.insert("smhMapper.memberInsert", smhvo);
		
	}

	// 로그인처리
	public SmhMemberVO getLoginMember(HashMap<String, String> paraMap) {

		SmhMemberVO loginuser = sqlsession.selectOne("smhMapper.getLoginMember", paraMap);
		return loginuser;
	}


	
	
}
