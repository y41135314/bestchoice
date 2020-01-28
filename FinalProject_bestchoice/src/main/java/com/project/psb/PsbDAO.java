package com.project.psb;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.smh.SmhMemberVO;

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

	public int addComment(CommentVO commentvo) {
		int n = sqlsession.insert("psbMapper.addComment", commentvo);
		return n;
	}

	public int updateCount(String fk_parentIdx) {
		int n = sqlsession.update("psbMapper.updateCommentCount", fk_parentIdx);
		return n;
	}

	public List<CommentVO> getCommentList(String fk_parentIdx) {
		List<CommentVO> commentvo = sqlsession.selectList("psbMapper.getCommentList", fk_parentIdx);
		return commentvo;
	}

	public int adDelComment(String adminComment_idx) {
		int n = sqlsession.delete("psbMapper.adDelComment", adminComment_idx);
		return n;
	}

	public CommentVO getViewComment(String adminComment_idx) {
		CommentVO commentvo = sqlsession.selectOne("psbMapper.getViewComment", adminComment_idx);
		return commentvo;
	}

	public int minusCount(String fk_parentIdx) {
		int n = sqlsession.update("psbMapper.minusCount", fk_parentIdx);
		return n;
	}

	public int updateComment(HashMap<String,String> paraMap) {
		int n = sqlsession.update("psbMapper.updateComment", paraMap);
		return n;
	}

	////////////////////////////////////////////////////////////////////////// 회원 
	
	public int getTotalCountMember(HashMap<String, Object> paraMap) {
		int count = sqlsession.selectOne("psbMapper.getTotalCountMember", paraMap);
		return count;
	}

	public int getTotalMember() {
		int count = sqlsession.selectOne("psbMapper.getTotalMember");
		return count;
	}

	public List<SmhMemberVO> memberListWithPaging(HashMap<String, Object> paraMap) {
		List<SmhMemberVO> memberList = sqlsession.selectList("psbMapper.memberListWithPaging", paraMap);
		return memberList;
	}

	public SmhMemberVO getOneMember(String member_idx) {
		SmhMemberVO membervo = sqlsession.selectOne("psbMapper.getOneMember", member_idx);
		return membervo;
	}

	public List<HashMap<String, String>> chartMemberCount() {
		List<HashMap<String, String>> memberCountList = sqlsession.selectList("psbMapper.chartMemberCount");
		return memberCountList;
	}

	public List<HashMap<String, String>> chartMemberTrend() {
		List<HashMap<String, String>> memberCountList = sqlsession.selectList("psbMapper.chartMemberTrend");
		return memberCountList;
	}


}
