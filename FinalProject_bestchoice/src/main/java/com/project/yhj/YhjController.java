package com.project.yhj;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class YhjController {

	@Resource
	private YhjService service ;
	
	@RequestMapping(value="/start.bc")
	public String Main(HttpServletRequest request) {
		
		System.out.println("시작");
		
		String date = service.getDate();
		request.setAttribute("date", date);
		
		System.out.println(date);
		
		return "yhj/main";
	}
}
