package com.project.psb;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PsbService {

	@Autowired
	private PsbDAO dao ;

	public AdminVO getLoginAdmin(HashMap<String, String> paraMap) {
		AdminVO loginadmin = dao.getLoginAdmin(paraMap);
		return loginadmin;
	}

	public int add(BoardVO boardvo) {
		if( boardvo.getFk_seq() == null || boardvo.getFk_seq().trim().isEmpty()) {
			
			 // 원글쓰기인 경우  ==> groupno 값이 넘어오지 않으므로, groupno 컬럼의 최대값을 구하는 메소드를 만든다.
			int groupno = dao.getGroupnoMax()+1; // tblBoard 테이블에서 groupno 컬럼의 최대값 구하기
			boardvo.setGroupno( String.valueOf(groupno));
		} 
		int n =dao.add(boardvo);	
		return n;		
		
	}

	public int add_withFile(BoardVO boardvo) {
				
		// == 원글쓰기인지, 답변글쓰기인지 구분하기 == 
		if(boardvo.getFk_seq() == null || boardvo.getFk_seq().trim().isEmpty() ) {  
			// 원글쓰기인 경우
			int groupno = dao.getGroupnoMax()+1;
			boardvo.setGroupno(String.valueOf(groupno));
		}			
		int n = dao.add_withFile(boardvo); // 첨부파일이 있는 경우 
		return n;
		
	}

	public int getTotalCountWithNoSearch() {
		int count = dao.getTotalCountWithNoSearch();
		return count;
	}

	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int count = dao.getTotalCountWithSearch(paraMap);
		return count;
	}

	public List<BoardVO> boardListWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListWithPaging(paraMap);
		return boardList;
	}

	public BoardVO getViewWithNoAddCount(String adminBoard_idx) {
		BoardVO boardvo = dao.getView(adminBoard_idx);
		return boardvo;
	}

	public int edit(BoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	public int edit_withFile(BoardVO boardvo) {
		int n = dao.edit_withFile(boardvo);
		return n;
	}

	public int fileDel(String adminBoard_idx) {
		int n = dao.fileDel(adminBoard_idx);
		return n;
	}

	public int adBoardDel(BoardVO boardvo) {
		int n = dao.adBoardDel(boardvo);
		return n;
	}
	
}
