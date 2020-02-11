package com.project.smh;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.apache.taglibs.standard.tag.common.fmt.RequestEncodingSupport;
import org.codehaus.jackson.JsonNode;


import com.project.common.SHA256;
import com.project.mail.SmhGoogleMail;


//=== #30. 컨트롤러 선언 ===
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. */
@Controller
public class SmhController {
	
// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private  SmhService service;
	private SmhMemberVO sessionVo;

	private SmhGoogleMail mail;
	
	
	// === 로그인 폼 페이지 요청  ===  
	@RequestMapping(value="/userLogin.bc")
	public ModelAndView hereUserLogin(ModelAndView mav, HttpSession session) {
		
		mav = new ModelAndView();

		String kakaoUrl = SmhKakaoController.getAuthorizationUrl(session);


		mav.setViewName("smh/userLoginForm");
		
		 /* 생성한 인증 URL을 View로 전달 */
		mav.addObject("kakao_url", kakaoUrl);
		return mav;
	}
	
	// 카카오 
	@RequestMapping(value = "/kakaologin.bc",produces = "application/json", method=RequestMethod.GET)
	public ModelAndView getKakaoSignIn(SmhMemberVO smhmbrvo, ModelAndView mav,ModelMap model,@RequestParam("code") String code, HttpSession session, HttpServletRequest request) throws Exception {

	  JsonNode kakaoLoginuser = SmhKakaoController.getKakaoUserInfo(code);

	  System.out.println("kakaoLoginuser정보~~~~~~~~~~~~~~~~~~"+kakaoLoginuser);

	  String email = kakaoLoginuser.get("kaccount_email").toString().replaceAll("\"", "");
	  String name = kakaoLoginuser.get("properties").get("nickname").toString().replaceAll("\"", "")+"(카카오)";
	  // gender = loginuser.get("properties").get("gender").toString();
	  // String birthday = loginuser.get("properties").get("birthday").toString();

	  System.out.println("카카오확인용" + email + name );
	  
	  //1. 로그인 시도 = 사용자가 이미 가입되어있는 사람인지 확인 하기 위함
	 
		
	  String pwd = "qwer1234$";
	  HashMap<String, String> paraMap = new HashMap<String, String>(); 
	 	paraMap.put("email", email);
	 	String pwd2 = SHA256.encrypt(pwd);
		paraMap.put("pwd",  pwd2);  // 단방향 암호화를 시켰다. 
		paraMap.put("name",  name);
	  
	  SmhMemberVO loginuser = service.getLoginMember(paraMap); // 암호화가 되어진상태에서 mapper로 간다. 
	  
	 
	  if(loginuser == null) {
		  String encryPassword = SHA256.encrypt(pwd); 
		  
		  smhmbrvo.setPwd(encryPassword);	
		  smhmbrvo.setEmail(email);
		  smhmbrvo.setName(name);
		  
		  int n = service.memberInsertForKakao(smhmbrvo);
		  if (n==1) {
			  HashMap<String, String> paraMap2 = new HashMap<String, String>(); 
			  	paraMap2.put("name", name);
			 	paraMap2.put("email", email);
				paraMap2.put("pwd",  SHA256.encrypt(pwd));  
				loginuser = service.getKakaoLoginMember(paraMap2);
				
				session = request.getSession();
				session.setAttribute("name", name);
				session.setAttribute("loginuser", loginuser);
		  }			
		} else {
			session = request.getSession();
			session.setAttribute("loginuser", smhmbrvo);
		}
	  		System.out.println("loginuser"+loginuser);
	 
	  //3. kakaoLoginuser 로 회원가입 시도 -> 회원가입 완료후 4번으로

	  
	  session.setAttribute("loginuser", smhmbrvo);
	  //4. 2에서 성공한 loginuser정보나 3.에서 회원가입 성공한 kakaoLoginUser를 사용 하여 session에 저장
	  //session.setAttribute("kakaoLoginuser", kakaoLoginuser);
	  //session.setAttribute("loginuser", loginuser);
	  //5. 세션에 저장 성공후 main페이지로 이동 시킴

	  mav.addObject("loginuser", loginuser);
	  mav.addObject("email", email);
	  mav.addObject("name", name);
	  //model.addAttribute("loginuser", loginuser);
	  //model.addAttribute("email", email);
	  //model.addAttribute("name", name);
	  //model.addAttribute("gender", gender);
	  //model.addAttribute("birthday", birthday);
	  
	  mav = new ModelAndView();
	 
	  
	  mav.setViewName("psb/main");
		
		 
		
		return mav;
		
	}

			
	// === 회원가입 페이지 요청 ===  
	@RequestMapping(value="/userRegisterForm.bc")
	public ModelAndView userRegisterForm(ModelAndView mav) {
		
		mav.setViewName("smh/userRegisterForm");
		return mav;
	}	

	
	// 회원가입한 user insert 
	@RequestMapping(value="/userRegisterForm.bc", method= {RequestMethod.POST})
	public String memberInsert(SmhMemberVO smhmbrvo, HttpServletRequest request,  HttpServletResponse response) throws IOException {
		
		// 암호화전 확인
		//System.out.println("smhmbrvo.getPwd()  :  "+smhmbrvo.getPwd());	
		
		// 비밀번호 암호화 		     
		String encryPassword = SHA256.encrypt(smhmbrvo.getPwd());
		
		// 암호화 집어넣기 		 
		 smhmbrvo.setPwd(encryPassword);
		 
		// 암호화후 확인	
		// System.out.println("두번째:" + smhmbrvo.getPwd());
		 
         int n = service.memberInsert(smhmbrvo);
		
         // 회원가입 성공시 포인트 1000점 insert
         if(n == 1) {

        	 String useremail = request.getParameter("email");
        	 // System.out.println("email => "+ useremail);

        	 String memberIdx = service.selectmemberidx(useremail);
        	 // System.out.println("memberIdx"+ memberIdx);
      
        	 int memberPoint = 1000;
        	 
        	 int m  = service.memberPointInsert(memberIdx, memberPoint);
        	 
        	 request.setAttribute("msg", "회원가입을 환영합니다. 포인트 1000원이 지급되었습니다.");
        	 request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/userLogin.bc'");
        	  	
         }
         else {
        	 request.setAttribute("msg", "회원가입을 실패하였습니다.");
         	 request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/userRegisterForm.bc'");
         }
   
		return "msg";
	}
	
	// 로그인 처리하기 
	@RequestMapping(value="/loginEnd.bc", method= {RequestMethod.POST} )
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav) { 
		

	 	String email = request.getParameter("email");
	 	String pwd = request.getParameter("pwd");
	 	String nickname = request.getParameter("nickname");
	 	String name = request.getParameter("name");
	 	String hp1 = request.getParameter("hp1");
	 	String hp2 = request.getParameter("hp2");
	 	String hp3 = request.getParameter("hp3");

	 	

	 	HashMap<String, String> paraMap = new HashMap<String, String>(); 
	 	paraMap.put("email", email);
		paraMap.put("pwd",  SHA256.encrypt(pwd));  // 단방향 암호화를 시켰다. 
		paraMap.put("nickname",  nickname);
		paraMap.put("name",  name);
		paraMap.put("hp1", hp1);
		paraMap.put("hp2", hp2);
		paraMap.put("hp3", hp3);


		SmhMemberVO loginuser = service.getLoginMember(paraMap); // 암호화가 되어진상태에서 mapper로 간다. 
	
		// 확인용 
		// System.out.println("loginuser : " + loginuser);
		
		HttpSession session = request.getSession();

		if(loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
						
		}	
		// 암호를 최근 6개월 동안 변경하지 않은 경우
		else {
			if(loginuser.isRequirePwdChange() == true) {
				
				session.setAttribute("loginuser", loginuser);
				
				String msg = "암호를 최근 6개월 동안 변경하지 않으셨습니다. 암호변경을 위해 나의정보 페이지로 이동합니다."; 
				String loc = request.getContextPath()+"/myinfo.bc"; // 만들어야함 
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			// 아무런 이상없이 로그인 하는 경우그인
			else {				
				session.setAttribute("loginuser", loginuser);
				
				if(session.getAttribute("gobackURL") != null) {
				// 세션에 저장된 돌아갈 페이지의 주소(gobackURL)이 있다라면
					
					String gobackURL = (String) session.getAttribute("gobackURL");
					mav.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
					
					session.removeAttribute("gobackURL");  //session을 없앤다.
				}
				
				mav.setViewName("smh/loginEnd");				
			}
		}	
		return mav;			
	  }
	
	// 이메일(id)중복검사
	@RequestMapping(value = "/userEmailCheck.bc", method = RequestMethod.GET)
	@ResponseBody
	public String emailCheck(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		int result = service.userEmailCheck(email);

		return Integer.toString(result);
	}
	

	// 회원 한명의 정보보기(MyPage)
	@RequestMapping(value="/myPage.bc")
	public ModelAndView myPage(ModelAndView mav, HttpServletRequest request, SmhMemberVO smhmembervo) throws Exception {
		HttpSession session = request.getSession();
		
		mav.setViewName("myPage2.tilesSMH");
		return mav;
	}	
	
	
	
	// 회원정보 업데이트 
		@RequestMapping(value="/userInfoUpdate.bc", method = RequestMethod.POST)
		public String InfoUpdate(HttpServletRequest request, @ModelAttribute SmhMemberVO smhvo){
		
			HttpSession session = request.getSession();
			
			String Member_idx = request.getParameter("Member_idx");
			String mstatus = request.getParameter("mstatus");
		     
		
			sessionVo = (SmhMemberVO) session.getAttribute("loginuser");
						
			if(smhvo.getNickname() != null) {
				sessionVo.setNickname(smhvo.getNickname());
			}
			if(smhvo.getName() != null) {
				sessionVo.setName(smhvo.getName());
			}
			
			if(smhvo.getHp1() != null) {
				sessionVo.setHp1(smhvo.getHp1());
			}
			if(smhvo.getHp2() != null) {
				sessionVo.setHp2(smhvo.getHp2());
			}
			if(smhvo.getHp3() != null) {
				sessionVo.setHp3(smhvo.getHp3());
			}
			
			if(Member_idx != null) {
			sessionVo.setMember_idx(smhvo.getMember_idx());
			}
			if(mstatus != null) {
				sessionVo.setMember_idx(smhvo.getmstatus());
				}
			System.out.println("mstatusmstatusmstatus"+mstatus);
			int n = service.InfoUpdate(sessionVo);
			
			
			return "redirect:/myPage.bc";	

		}
		
		// 핸드폰 인증번호 보내기 
		@ResponseBody
		@RequestMapping(value ="/sendSMS.bc", produces="text/plain;charset=UTF-8")
		public String sendSms(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			// 생성한 랜덤한 번호 받아오기 
	  	    int len = 6;
	  	    int dupCd = 1;
	  	    String numStr = SmhRandom.numberGen(len, dupCd);
			
			String api_key = "NCSVPPRX8PMLUL6N";
		    String api_secret = "39JQW59NRSF7MXGCGOMPNAC3JCH0CDZX";
		    Message coolsms = new Message(api_key, api_secret);

		    HttpSession session = request.getSession();
		    SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
		    String hp = loginuser.getHp1()+loginuser.getHp2()+loginuser.getHp3();
		    String name = loginuser.getName();
		    
		    
		    
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", hp); // 수신번호
		    params.put("from", "01026457116"); // 발신번호
		    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		    params.put("text", "[여기는어때] 에서"+name+"님의 인증번호 [ "+ numStr +"] 를 보내드립니다"); // 문자내용    
		    params.put("app_version", "JAVA SDK v1.2"); // application name and version


		    String result = "";
		    		
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		  //  System.out.println(obj.toString());
		      
	   		  result = obj.toString();	
	   		  
	   		 session.setAttribute("result", result);
	   		session.setAttribute("numStr", numStr);
	   		  
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
	   		  
			return result;	
		}
	
		@ResponseBody
		@RequestMapping(value ="/checkSMS.bc", produces="text/plain;charset=UTF-8")
		public String checkSMS(HttpServletRequest request, HttpServletResponse response) {
			
			String jsonStr = "";
			
		try {
			HttpSession session = request.getSession();
			String inputNum = request.getParameter("checkSMS");
			String numStr = (String)session.getAttribute("numStr"); // 문자로받은 인증번호 
			
			System.out.println("numStr"+numStr);
			System.out.println("inputNum"+inputNum);
			
	
			int result = 0;
			JSONArray jsonArr = new JSONArray();
			
			if(numStr.equals(inputNum)) {
				
				result = 1;
				
				JSONObject jsonbj = new JSONObject();

				jsonbj.put("result", result);
				
				
				jsonArr.put(jsonbj);
				jsonStr = jsonbj.toString();
			}	
	
			//jsonStr = jsonArr.toString(); //json 배열을 string타입으로 변경
			System.out.println(jsonStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			return jsonStr;		
		}

	// 회원 포인트 조회
	@RequestMapping(value="/myPoint.bc")
	public ModelAndView myPoint(ModelAndView mav, HttpServletRequest request, SmhMemberVO smhmembervo) throws Exception {
		 HttpSession session = request.getSession();		
		 SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
		 
		 String memberidx = Integer.toString(loginuser.getMember_idx());
		 HashMap<String, String> paraMap = new HashMap<String, String>(); 
  	 	 paraMap.put("memberidx", memberidx);
  	 	 
		String point = service.getUserPoint(paraMap);
		 
		 
		mav.addObject("point",point);
		mav.setViewName("myPoint.tilesSMH");
		return mav;
	}	
	
	    // 회원 쿠폰조회 
		@RequestMapping(value="/myCoupon.bc")
		public ModelAndView myCoupon(ModelAndView mav, HttpServletRequest request, SmhMemberVO smhmembervo) throws Exception {
			
			HttpSession session = request.getSession();		
			 SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
			 
			 String coupon_name = request.getParameter("coupon_name");				 // 쿠폰이름 
			 String coupon_discountMon = request.getParameter("coupon_discountMon"); // 쿠폰할인금액 
			 String coupon_startday = request.getParameter("coupon_startday");		 //쿠폰시작날짜
			 String coupon_endday = request.getParameter("coupon_endday");			 //쿠폰끝나는날짜 
			 String coupon_useday = request.getParameter("coupon_useday");	         // 쿠폰사용날짜 
			 // 쿠폰사용한 날짜 
			 String memberidx = Integer.toString(loginuser.getMember_idx());	
			 
			HashMap<String, String> paraMap = new HashMap<String, String>(); 
			
			paraMap.put("coupon_name", coupon_name);
			paraMap.put("coupon_discountMon", coupon_discountMon);
			paraMap.put("coupon_startday", coupon_startday);
			paraMap.put("coupon_endday", coupon_endday);
			paraMap.put("coupon_useday", coupon_useday);
			paraMap.put("memberidx", memberidx);
		
			
			
			List<HashMap<String, String>> CouponList = service.couponList(paraMap);
		
			
			request.setAttribute("CouponList", CouponList);
			mav.setViewName("myCoupon.tilesSMH");
			return mav;
		}
		
		// 회원 예약내역조회 
			@RequestMapping(value="/myReservation.bc")
			public ModelAndView myReservation(ModelAndView mav, HttpServletRequest request, SmhMemberVO smhmembervo) throws Exception {
				
				 HttpSession session = request.getSession();		
				 SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");

				 String hotel_Name = request.getParameter("hotel_Name");	// 호텔이름  
				 String hotel_Addr1 = request.getParameter("hotel_Addr1");  // 호텔 주소1
				 String hotel_Addr2 = request.getParameter("hotel_Addr2");	// 호텔주소 2	 
				 String hotel_Addr3 = request.getParameter("hotel_Addr3");	// 호텔주소 3
				 String hotel_Post = request.getParameter("hotel_Post");	// 호텔우편주소 
				 String hotel_Phone = request.getParameter("hotel_phone");	// 호텔전화번호 
				 String hotelImage_FileName = request.getParameter("hotelImage_FileName");	// 호텔이미지 
				
				 String member_idx = Integer.toString(loginuser.getMember_idx());
				 
				 HashMap<String, String> paraMap = new HashMap<String, String>(); 
					
					paraMap.put("hotel_Name", hotel_Name);
					paraMap.put("hotel_Addr1", hotel_Addr1);
					paraMap.put("hotel_Addr2", hotel_Addr2);	
					paraMap.put("hotel_Addr3", hotel_Addr3);
					paraMap.put("hotel_Phone", hotel_Phone);
					paraMap.put("member_idx", member_idx);
					paraMap.put("hotelImage_FileName", hotelImage_FileName);
				
									
					List<HashMap<String, String>> reservationList = service.reservationList(paraMap);
					
					request.setAttribute("reservationList", reservationList);
					
					mav.setViewName("myReservation.tilesSMH");
				return mav;
				
		}
		
	  @RequestMapping(value = "/userFindPwdForm.bc")
	   public String userFindPwd(HttpServletRequest request, HttpServletResponse response) throws Exception{
	      return "smh/userFindPwdForm";
	   }   
	   
	   // 메일로 임시비밀번호 발송하기 
	   @RequestMapping(value = "/findPwdEmailCheck.bc")
	   public String findPwdEmailCheck(HttpServletRequest request, HttpServletResponse response) throws Exception{
	               
	      String method = request.getMethod();
	      
	      if("POST".equalsIgnoreCase(method)) {
	         
	         String email = request.getParameter("email");
	         
	         String isUserExist = service.isUserExist(email); // 회원이 존재하는지 안하는지 검사 
	         //boolean isUserExist = smhdao.isUserExist(paraMap);
	         int n = 0;
	         
	         if( isUserExist != null ) {
	            //회원으로 존재하는 경우 인증메일을 보내겠다.
	            
	            n= 1; //회원이 존재하는 경우 에는 1 
	            
	            SmhGoogleMail mail = new SmhGoogleMail();
	            
	            // 인증키를 랜덤하게 생성하도록 한다.
	            Random rnd = new Random();
	            //math.random도 있지만 보안적으로 약하기때문에
	            String certificationCode = "";
	            // certificationCode => "swfet0933651"
	            
	            char randchar = ' '; // 공백이 기본값이다.
	            for(int i=0; i<5; i++) {
	                              
	                //min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
	                //int rndum = rnd.nextInt(max - min + 1) + min;
	                //영문 소문자 'a' 부터 'z' 까지 랜덤하게1개를 만든다.
	             
	               
	            // char타입이 정수와 사칙연산을 만나면 자동적으로 int로 바뀐다.
	               randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
	               
	               certificationCode += randchar;               
	            }
	               
	               int randnum = 0;
	               for(int i=0; i<7; i++) {
	                  randnum = rnd.nextInt(9-0+1) + 0;
	                  certificationCode += randnum;
	               }            
	               System.out.println("확인용 certificationCode =>"+ certificationCode);
	               
	                              
	               // 랜덤하게 생성한 인정코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
	               HttpSession session = request.getSession();
	               
	               try {
	            	 
	                     mail.sendmail(email, certificationCode);
	                     
	                     session.setAttribute("certificationCode", certificationCode);
	                     // 발급한 인증코드를 세션에 저장.
	                     request.setAttribute("email", email); 
	                     
	                     response.setContentType("text/html; charset=UTF-8");
	                     
	                     PrintWriter out = response.getWriter();
	                      
	                     out.println("<script>alert('"+email+"로 임시비밀번호가  발송되었습니다.');</script>");
	                      
	                     out.flush();
	                     
//	                    
//	                   email = (String)session.getAttribute(certificationCode);
//	                   String pwd = (String)session.getAttribute(certificationCode);
//	                   session.getAttribute(email);
	                    
	                    
	                    HashMap<String, String> paraMap = new HashMap<String, String>(); 
	             	 	paraMap.put("email", email);
	             		paraMap.put("pwd", SHA256.encrypt(certificationCode)); 

	             		
	                    int m =  service.pwdUpdate(paraMap);
	                    
	                   System.out.println("비번업데이트 확인 certificationCode =>>>"+ certificationCode);
	                   
	                     
	               }catch (Exception e) {
	                  e.printStackTrace(); 
	                  
	                  n= - 1;   //인증메일을 보내는 google계정이 잘못되었다면.      
	               }
	         }//end of if--------------
	         else {
	            //회원으로 존재하지 않는 경우
	            n = 0; //n의 값이 0이라면 회원은 없다. 
	            request.setAttribute("msg","가입된 회원이 아닙니다.");
	            request.setAttribute("loc", request.getContextPath() + "/userFindPwdForm.bc");

	            return("psb/msg");
	            
	         }// end of else
	         
	            request.setAttribute("n", n);
	            request.setAttribute("email", email);
	            // 비밀번호 찾기한 userid를 받아와서 view단으로 넘어간다.
	         
	      }// end of if("POST".equalsIgnoreCase(method))
	      request.setAttribute("method", method); // 메소드는 get이나 post 상관없이 넘어간다
	      
	      return "smh/findPwdEmailCheck";
	   }
	   
	 
	
	// 회원 탈퇴/ 로그인 처리하기 
	@RequestMapping(value="/DeleteEnd.bc", method= {RequestMethod.POST} )
	public ModelAndView memberDelete(HttpServletRequest request, ModelAndView mav,SmhMemberVO smhvo)throws Exception{		
																			// jsp 의 smhvo 이다.
		 HttpSession session = request.getSession();
		
		 SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
		 
		 
		 int member_idx = loginuser.getMember_idx();
		 String  email = loginuser.getEmail();
		 int mstatus = loginuser.getmstatus();
		
		System.out.println("member_idx"+member_idx);
		System.out.println("email"+email);	
		System.out.println("mstatus"+mstatus);	
		 
		  //SmhMemberVO vo = (SmhMemberVO)session.getAttribute("loginUser");
		  //int result = service.add_transaction(vo);
		  int result = service.add_transaction(loginuser);
		  System.out.println("result~~~~~~~~~~~~~~~~~~~"+result);
		 	 
		 if(result == 0) {
				String msg = "회원탈퇴에 실패하였습니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");							
			}	
		 else {
				String gobackURL = (String) session.getAttribute("gobackURL");
				mav.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
				
				session.removeAttribute("gobackURL");  //session을 없앤다.
				session.invalidate();
								
			 }	
		 mav.setViewName("smh/DeleteEnd");	
		 return mav;
	}
	
	
	
		
	
	
	
}
