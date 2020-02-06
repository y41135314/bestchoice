package com.project.yhj.search;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class YhjSearchService {

	@Resource
	private YhjSearchDAO dao ;


	// 호텔 리스트 받아오기
	public List<YhjSearchResultVO> getHotelList(YhjSearchVO svo) {

		List<YhjSearchResultVO> hotelList = dao.getHotelList(svo);
		return hotelList;
	}


	// 자동 완성 검색어
	public List<String> getAutoCompleteList(String searchWord) {

		List<String> autoList = dao.getAutoCompleteList(searchWord);
		return autoList;
	}

	
}
