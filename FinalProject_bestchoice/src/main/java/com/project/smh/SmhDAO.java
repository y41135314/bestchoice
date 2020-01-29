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
	public int memberInsert(SmhMemberVO smhvo) {
		
		int n = sqlsession.insert("smhMapper.memberInsert", smhvo);
		
		return n;		
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
	// 회원가입 이메일 중복체크 
	public int userEmailCheck(String email) {
		int n = sqlsession.selectOne("smhMapper.userEmailCheck", email);
		return n;
	}

	// 회원가입시 userd의 회원번호 알아오기 
	public String selectmemberidx(String useremail) {
		String memberidx = sqlsession.selectOne("smhMapper.selectmemberidx", useremail);
		return memberidx;
	}

	// 회원가입시 포인트 1000점  insert
	public int memberPointInsert(String memberIdx, int memberPoint) {
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
	      paraMap.put("memberIdx", memberIdx);
	      paraMap.put("memberPoint", memberPoint);
	      
	      int n = sqlsession.insert("smhMapper.memberPointInsert", paraMap);
	      return n ;

	}

	
	
}
