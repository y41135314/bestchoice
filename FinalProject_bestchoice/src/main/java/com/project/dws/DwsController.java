package com.project.dws;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.project.smh.SmhMemberVO;

@Controller
public class DwsController {

	@Resource
	private DwsService service ;

	// 결제 페이지 뷰단 
	@RequestMapping(value="/pay/reserve.bc")
	public String reserve(HttpServletRequest request, Model model) {

		String member_idx = request.getParameter("member_idx") == null ? "" : request.getParameter("member_idx") ;//세션으로 변경 
		String res_number = request.getParameter("res_number "); //상세페이지에서 파라미터 넘 겨주셔야되여 
		//res_number = "2";
		
 		SmhMemberVO memberVo = service.selectMember(member_idx); // 고객정보 
		//방정보 조회 
		DwoReservationVO reservationVO = service.selectReservation(res_number);//예약정보 조회 
		
		String in_day = reservationVO.getResstatus_in_day();
		String out_day = reservationVO.getResstatus_in_day();
		
		reservationVO.setResstatus_in_day(in_day.substring(0, 4)+"년"+in_day.substring(4, 6)+"월"+in_day.substring(6, 8)+"일");
		reservationVO.setResstatus_out_day(out_day.substring(0, 4)+"년"+out_day.substring(4, 6)+"월"+out_day.substring(6, 8)+"일");
//
//		reservationVO.setRes_paymentstatus("1");// 결제상태
//		service.updatePayStatus(reservationVO);
		model.addAttribute("member", memberVo);
		model.addAttribute("reservation", reservationVO );
		
		return "dws/reserve.tiles_dws";
	} // end of eventMain -----------------------------------
	
	@RequestMapping(value="/pay/reserveSuccess.bc")
	public String reserveSuccess(HttpServletRequest request, Model model) {
		
		DwoReservationVO dwoReservation = new DwoReservationVO();
		
		String res_paymentstatus = request.getParameter("res_payment1Status"); //예약상태
		String res_payment = request.getParameter("res_payment");//(0카드/신용 1카카오페이 2네이버)
		String res_point = request.getParameter("res_point"); ///적립금 사용내역 
		String res_number = request.getParameter("res_number"); ///적립금 사용내역 
		String amount = request.getParameter("amount"); //적립금계산
		String mpointCash = request.getParameter("mpointCash");
		
		//추가 적립금 비워놨습니다 쿼리에 0 으로 하드코딩 
		int point = Integer.valueOf(amount)/10;
		
		//적립금 차감 update 
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
	
	
/*	  이건 잠시 주석 파일 올라가고 풀자
	 문자보내기 
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
        
        org.json.simple.JSONObject result = coolsms.send(params); 
        
        if ((boolean)result.get("status") == true) {
            return ""+numStr;
          } else {

            System.out.println(result.get("code")); // REST API 에러코드
            //return "fail";
            return ""+numStr;
          }
      }
*/

	
	
	
	
}
