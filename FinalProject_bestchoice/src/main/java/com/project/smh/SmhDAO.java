package com.project.smh;

import java.util.HashMap;
import java.util.List;

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
	
	// 카카오 회원가입 
	public int memberInsertForKakao(SmhMemberVO smhvo) {
		
		int n = sqlsession.insert("smhMapper.memberInsertForKakao", smhvo);
		
		return n;		
	}
	
	



	// 로그인처리
	public SmhMemberVO getLoginMember(HashMap<String, String> paraMap) {

		SmhMemberVO loginuser = sqlsession.selectOne("smhMapper.getLoginMember", paraMap);
		return loginuser;
	}
	
	public SmhMemberVO getKakaoLoginMember(HashMap<String, String> paraMap) {
		SmhMemberVO kakaologinuser = sqlsession.selectOne("smhMapper.getKakaoLoginMember", paraMap);
		return kakaologinuser;
	}
	
	// 마지막으로 로그인 한 날짜시간 변경(기록)하기
	public void setLastLoginDate(HashMap<String, String> paraMap) {
	
		sqlsession.update("smhMapper.setLastLoginDate", paraMap);
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
	// 회원 1명의 정보 불러오기 
	public SmhMemberVO getUserinfo(HashMap<String, String> paraMap) {
		SmhMemberVO userinfo = sqlsession.selectOne("smhMapper.getUserinfo", paraMap);
		return userinfo;
	}
	// 회원의 정보 업데이트 하기 
	public int InfoUpdate(SmhMemberVO smhvo){
		
		int n = sqlsession.update("smhMapper.InfoUpdate", smhvo);
		return n;
	}
	
	//  인증메일을 보내기전에 유저의 아이디가 있는지 확인 
	public String isUserExist(String email) {
		String userExist = sqlsession.selectOne("smhMapper.isUserExist", email);
		return userExist;
	}

	// 회원포인트 삭제 
	public int pointDelete(SmhMemberVO smhvo) {
		int m = sqlsession.delete("smhMapper.pointDelete", smhvo);
		return m;
	}
	

	public int memberUpdate(int member_idx) {
		int n = sqlsession.update("smhMapper.memberUpdate", member_idx);
		return n;
	}

	// 임시발송된 비밀번호 DB에 업데이트 
	public int pwdUpdate(HashMap<String, String> paraMap) {
		int m = sqlsession.update("smhMapper.pwdUpdate", paraMap);
		return m;
	}
	// 로그인 유저 포인트 가져오기 
	public int getUserPoint(int memberidx) {
		int n = sqlsession.selectOne("smhMapper.getUserPoint",memberidx );
		return n;
		
	}

	public String getUserPoint(HashMap<String, String> paraMap) {
		String point = sqlsession.selectOne("smhMapper.getUserPoint",paraMap );
		 return point;
		
	}
	
	// 유저의 쿠폰가져오기 
	public  List<HashMap<String, String>> couponList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> couponList = sqlsession.selectList("smhMapper.getUserCoupon",paraMap);
		return couponList;
	}

	public List<HashMap<String, String>> reservationList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reservationList = sqlsession.selectList("smhMapper.reservationList",paraMap);
		
		return reservationList;
	}

	





	


	
	
}
