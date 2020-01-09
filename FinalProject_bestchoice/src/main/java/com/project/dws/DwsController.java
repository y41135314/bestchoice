package com.project.dws;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DwsController {

	@Resource
	private DwsService service ;
	
	
	
	
}
