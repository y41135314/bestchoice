package com.project.psb;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PsbController {

	@Resource
	private PsbService service ;
	
	@RequestMapping(value="/main.bc")
	public String index(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", "leess");
		//session.invalidate();
		return "psb/main";
	}
	
	@RequestMapping(value="/logout.bc")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		mav.setViewName("psb/main");
		return mav;
	}
	
}
