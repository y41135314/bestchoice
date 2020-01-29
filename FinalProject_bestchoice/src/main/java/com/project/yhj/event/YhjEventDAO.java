package com.project.yhj.event;


import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class YhjEventDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 이벤트 insert 하기
	public int insertEvent(HashMap<String, String> paraMap) {

		int n = sqlsession.insert("yhjMapper.insertEvent", paraMap);
		return n;
	}

	// 이벤트 이미지 insert 하기
	public int insertEventImage(HashMap<String, String> imageMap) {

		int n = sqlsession.insert("yhjMapper.insertEventImage", imageMap);
		return n;
	}

	// insert한 event_code 알아오기
	public int getEventCode(HashMap<String, String> paraMap) {

		int event_code = sqlsession.selectOne("yhjMapper.getEventCode", paraMap);
		return event_code;
	}

	// 이벤트 전체 갯수 가져오기
	public int getEventTotalCount() {

		int totalcount = sqlsession.selectOne("yhjMapper.getEventTotalCount");
		return totalcount;
	}

	// 이벤트 목록 가져오기
	public List<HashMap<String, String>> getEventList(HashMap<String, String> paraMap) {

		List<HashMap<String, String>> eventList = sqlsession.selectList("yhjMapper.getEventList", paraMap);
		return eventList;
	}

	// 이벤트 하나 가져오기
	public HashMap<String, String> getOneEvent(String event_code) {

		HashMap<String, String> eventMap = sqlsession.selectOne("yhjMapper.getOneEvent",event_code );
		return eventMap;
	}

	// 이벤트 이미지 가져오기
	public List<HashMap<String, String>> getOneEventImg(String event_code) {

		List<HashMap<String, String>> eventImgMap = sqlsession.selectList("yhjMapper.getOneEventImg", event_code);
		return eventImgMap;
	}

	// 이벤트 수정하기
	public int reviseEvent(HashMap<String, String> paraMap) {

		int result = sqlsession.update("yhjMapper.reviseEvent", paraMap);
		return result;
	}

	// 이벤트 이미지들 status 0 으로 바꾸기
	public int deleteEventImg(String event_code) {

		int result = sqlsession.update("yhjMapper.deleteEventImg", event_code);
		return result;
	}

	// 이벤트를 삭제하기
	public int deleteEvent(String event_code) {

		int n = sqlsession.update("yhjMapper.deleteEvent",event_code);
		return n;
	}

	// 이벤트 가져오기 ( 이전글, 다음글 포함 )
	public HashMap<String, String> getOneEventWithLagLead(String event_code) {

		HashMap<String,String> eventMap = sqlsession.selectOne("yhjMapper.getOneEventWithLagLead", event_code);
		return eventMap;
	}

	// 사용자 계정에 쿠폰이 있는지 확인
	public int checkCoupon(HashMap<String, String> paraMap) {

		int n = sqlsession.selectOne("yhjMapper.checkCoupon",paraMap);
		return n;
	}

	// 쿠폰 insert 하기
	public int giveCoupon(HashMap<String, String> paraMap) {
		
		int n = sqlsession.insert("yhjMapper.giveCoupon", paraMap);
		return n;
	}
	
	// 생성한 쿠폰 번호 가져오기
	public String getCouponCode() {
		
		String coupon_code = sqlsession.selectOne("yhjMapper.getCouponCode");
		return coupon_code;
	}

	// 개인 쿠폰함에 insert 하기
	public int giveCouponToUser(HashMap<String, String> paraMap) {

		int result = sqlsession.insert("yhjMapper.giveCouponToUser", paraMap);
		return result;
	}

	// 쿠폰 상태 사용함으로 바꾸기
	public int useCoupon(HashMap<String, String> paraMap) {

		int result = sqlsession.update("yhjMapper.useCoupon", paraMap);
		return result;
	}

	// 사용한 쿠폰 적립금에 넣기
	public int useCouponForPoint(HashMap<String, String> paraMap) {

		int result = sqlsession.update("yhjMapper.useCouponForPoint",paraMap);
		return result;
	}

	// 매일 밤 12시마다 이벤트 체크해서 날짜가 지난 이벤트는 status 를 2( 종료 ) 로 바꾸기
	public void updateEventStatus() {

		sqlsession.update("yhjMapper.updateEventStatus");
	}


	
	
	
}
