package com.project.dws;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DwsController {

	@Resource
	private DwsService service ;
	
	
	

	// 결제 페이지 뷰단 
	@RequestMapping(value="/pay/reserve.bc")
	public String faqMain(HttpServletRequest request) {

		
		return "dws/reserve";
	} // end of eventMain -----------------------------------
	
	
}
