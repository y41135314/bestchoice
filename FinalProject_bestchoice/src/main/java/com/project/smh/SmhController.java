package com.project.smh;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tools.ant.taskdefs.condition.Http;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.support.GenericTypeAwareAutowireCandidateResolver;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.common.SHA256;

import sun.security.action.GetIntegerAction;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonParser;
import com.project.common.AES256;
//=== #30. 컨트롤러 선언 ===
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. */
@Controller
public class SmhController {
	
// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private  SmhService service;
	

	// === 로그인 폼 페이지 요청  ===  
	@RequestMapping(value="/userLogin.bc")
	public ModelAndView hereUserLogin(ModelAndView mav, HttpServletRequest request) {
		
	    mav.setViewName("smh/userLoginForm");
		return mav;
	}
	

	// === 회원가입 페이지 요청 ===  
	@RequestMapping(value="/userRegisterForm.bc")
	public ModelAndView userRegisterForm(ModelAndView mav) {
		
		mav.setViewName("smh/userRegisterForm");
		return mav;
	}	

	
	// == 회원가입한 user insert ==
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
	        	 	
	        	
	         }
	   
			return "smh/userLoginForm";
		}
		
	
	// 로그인 처리하기 
	@RequestMapping(value="/loginEnd.bc", method= {RequestMethod.POST} )
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav) { 
		
	 	String email = request.getParameter("email");
	 	String pwd = request.getParameter("pwd");

	 	HashMap<String, String> paraMap = new HashMap<String, String>(); 
	 	paraMap.put("email", email);
		paraMap.put("pwd",  SHA256.encrypt(pwd));  // 단방향 암호화를 시켰다. 
		

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
		else {
			if(loginuser.isRequirePwdChange() == true) {
				// 암호를 최근 6개월 동안 변경하지 않은 경우
				session.setAttribute("loginuser", loginuser);
				
				String msg = "암호를 최근 6개월 동안 변경하지 않으셨습니다. 암호변경을 위해 나의정보 페이지로 이동합니다."; 
				String loc = request.getContextPath()+"/myinfo.bc"; // 만들어야함 
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			else {
				// 아무런 이상없이 로그인 하는 경우
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
		//System.out.println("컨트롤러 result(email)=>  "+ result);
		return Integer.toString(result);
	}
	
	// 임시비밀번호 발송 (비밀번호찾기 )
	@RequestMapping(value = "/findPwd.bc" /*, method={RequestMethod.POST}*/ )
	public String userFindPwd(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		
		return "/smh/userFindPwd";
	}
	
	// 회원정보보기(mypage)
	@RequestMapping(value="/myPage.bc")
	public ModelAndView myPage(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		mav.setViewName("smh/myPage");
		return mav;
	}	
	
	/*// 임시비밀번호 발송 (비밀번호찾기 )
	@RequestMapping(value = "/findPwd.bc", method={RequestMethod.POST} )
	public String userFindPwd(HttpServletRequest request, HttpServletResponse response) throws Exception{
					
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String email = request.getParameter("email");
			
			HashMap<String, String> paraMap  = new HashMap<String, String>();			

			paraMap.put("email", email); //암호를 변경하고자 하는 email주소 
			
			boolean isUserExist = service.isUserExist(paraMap);
			//boolean isUserExist = smhdao.isUserExist(paraMap);
			int n = 0;
			
			if(isUserExist) {
				//회원으로 존재하는 경우 인증메일을 보내겠다.
				
				n= 1; //회원이 존재하는 경우 에는 1 
				
				GoogleMail mail = new GoogleMail();
				
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
						   
						   request.setAttribute("email", email); //("/WEB-INF/login/pwdFind.jsp"); 보내어 진다.
						   
					}catch (Exception e) {
						e.printStackTrace(); 
						
						n= - 1;	//인증메일을 보내는 google계정이 잘못되었다면.		
					}
			}//end of if--------------
			else {
				//회원으로 존재하지 않는 경우
				n = 0; //n의 값이 0이라면 회원은 없다. 
				
			}// end of else
			
				request.setAttribute("n", n);
			
				request.setAttribute("email", email);
				// 비밀번호 찾기한 userid를 받아와서 view단으로 넘어간다.
			
		}// end of if("POST".equalsIgnoreCase(method))
		request.setAttribute("method", method); // 메소드는 get이나 post 상관없이 넘어간다
		
		return "/smh/userFindPwd"; //ifram 속에 들어가는것
	}
		

	//  비밀번호  인증
	@RequestMapping(value="/pwdUpdateFront.bc", method= {RequestMethod.POST} )
	public ModelAndView pwdUpdateFront(HttpServletRequest request, ModelAndView mav) { 
		
		String email = request.getParameter("email");
		String userCertificationCode = request.getParameter("userCertificationCode");
		// 유저가 이메일 확인 후 입력한 인증코드
		
		HttpSession session = request.getSession();
		String certificationCode = (String)session.getAttribute("certificationCode");
		// 랜덤하게 발생되어 세션에 저장된 인증코드
		
		String message = "";
		String loc = "";
		int verifiedResult = 0;
		
		if( certificationCode.equals(userCertificationCode) ) {
			verifiedResult = 1;
			
			session.setAttribute("verifiedResult", verifiedResult);
			session.setAttribute("email", email);
			message = "인증에 성공하였습니다.";
			loc = request.getContextPath() + "/pwdUpdateFront.bc";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			session.setAttribute("email", email);
			
			// *** 중요 *** //
			// 세션에 저장된 인증코드 삭제하기 //
			session.removeAttribute("certificationCode");
			
			
			mav.setViewName("/WEB-INF/msg.jsp");
			return mav;
			
		} else {
			message = "인증에 실패하셨습니다. 인증코드를 재발급받으세요.";
			loc = request.getContextPath() + "/main.bc";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			


			mav.setViewName("/WEB-INF/msg.jsp");
			mav.setViewName("msg");
			
			return mav;
		}
	}*/
	
	// 네이버 로그인 
	@RequestMapping(value = "/userNaverLogin.bc")
	public String userNaverLogin(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		return "smh/userNaverLogin";
	}
	
	// 네이버 로그인 콜백 주소  
	@RequestMapping(value = "/callbackNaverLogin.bc")
	public String userNaverLoginCallback(HttpServletRequest request, HttpServletResponse response) throws Exception{
		   
		return "smh/callbackNaverLogin";
	}
		
	//   
	@RequestMapping(value = "/personalInfo.bc")
	public void personalInfo(HttpServletRequest request) throws Exception{
		
		/*  OAuth2AccessToken oauthToken;
			oauthToken = naverLoginBO.getAccessToken(session, code, state);
			
			//1. 로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
			*//** apiResult json 구조
			{"resultcode":"00",
			"message":"success",
			"response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
			**//*
			
			//2. String형식인 apiResult를 json형태로 바꿈
			JsonParser parser = new JsonParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			//3. 데이터 파싱
			//Top레벨 단계 _response 파싱
			JSONObject response_obj = (JSONObject)jsonObj.get("response");

			//response의 데이터값 파싱
			String email = (String)response_obj.get("email");
			String pwd = "naver" ;
			String name = (String)response_obj.get("name");
			String nickname = (String)response_obj.get("nickname");
			String gender = "";
			if(   "F".equals((String)response_obj.get("gender"))  ) {
				gender = "2";
			}else if ( "M".equals((String)response_obj.get("gender")) ) {
				gender = "1";
			}else {
				gender = null;
			}
			
			String encryPassword = SHA256.encrypt(pwd);
			
			SmhMemberVO smhmbrvo = new SmhMemberVO();
			// 암호화 집어넣기 		 
			smhmbrvo.setPwd(encryPassword);
			smhmbrvo.setEmail(email);
			smhmbrvo.setName(name);
			smhmbrvo.setNickname(nickname);
			smhmbrvo.setGender(gender);
	        
			int n = service.memberInsert(smhmbrvo);
	         
			//4.파싱 닉네임 세션으로 저장
			session.setAttribute("loginuser",smhmbrvo); //세션 생성
*/		    
			
		/* String token = "AAAAN3AqIy-Hsz2i7ssRz_DqurcRhNEo9L6NTMgCGUBWmeV_6bEEih0e0iCjqfKCUZ8qVRUYkhnCVM9lkznzNKgHlr0";// 네이버 로그인 접근 토큰;
		    String header = "Bearer " + token; // Bearer 다음에 공백 추가
		    try {
			    String apiURL = "https://openapi.naver.com/v1/nid/me";
			    URL url = new URL(apiURL);
			    HttpURLConnection con = (HttpURLConnection)url.openConnection();
			    con.setRequestMethod("GET");
			    con.setRequestProperty("Authorization", header);
			    int responseCode = con.getResponseCode();
			    BufferedReader br;
			    if(responseCode==200) { // 정상 호출
			    br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			    } else { // 에러 발생
			    br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			    }
			    String inputLine;
			    StringBuffer response = new StringBuffer();
			    while ((inputLine = br.readLine()) != null) {
			    response.append(inputLine);
			    }
			    br.close();
			    System.out.println(response.toString());
		    
		    } catch (Exception e) {
		    	System.out.println(e);
		    }
		
	
		*/
	}
	
	// 자동입력 
	@ResponseBody
	@RequestMapping(value="/naverInsert.bc", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8" )
	public String naverInsert(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		String name = request.getParameter("name") + "(네이버)";
		String nickname = request.getParameter("nickname");
		String gender = request.getParameter("gender");
		String ageStr = request.getParameter("age");
	
		String age = ageStr.substring(0, 2);
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		int birthyear = year - Integer.parseInt(age);
		
		String birthdayStr = request.getParameter("birthday");
		
		String birthday =  String.valueOf(birthyear) + birthdayStr.substring(0, 2) + birthdayStr.substring(3, 5);
		
		HashMap<String, String> paraMap = new HashMap<String, String>(); 
	 	paraMap.put("email", email);
		paraMap.put("pwd",  SHA256.encrypt("naver"));  
		
		SmhMemberVO loginuser = service.getLoginMember(paraMap); // 암호화가 되어진상태에서 mapper로 간다. 
		
		int m = 0;
		if(loginuser == null) {
			
			// 비밀번호 암호화 		     
			String encryPassword = SHA256.encrypt( "naver" );
			
			SmhMemberVO smhmbrvo = new SmhMemberVO();
			
			// 암호화 집어넣기 		 
			smhmbrvo.setPwd(encryPassword);
			smhmbrvo.setEmail(email);
			smhmbrvo.setName(name);
			smhmbrvo.setNickname(nickname);
			
			if(   "F".equals( gender)  ) {
				smhmbrvo.setGender("2");
			}else if ( "M".equals( gender) ) {
				smhmbrvo.setGender("1");
			}else {
				smhmbrvo.setGender("");
			}

			smhmbrvo.setHp1("");
			smhmbrvo.setHp2("");
			smhmbrvo.setHp3("");
			smhmbrvo.setBirthday(birthday);
			
			int n = service.memberInsert(smhmbrvo);
			
			if( n==1 ) {
				
				HashMap<String, String> paraMap2 = new HashMap<String, String>(); 
			 	paraMap2.put("email", email);
				paraMap2.put("pwd",  SHA256.encrypt("naver"));  
				loginuser = service.getLoginMember(paraMap2); // 암호화가 되어진상태에서 mapper로 간다. 
				
				HttpSession session = request.getSession();
				session.setAttribute("loginuser", loginuser);
				
				m=1;
			}
			
		}	
		else {
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			m=1;
		}
	
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",m);
		return jsonObj.toString();
	}
	
}
