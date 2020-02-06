package com.project.yhj.search;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class YhjSearchDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;


	// 호텔 리스트 받아오기
	public List<YhjSearchResultVO> getHotelList(YhjSearchVO svo) {

		List<YhjSearchResultVO> hotelList = sqlsession.selectList("yhjMapper.getHotelList", svo);
		return hotelList;
	}

	// 자동 완성 검색어 가져오기
	public List<String> getAutoCompleteList(String searchWord) {

		List<String> autoList = sqlsession.selectList("yhjMapper.getAutoCompleteList", searchWord);
		return autoList;
	}

	
	
	
}
