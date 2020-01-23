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
	    return loginuser;
	}
	
	
	


}
