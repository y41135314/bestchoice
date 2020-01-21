package com.project.psb;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class PsbDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	public AdminVO getLoginAdmin(HashMap<String, String> paraMap) {
		AdminVO loginadmin = sqlsession.selectOne("psbMapper.getLoginAdmin",paraMap);
		return loginadmin;
	}

	public int getGroupnoMax() {
		int max = sqlsession.selectOne("psbMapper.getGroupnoMax");
		return max;
	}

	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("psbMapper.add", boardvo);
		return n;
	}

	public int add_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("psbMapper.add_withFile", boardvo);
		return n;
	}

	public int getTotalCountWithNoSearch() {
		int count = sqlsession.selectOne("psbMapper.getTotalCountWithNoSearch");
		return count;
	}

	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = sqlsession.selectOne("psbMapper.getTotalCountWithSearch", paraMap);
		return count;
	}

	public List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("psbMapper.boardListWithPaging", paraMap);
		return boardList;
	}

	public BoardVO getView(String adminBoard_idx) {
		BoardVO boardvo = sqlsession.selectOne("psbMapper.getView", adminBoard_idx);
		return boardvo;
	}

	public int edit(BoardVO boardvo) {
		int n = sqlsession.update("psbMapper.edit",boardvo);
		return n;
	}

	public int edit_withFile(BoardVO boardvo) {
		int n = sqlsession.update("psbMapper.edit_withFile",boardvo);
		return n;
	}

	public int fileDel(String adminBoard_idx) {
		int n = sqlsession.update("psbMapper.fileDel",adminBoard_idx);
		return n;
	}

	public int adBoardDel(BoardVO boardvo) {
		int n = sqlsession.update("psbMapper.adBoardDel",boardvo);
		return n;
	}


}
