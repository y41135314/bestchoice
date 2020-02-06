package com.project.yhj.search;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class YhjSearchController {

	@Resource
	private YhjSearchService service ;
	
	@RequestMapping(value="/search/main.bc")
	public String searchMain(HttpServletRequest request, YhjSearchVO svo) {
		
		
		List<YhjSearchResultVO> hotelList = service.getHotelList(svo);
		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("searchVO", svo);
		
		
		return "yhj/search/searchMain.tiles1";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/search/mainJson.bc", produces="text/plain;charset=UTF-8")
	public String searchMainJSON(HttpServletRequest request, YhjSearchVO svo) {
		
		System.out.println("///////////////////////////////////////////////// json 시작 ///////////////////////////////////////////////////");
		
		String jsonStr = "";
		
		System.out.println(svo.getStartday());
		
		List<YhjSearchResultVO> hotelList = service.getHotelList(svo);
		
		if(hotelList != null) {
			
			JSONArray jsonArr = new JSONArray();
			
			for( YhjSearchResultVO srvo : hotelList) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("hotel_name", srvo.getHotel_name());
				jsonObj.put("hotel_geo_x", srvo.getHotel_geo_x() );
				jsonObj.put("hotel_geo_y", srvo.getHotel_geo_y() );
				
				jsonArr.put(jsonObj);
			}
			
			jsonStr = jsonArr.toString();
			
		}
		
		return jsonStr;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/search/autoComplete.bc", produces="text/plain;charset=UTF-8")
	public String autoComplete(HttpServletRequest request) {
		
		String jsonStr = "";
		
		String searchWord = request.getParameter("searchWord");
		// searchWord = searchWord.replaceAll(" ", "");	

		List<String> autoList = service.getAutoCompleteList(searchWord);
		
		JSONArray jsonArr = new JSONArray();
		if( autoList != null) {
			
			for( String str : autoList ) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("string", str);
				
				jsonArr.put(jsonObj);
			}
			jsonStr = jsonArr.toString();
		}
		return jsonStr;
	}
	
	
	
} // end of controller ----------------------------------------------
