package com.project.smh;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


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
	
	// 마지막으로 로그인 한 날짜시간 변경(기록)하기
	public void setLastLoginDate(HashMap<String, String> paraMap) {
	
		sqlsession.update("smhMapper.setLastLoginDate", paraMap);
	}

	//  인증메일을 보내기전에 유저의 아이디가 있는지 확인 
	public boolean isUserExist(HashMap<String, String> paraMap) {
		boolean bool = sqlsession.selectOne("smhMapper.isUserExist", paraMap);
		return bool;
	}

	public int userEmailCheck(String email) {
		int n = sqlsession.selectOne("smhMapper.userEmailCheck", email);
		return n;
	}

	
	
}
