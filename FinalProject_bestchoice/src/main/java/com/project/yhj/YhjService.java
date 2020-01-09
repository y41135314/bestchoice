package com.project.yhj;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class YhjService {

	@Resource
	private YhjDAO dao ;

	public String getDate() {
		String date = dao.getDate();
		return date;
	}

	
}
