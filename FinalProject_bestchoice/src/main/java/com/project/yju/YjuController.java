package com.project.yju;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class YjuController {

	@Resource
	private YjuService service ;
	
	
	
}
