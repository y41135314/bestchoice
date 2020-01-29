package com.project.yhj.event;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class YhjEventService {

	@Resource
	private YhjEventDAO dao ;

	// 이벤트 작성/수정하기
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertOrReviseEvent(HashMap<String, String> paraMap, List<HashMap<String, String>> imageMapList) {

		int result = 0;
		String revise = paraMap.get("revise");
		
		if(revise == null || revise.isEmpty()) {	// 새로 이벤트 등록
			
			int n = dao.insertEvent(paraMap);
			
			if(n==1) {
				
				int event_code = dao.getEventCode(paraMap);		// 수정하기
				
				for(int i = 0; i<imageMapList.size(); i++) {
					
					HashMap<String,String> imageMap = imageMapList.get(i);
					
					if(i==0) {
						imageMap.put("main","1");
					}
					else {
						imageMap.put("main","0");
					}
					
					imageMap.put("fk_event_code", String.valueOf(event_code));
					result = dao.insertEventImage(imageMap);
					
				} // end of for ------------
			}
			
		}
		else {	// 이벤트 수정
			
			result = dao.reviseEvent(paraMap);
			
			if( result == 1 ) {
				
				if ( imageMapList != null && imageMapList.size() > 0) {
					
					String event_code = paraMap.get("event_code");
					
					// 기존의 이미지들을 모두 status =0 으로 바꾸기
					result = dao.deleteEventImg(event_code);
					
					// 새로운 이미지들을 insert 하기 
					for(int i =0 ; i< imageMapList.size() ; i++) {
						
						HashMap<String,String> imageMap = imageMapList.get(i);
						
						if(i==0) {
							imageMap.put("main","1");
						}
						else {
							imageMap.put("main","0");
						}
						
						imageMap.put("fk_event_code", event_code);
						result = dao.insertEventImage(imageMap);
						
					} // end of for ------
					
				}
				
			} // end of if ( n ==1 ) ----------
			
		} // end of else ---------------------------
		
		return result;
	} // end of insertOrReviseEvent ---------------------------------


	
	
	// 이벤트 전체 갯수 가져오기
	public int getEventTotalCount() {

		int totalcount = dao.getEventTotalCount();
		return totalcount;
	}

	// 이벤트 목록 가져오기
	public List<HashMap<String, String>> getEventList(HashMap<String, String> paraMap) {

		List<HashMap<String, String>> eventList = dao.getEventList(paraMap);
		return eventList;
	}



	// 이벤트 하나 가져오기
	public HashMap<String, String> getOneEvent(String event_code) {

		HashMap<String,String> eventMap = dao.getOneEvent(event_code);
		return eventMap;
	}

	// 이벤트 이미지 가져오기
	public List<HashMap<String, String>> getOneEventImg(String event_code) {

		List<HashMap<String,String>> eventImgMap = dao.getOneEventImg(event_code);
		return eventImgMap;
	}



	// 이벤트 삭제하기
	public int deleteEvent(String event_code) {

		int result = 0;
		
		// 이벤트 테이블 업데이트
		result = dao.deleteEvent(event_code);
		
		// 이미지 테이블 업데이트
		if(result == 1) {
			
			result = dao.deleteEventImg(event_code);
			
			if(result >0 ) {
				result = 1;
			}
		}
		
		return result;
	}



	// 이벤트 가져오기 ( 이전글 , 다음글 포함 )
	public HashMap<String, String> getOneEventWithLagLead(String event_code) {

		HashMap<String,String> eventMap = dao.getOneEventWithLagLead(event_code);
		return eventMap;
	}

	// ====================== 이벤트 진행하기 =========================================
	
	
	public int doEventEnd4(HashMap<String, String> paraMap) {

		int result = 0;
		
		// 이 계정에 쿠폰이 있는지 확인
		int n = dao.checkCoupon(paraMap);
		
		if (n==0) {		// 없으면 insert 하기
			
			// tbl_here_admin_coupon 에 insert 하기
			paraMap.put("coupon_type","1");
			result = dao.giveCoupon(paraMap);
			
			if(result == 1) {
				
				// 금방 발급한 쿠폰 코드 가져오기
				String coupon_code = dao.getCouponCode();
				
				paraMap.put("fk_coupon_code", coupon_code);
				result = dao.giveCouponToUser(paraMap);
				
				if(result == 1) {
					
					// 발급한 쿠폰 상태 바꾸기
					result = dao.useCoupon(paraMap);
					
					// 적립금 업데이트 하기
					if(result ==1) {
						result = dao.useCouponForPoint(paraMap);
					}
					
				}
			}
		}
		return result ;
	}
	
	
	public int doEventEnd6(HashMap<String,String> paraMap) {
		
		int result = 0;
		
		// 이 계정에 쿠폰이 있는지 확인
		int n = dao.checkCoupon(paraMap);
		
		if (n==0) {		// 없으면 insert 하기
			
			// tbl_here_admin_coupon 에 insert 하기
			paraMap.put("coupon_type","2");
			result = dao.giveCoupon(paraMap);
			
			if(result == 1) {
				
				// 금방 발급한 쿠폰 코드 가져오기
				String coupon_code = dao.getCouponCode();
				
				paraMap.put("fk_coupon_code", coupon_code);
				result = dao.giveCouponToUser(paraMap);
			}
		}
		return result;
	}


	// 매일 밤 12시마다 이벤트 체크해서 날짜가 지난 이벤트는 status 를 2( 종료 ) 로 바꾸기
	@Scheduled(cron="0 0 0 * * ?")
	public void scheduleEventCheck() {
		
		dao.updateEventStatus();
	}
	
	
	
	
} // end of class ------------------------------------------------------------
