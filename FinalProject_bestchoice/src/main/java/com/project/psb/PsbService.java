package com.project.psb;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.smh.SmhMemberVO;


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

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int addComment(CommentVO commentvo) {
		int result = 0;
		int n = 0;
		
		n = dao.addComment(commentvo); // tblComment(댓글) 테이블에 insert 
		
		if(n==1) {
			result = dao.updateCount(commentvo.getFk_parentIdx()); // tblBoard 테이블의 commentCount 컬럼 값을 1 증가 
		}
		
		return result;
	}

	public List<CommentVO> getCommentList(String fk_parentIdx) {
		List<CommentVO> commentList = dao.getCommentList(fk_parentIdx);
		return commentList;
	}

	public int adDelComment(String adminComment_idx, String fk_parentIdx) {
		int n = dao.adDelComment(adminComment_idx);
		if(n==1) {
			n = dao.minusCount(fk_parentIdx); // tblBoard 테이블의 commentCount 컬럼 값을 1 증가 
		}
		
		return n;
	}

	public CommentVO getViewComment(String adminComment_idx) {
		CommentVO commentvo = dao.getViewComment(adminComment_idx);
		return commentvo;
	}

	public int updateComment(String adminComment_idx, String content) {
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("adminComment_idx", adminComment_idx);
		paraMap.put("content",content);
		int n = dao.updateComment(paraMap);
		return n;
	}

	////////////////////////////////////////////////////////////////////////// 회원 
	
	public int getTotalCountMember(HashMap<String, Object> paraMap) {
		int count = dao.getTotalCountMember(paraMap);
		return count;
	}

	public int getTotalMember() {
		int count = dao.getTotalMember();
		return count;
	}

	public List<SmhMemberVO> memberListWithPaging(HashMap<String, Object> paraMap) {
		List<SmhMemberVO> memberList = dao.memberListWithPaging(paraMap);
		return memberList;
	}

	public SmhMemberVO getOneMember(String member_idx) {
		SmhMemberVO membervo = dao.getOneMember(member_idx);
		return membervo;
	}

	public List<HashMap<String, String>> chartMemberCount() {
		List<HashMap<String, String>> memberCountList = dao.chartMemberCount();
		return memberCountList;
	}

	public List<HashMap<String, String>> chartMemberTrend() {
		List<HashMap<String, String>> memberCountList = dao.chartMemberTrend();
		return memberCountList;
	}

	public int getMemberPoint(String member_idx) {
		int memberPoint = dao.getMemberPoint(member_idx); 
		return memberPoint;
	}

	public int memberPointUpdate(String member_idx,int memberPoint) {
		int n = dao.memberPointUpdate(member_idx, memberPoint);
		return n;
	}

	public int memberPointInsert(String member_idx, int memberPoint) {
		int n = dao.memberPointInsert(member_idx, memberPoint);
		return n;
	}

	public List<String> wordSellerSearchShow(String fk_sellerName) {
		List<String> wordList = dao.wordSellerSearchShow(fk_sellerName);
		return wordList;
	}

	public List<String> wordHotelSearchShow(String fk_hotelName) {
		List<String> wordList = dao.wordHotelSearchShow(fk_hotelName);
		return wordList;
	}

	public String getlastDate(String member_idx) {
		String lastDate = dao.getlastDate(member_idx);
		return lastDate;
	}

	public int total_Price() {
		int total_Price = dao.total_Price();
		return total_Price;
	}
	
	public int last_yearPrice() {
		int last_yearPrice = dao.last_yearPrice();
		return last_yearPrice;
	}

	public int yearPrice() {
		int yearPrice = dao.yearPrice();
		return yearPrice;
	}

	public int monthPrice() {
		int monthPrice = dao.monthPrice();
		return monthPrice;
	}

	public int dayPrice() {
		int dayPrice = dao.dayPrice();
		return dayPrice;
	}

	public int searchPrice(HashMap<String,String> paraMap) {
		int searchPrice = dao.searchPrice(paraMap);
		return searchPrice;
	}

	public List<HashMap<String, Object>> chart_MonthlyPrice() {
		List<HashMap<String, Object>> montlyPriceList = dao.chart_MonthlyPrice();
		return montlyPriceList;
	}

	public List<HashMap<String, Object>> sales_gender() {
		List<HashMap<String, Object>> paraMap = dao.sales_gender();
		return paraMap;
	}

	public List<HashMap<String, Object>> sales_age() {
		List<HashMap<String, Object>> paraMap = dao.sales_age();
		return paraMap;
	}

	
	
}
