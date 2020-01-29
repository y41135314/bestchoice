package com.project.yhj.notice;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class YhjNoticeService {

	@Resource
	private YhjNoticeDAO dao ;

	// 공지사항글 전체 갯수 가져오기
	public int getNoticeTotalCount() {

		int n = dao.getNoticeTotalCount();
		return n;
	}

	// 공지사항 글 범위에 맞게 가져오기
	public List<YhjNoticeVO> getNoticeList(HashMap<String, String> paraMap) {

		List<YhjNoticeVO> noticeList = dao.getNoticeList(paraMap);
		return noticeList;
	}

	// 공지사항 글 하나 가져오기
	public YhjNoticeVO getOneNotice(String no) {

		YhjNoticeVO nvo = dao.getOneNotice(no);
		return nvo;
	}

	// 공지사항 insert 하기
	public int writeOneNotice(YhjNoticeVO nvo) {

		int n = dao.writeOneNotice(nvo);
		return n;
	}

	// 공지사항 글 수정하기
	public int reviseOneNotice(YhjNoticeVO nvo) {

		int n = dao.reviseOneNotice(nvo);
		return n;
	}

	// 공지사항 글 삭제하기
	public int noticeDelete(String no) {

		int n = dao.noticeDelete(no);
		return n;
	}

	
}
