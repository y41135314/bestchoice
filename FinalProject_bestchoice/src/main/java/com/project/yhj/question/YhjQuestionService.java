package com.project.yhj.question;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class YhjQuestionService {

	@Resource
	private YhjQuestionDAO dao ;

	// 자주묻는질문 카테고리로 목록 받아오기
	public List<YhjQuestionVO> getQuestionList(String category) {

		List<YhjQuestionVO> questionList = dao.getQuestionList(category);
		return questionList;
	}
	
	// 자주묻는질문 입력하기
	public int questionWrite(YhjQuestionVO qvo) {

		int n = dao.questionWrite(qvo);
		return n;
	}

	// 자주묻는질문 수정하기
	public int questionRevise(YhjQuestionVO qvo) {

		int n = dao.questionRevise(qvo);
		return n;
	}

	// 자주묻는질문 하나 가져오기
	public YhjQuestionVO getOneQuestion(String no) {

		YhjQuestionVO qvo = dao.getOneQuestion(no);
		return qvo;
	}

	// 자주묻는질문 하나 삭제하기
	public int questionDelete(String no) {

		int n = dao.questionDelete(no);
		return n;
	}


	
} // end of class --------------------------------------------
