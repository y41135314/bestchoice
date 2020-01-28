package com.project.smh;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.mail.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.common.AES256;




@Service
public class SmhService {	
	@Resource
	private SmhDAO dao ;
	
	
	// 회원가입
	public void memberInsert(SmhMemberVO smhmbrvo) {		
		dao.memberInsert(smhmbrvo);		
	}
	
	// 로그인유처리 
	public SmhMemberVO getLoginMember(HashMap<String, String> paraMap) {
		
		SmhMemberVO loginuser = dao.getLoginMember(paraMap);
	if(loginuser != null) {			
		if(loginuser.getPwdchangegap() > 6) {
			// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지났으면 true 로 변경한다.
			loginuser.setRequirePwdChange(true);					
		}	
			
			// 마지막 로그인날짜 업데이트 
			dao.setLastLoginDate(paraMap); 
			loginuser.setEmail(loginuser.getEmail());
		
	  }	
	 return loginuser;
	}
	
	// 이메일(id)중복검사
	public int userEmailCheck(String email) {
		
		int n = dao.userEmailCheck(email);

		return n ;
	}

	/*//  인증메일을 보내기전에 유저의 아이디가 있는지 확인 
	public boolean isUserExist(HashMap<String, String> paraMap) {
		boolean bool =   dao.isUserExist(paraMap);
		return bool;
	}*/


	
	
	


}
