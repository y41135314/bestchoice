package com.project.yhj.faq;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class YhjFaqService {

	@Resource
	private YhjFaqDAO dao ;

	// 회원 FAQ 등록하기
	public int insertMemberFaq(YhjMemberFaqVO fvo) {

		int n = dao.insertMemberFaq(fvo);
		return n;
	}

	// 회원 FAQ 전체 갯수 가져오기
	public int getFaqTotalCount(String fk_idx) {

		int n = dao.getFaqTotalCount(fk_idx);
		return n;
	}

	// 회원 FAQ 가져오기
	public List<YhjAllFaqVO> getFaqList(HashMap<String, String> paraMap) {

		List<YhjAllFaqVO> faqList = dao.getFaqList(paraMap);
		return faqList;
	}

	// 관리자 faq 전체 갯수 가져오기
	public int getFaqAdminTotalCount(HashMap<String, String> paraMap) {

		int n = dao.getFaqAdminTotalCount(paraMap);
		return n;
	}

	// 관리자 faq 가져오기
	public List<YhjAllFaqVO> getAdminFaqList(HashMap<String, String> paraMap) {

		List<YhjAllFaqVO> faqList = dao.getAdminFaqList(paraMap);
		return faqList;
	}

	// 관리자 faq 답변 등록하기
	public int writeFaqAdminReply(HashMap<String, String> paraMap) {

		int n = dao.writeFaqAdminReply(paraMap);
		return n;
	}



	
}
