package com.project.smh;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.common.SHA256;
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
	public ModelAndView hereUserLogin(ModelAndView mav) {
		
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
	public String memberInsert(SmhMemberVO smhmbrvo ) {
		
		// 암호화전 확인
		//System.out.println("smhmbrvo.getPwd()  :  "+smhmbrvo.getPwd());	
		
		// 비밀번호 암호화 		     
		String encryPassword = SHA256.encrypt(smhmbrvo.getPwd());
		
		// 암호화 집어넣기 		 
		 smhmbrvo.setPwd(encryPassword);
		 
		// 암호화후 확인	
		// System.out.println("두번째:" + smhmbrvo.getPwd());
		 
         service.memberInsert(smhmbrvo);
		
		
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
	 	// paraMap.put("pwd",  pwd);
		
		
		SmhMemberVO loginuser = service.getLoginMember(paraMap); // 암호화가 되어진상태에서 mapper로 간다. 
		// service에서 보내주고있다.
		
		System.out.println("loginuser : " + loginuser);
		
		HttpSession session = request.getSession();
		
		if(loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
			//  src/main/webapp/WEB-INF/views/msg.jsp 파일을 생성한다.
		}
		
	
		else {
			session.setAttribute("loginuser", loginuser);
			mav.setViewName("smh/loginEnd");
		}
		
		return mav;
	}
	
		
	
}
