package com.project.smh;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.common.AES256;




@Service
public class SmhService {	
	@Resource
	private SmhDAO dao ;
	
	
	// 회원가입
	public int memberInsert(SmhMemberVO smhmbrvo) {		
		int n = dao.memberInsert(smhmbrvo);
		return n;		
	}
	
	// 회원가입
	public int memberInsertForKakao(SmhMemberVO smhmbrvo) {		
		int n = dao.memberInsertForKakao(smhmbrvo);
		return n;		
	}
	
	
	
	// 카카오로그인유처리 
		public SmhMemberVO getKakaoLoginMember(HashMap<String, String> paraMap) {
			
			SmhMemberVO kakaologinuser = dao.getKakaoLoginMember(paraMap);
		if(kakaologinuser != null) {			
			if(kakaologinuser.getPwdchangegap() > 6) {
				// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지났으면 true 로 변경한다.
				kakaologinuser.setRequirePwdChange(true);					
			}	
				
				// 마지막 로그인날짜 업데이트 
				dao.setLastLoginDate(paraMap); 
				kakaologinuser.setEmail(kakaologinuser.getEmail());
			
		  }	
		 return kakaologinuser;
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
	
	// 회원가입시 user의 idx알아오기 
	public String selectmemberidx(String useremail) {
		String memberidx = dao.selectmemberidx(useremail);
		 return memberidx;
	}

	// 회원가입시 포인트 1000점 업데이트 
	public int memberPointInsert(String memberIdx, int memberPoint) {
		int n = dao.memberPointInsert(memberIdx, memberPoint);

		return n;
	}
	// 회원정보 불러오기 
	public SmhMemberVO getUserinfo(HashMap<String, String> paraMap) {
	
		SmhMemberVO userinfo = dao.getUserinfo(paraMap);
		return userinfo;
	}
	// 회원정보 업데이트 
	public int InfoUpdate(SmhMemberVO smhvo) {
		int n =  dao.InfoUpdate(smhvo);
		return n;
	}
	//  인증메일을 보내기전에 유저의 아이디가 있는지 확인
	public String isUserExist(String email) {
		String userExist =  dao.isUserExist(email);
		return userExist;
	}

	// 회원탈퇴 
	@Transactional(rollbackFor={Throwable.class})  
	public int add_transaction(SmhMemberVO smhvo) {
		
		int n = dao.pointDelete(smhvo);
		int m = dao.memberUpdate(smhvo.getMember_idx());
		System.out.println("smhvovovooovov"+smhvo);
		System.out.println("idxidxidx"+smhvo.getMember_idx());
		return (n+m);
		
	}

	// 임시발송된 비밀번호 DB에 업데이트 
	public int pwdUpdate(HashMap<String, String> paraMap) {
		int m = dao.pwdUpdate(paraMap);
		return m;
	}
	// 유저의 포인트 가져오기 
	public String getUserPoint(HashMap<String, String> paraMap) {		
		 String point =dao.getUserPoint(paraMap);
		 return point;
	}
	
	// 유저의 쿠폰가져오기 
		public  List<HashMap<String, String>> couponList(HashMap<String, String> paraMap) {
		   List<HashMap<String, String>> couponList = dao.couponList(paraMap);
			return couponList;
		}

		// 유저 예약내역조회 
		public List<HashMap<String, String>> reservationList(HashMap<String, String> paraMap) {
			List<HashMap<String, String>> reservationList = dao.reservationList(paraMap);
			return reservationList;
		}

		




	
	
	


}
