package com.project.yhj.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.project.common.MyUtil;
import com.project.smh.SmhMemberVO;

@Aspect		// 관심사 클래스 등록
@Component	// bean 객체 등록
public class LoginCheck {


	// pointcut 생성
	@Pointcut("execution( public * com.project.yhj..*Controller.loginCheck_*(..))")
	public void loginCheck() {}
	
	// before advice 구현
	@Before("loginCheck()")
	public void before(JoinPoint joinpoint) {		
		
		HttpServletRequest request = ( HttpServletRequest ) joinpoint.getArgs()[0];
		HttpServletResponse response = ( HttpServletResponse ) joinpoint.getArgs()[1];
		HttpSession session = request.getSession();
		
		// 추후 수정할 것 ( vo 로 받아올 것 )
		SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
			
			String msg = "로그인 먼저 해주세요.";
			String loc = "javascript:location.href='"+request.getContextPath()+"/userLogin.bc'";		
			
			String goBackURL = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", goBackURL);
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			try {
				dispatcher.forward(request, response);
				
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		
	} // end of before -------------------------------------------
	
	
	
	
} // end of class ---------------------------------------------------------
