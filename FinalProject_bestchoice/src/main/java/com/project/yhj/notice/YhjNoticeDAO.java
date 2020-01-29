package com.project.yhj.notice;


import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class YhjNoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 공지사항글 전체 갯수 가져오기
	public int getNoticeTotalCount() {

		int n = sqlsession.selectOne("yhjMapper.getNoticeTotalCount");
		return n;
	}

	// 공지사항 글 범위에 맞게 가져오기
	public List<YhjNoticeVO> getNoticeList(HashMap<String, String> paraMap) {

		List<YhjNoticeVO> noticeList = sqlsession.selectList("yhjMapper.getNoticeList", paraMap);
		return noticeList;
	}

	// 공지사항 글 하나 가져오기
	public YhjNoticeVO getOneNotice(String no) {

		YhjNoticeVO nvo = sqlsession.selectOne("yhjMapper.getOneNotice", no);
		return nvo;
	}

	// 공지사항 글 삽입하기
	public int writeOneNotice(YhjNoticeVO nvo) {

		int n = sqlsession.insert("yhjMapper.writeOneNotice", nvo);
		return n;
	}

	// 공지사항 글 수정하기
	public int reviseOneNotice(YhjNoticeVO nvo) {

		int n = sqlsession.update("yhjMapper.reviseOneNotice", nvo);
		return n;
	}

	// 공지사항 삭제하기
	public int noticeDelete(String no) {

		int n = sqlsession.update("yhjMapper.noticeDelete", no);
		return n;
	}

	
	
	
}
