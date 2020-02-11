package com.project.dws;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.JSONString;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.project.common.MyUtil;
import com.project.psb.AdminVO;
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
	
	
	
	
	@RequestMapping(value="/pay/reserveSuccess.bc",method={RequestMethod.POST})
	public String reserveSuccess(HttpServletRequest request, Model model , DwoReservationVO rvo  ) throws Throwable {
		HttpSession session = request.getSession();
		SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser"); 
		
		
		rvo.setFk_member_idx(String.valueOf(loginuser.getMember_idx() ));
		
		int n = service.insertReservation(rvo);
		
		if( n==1 ) {
			
			
			return "dws/success.tiles_dws";
		}
		else {
			
			request.setAttribute("msg", "결제에 실패했습니다.");
			request.setAttribute("loc", "javascript:location.href='history.back();'");
			
			return "msg";
		}
		
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
	  	    
	  	    System.out.println("인증 번호 : "+numStr);
	  	    session.setAttribute("numStr", numStr);

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

		@ResponseBody
	    @RequestMapping(value = "/checkSms.bc", method= {RequestMethod.POST})
		public String checkSms(String receiver, HttpServletRequest request)  {
			
			String jsonStr = "";
			
			HttpSession session = request.getSession();
			String numStr = (String) session.getAttribute("numStr");
			
			JSONObject jsonObj = new JSONObject();
			if( numStr !=null && numStr.equals(receiver) ) {
				
				jsonObj.put("msg", "인증에 성공했습니다.");
				jsonStr = jsonObj.toString();
			}
			else {
				
				jsonObj.put("msg", "인증에 실패했습니다.");
				jsonStr = jsonObj.toString();
			}
			return jsonStr;
	      }
		
		
		
		////커밋테스입니다
	
	
	
}
