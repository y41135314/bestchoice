package com.project.yhj.question;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class YhjQuestionDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 자주묻는질문 카테고리로 목록 받아오기
	public List<YhjQuestionVO> getQuestionList(String category) {
		
		List<YhjQuestionVO> questionList = sqlsession.selectList("yhjMapper.getQuestionList", category);
		return questionList;
	}

	// 자주묻는질문 입력하기
	public int questionWrite(YhjQuestionVO qvo) {
		
		int n = sqlsession.insert("yhjMapper.questionWrite", qvo);
		return n;
	}

	// 자주묻는질문 수정하기
	public int questionRevise(YhjQuestionVO qvo) {
		
		int n = sqlsession.update("yhjMapper.questionRevise", qvo);
		return n;
	}

	// 자주묻는질문 하나 가져오기
	public YhjQuestionVO getOneQuestion(String no) {

		YhjQuestionVO qvo = sqlsession.selectOne("yhjMapper.getOneQuestion", no);
		return qvo;
	}

	// 자주묻는질문 하나 삭제하기
	public int questionDelete(String no) {

		int n = sqlsession.update("yhjMapper.questionDelete", no);
		return n;
	}


	
	
	
}
