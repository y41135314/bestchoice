package com.project.dws;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.project.smh.SmhMemberVO;
import com.project.smh.SmhRandom;

@Controller
public class DwsController {

	@Resource
	private DwsService service ;

	// 결제 페이지 뷰단 
	@RequestMapping(value="/pay/reserve.bc")
	public String reserve(HttpServletRequest request, Model model) {
		
		
		HttpSession session = request.getSession();
		SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser"); 
		
		if(loginuser == null) {
			
			request.setAttribute("msg", "로그인이 필요합니다." );
			request.setAttribute("loc", request.getContextPath()+"/userLogin.bc" );
			
			return "msg";
		}
		
		
		String hotel_idx = request.getParameter("hotel_idx"); //상세페이지에서 파라미터 넘 겨주셔야되여 
		String room_idx = request.getParameter("fk_room_idx");
		/*String resstatus_in_day = request.getParameter("resstatus_in_day"); // get으로 넘겨 줄때 yyyymmdd 형식으로
		String resstatus_out_day = request.getParameter("resstatus_out_day");// get으로 넘겨 줄때 yyyymmdd 형식으로
		String res_totalprice = request.getParameter("res_totalprice");
		*/
		
		String startday =request.getParameter("startday");
		String endday = request.getParameter("endday");// get으로 넘겨 줄때 yyyymmdd 형식으로
		
		//room_idx="123";
		//res_totalprice = "10000";
		
		// 방 정보 받아오기
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("room_idx",  room_idx );
		paraMap.put("startday", startday  );
		paraMap.put("endday",  endday );
		
		
		HashMap<String,String> roomMap = service.getRoomInfo(paraMap);
		request.setAttribute("roomMap", roomMap);
		request.setAttribute("hotel_idx", hotel_idx);
		request.setAttribute("room_idx", room_idx);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		
		// HashMap<String,String> roomMap = service.getRoomInfo(room_idx);
		
		// 쿠폰 리스트 받아오기
		String member_idx = String.valueOf(loginuser.getMember_idx());
		List<HashMap<String,String>> couponList = service.getCouponList(member_idx); 
		request.setAttribute("couponList", couponList);
		
		
		return "dws/reserve.tiles_dws";
	} // end of eventMain -----------------------------------
	
	
	
	
	@RequestMapping(value="/pay/reserveSuccess.bc")
	public String reserveSuccess(HttpServletRequest request, Model model  ) {
		HttpSession session = request.getSession();
		SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser"); 
		
		DwoReservationVO dwoReservation = new DwoReservationVO();
		
		String res_paymentstatus = request.getParameter("res_payment1Status"); //예약상태
		String res_payment = request.getParameter("res_payment");//(0카드/신용 1카카오페이 2네이버)
		String res_point = request.getParameter("res_point"); ///적립금 사용내역 
		String res_number = request.getParameter("res_number"); ///적립금 사용내역 
		String amount = request.getParameter("amount"); //적립금계산
		String mpointCash = request.getParameter("mpointCash");
		

 		//방정보 조회 
 		
		//DwoReservationVO reservationVO = service.selectReservation(res_number);//예약정보 조회 
		//현재 로그인이 아닌상태일시 loginuser 가존재 하지 않아 member_idx가 존재하지않음 
 		//해서 TBL_HERE_RESERVATION 테이블 inset 시 member_idx 제거후 insert 작업수행
 		//결제완료후 member_idx는 update 처리 
		
		
		
//		DwoReservationVO reservationVO = new DwoReservationVO();
//		Calendar cal = Calendar.getInstance();
//		int date = cal.get ( cal.DATE ) ;
		
//		String res_number = service.selectResNumber();
//		reservationVO.setRes_number(res_number);
//		/*reservationVO.setResstatus_in_day(resstatus_in_day);
//		reservationVO.setResstatus_out_day(resstatus_out_day);*/
//		
//		reservationVO.setResstatus_in_day(startday);
//		reservationVO.setResstatus_out_day(endday);
//		reservationVO.setRoom_idx(room_idx);
//		//reservationVO.setRes_totalprice(res_totalprice);
//		reservationVO.setRes_paymentstatus("1");// 결제상태
//		reservationVO.setHotel_idx(hotel_idx);
//		reservationVO.setRes_point("0"); //혹시 몰라서 일단 박아둠 현재 상태에서 적립금사용액 없음 
//		reservationVO.setRes_receipt(String.valueOf(date)+hotel_idx); //영수증 번호 생성 ( 날자+hotel_idx)
//		service.insertReservation(reservationVO);
//
//		reservationVO = service.selectReservation(res_number);
//		reservationVO.setMpointCash("0"); //디폴트값 세팅
//		//insert 문 추가 
//	/*	reservationVO.setResstatus_in_day(resstatus_in_day.substring(0, 4)+"년"+resstatus_in_day.substring(4, 6)+"월"+resstatus_in_day.substring(6, 8)+"일");
//		reservationVO.setResstatus_out_day(resstatus_out_day.substring(0, 4)+"년"+resstatus_out_day.substring(4, 6)+"월"+resstatus_out_day.substring(6, 8)+"일");*/
//		reservationVO.setResstatus_in_day(startday.substring(0, 4)+"년"+startday.substring(4, 6)+"월"+startday.substring(6, 8)+"일");
//		reservationVO.setResstatus_out_day(endday.substring(0, 4)+"년"+endday.substring(4, 6)+"월"+endday.substring(6, 8)+"일");
//		
//		model.addAttribute("reservation", reservationVO );
		
		
		
		
		
		
		
		
		//추가 적립금 비워놨습니다 쿼리에 0 으로 하드코딩 
		int point = Integer.valueOf(amount)/10;
		
		//적립금 차감 update 
		dwoReservation.setMember_idx(String.valueOf(loginuser.getMember_idx()));
		dwoReservation.setFk_member_idx(String.valueOf(loginuser.getMember_idx()));
		dwoReservation.setMpointCash(mpointCash); //사용된 적립금 
		dwoReservation.setRes_number(res_number);		 
		dwoReservation.setRes_paymentstatus(res_paymentstatus);
		dwoReservation.setRes_payment(res_payment);
		dwoReservation.setRes_point(res_point);
		dwoReservation.setRes_paymentstatus("1");
		service.updateReservation(dwoReservation); //사용된 적립금  update 
		dwoReservation.setFinish_addpoint(String.valueOf(point)); //추가 적립금 inset  
		service.insertFinish(dwoReservation); //고객  추가 적립금 inset  
		service.updateDeductionMpointCash(dwoReservation); //고객 마일리지 공제후 업데이트 
		
		return "dws/success.tiles_dws";
	} 
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/pay/mpointCash.bc", produces="text/plain;charset=UTF-8")
	public String viewPrice(HttpServletRequest request) {
		
		String meber_idx = request.getParameter("meber_idx");
		
		String mpointCash = service.selectMpointCash(meber_idx);
		JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
		
		jsonObj.addProperty("mpointCash", mpointCash);
		
		return jsonObj.toString(); 
	}
	


      //문자보내기 
		@ResponseBody
	    @RequestMapping(value = "/sendSms.bc", method= {RequestMethod.POST})
		public String sendSms(String receiver, HttpSession session) throws Exception {
			int rand = (int) (Math.random() * 899999) + 100000;
	    	session.setAttribute("rand", rand);
	    	
	    	// 생성한 랜덤한 번호 받아오기 
	  	    int len = 6;
	  	    int dupCd = 1;
	  	    String numStr = SmhRandom.numberGen(len, dupCd);

	    	//String api_key = "test"; //api key
	        //String api_secret = "test";  //api secret
	        String api_key = "NCSL0KA7LMSAAN6A"; //api key
	        String api_secret ="BPH3ZWN9HQZR5CTOTSKUQ0X8JMQRUWZC";  //api secret
	        com.project.dws.sms.Coolsms coolsms = new com.project.dws.sms.Coolsms(api_key, api_secret);
	         //com.project.dws.sms에서 정보를 받아오겟다
	        HashMap<String, String> params = new HashMap<String, String>();
	        params.put("to", receiver); // 받는번호

	        params.put("from", "01045606752"); //보내는번호
	        params.put("text", "여기는어때 입니다. 인증번호 [" + numStr  + "] 를 화면에 입력해주세요."); 
	        params.put("type", "sms");
	        params.put("mode", "test");
	        //문자메세지 확인용
	        //System.out.println(params);

	        org.json.simple.JSONObject result = coolsms.send(params); 
	        

	        if ((boolean)result.get("status") == true) {
	            return ""+numStr;
	          } else {

	            System.out.println(result.get("code")); // REST API 에러코드
	            //return "fail";
	            return ""+numStr;
	          }
	      }

	
	
}
