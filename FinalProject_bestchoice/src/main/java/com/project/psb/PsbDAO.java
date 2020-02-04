package com.project.psb;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dws.DwoReservationVO;
import com.project.kmt.KmtHotelInfoVO;
import com.project.kmt.KmtSellerMemberVO;
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

	public int getMemberPoint(String member_idx) {
		int memberPoint = sqlsession.selectOne("psbMapper.getMemberPoint",member_idx);
		return memberPoint;
	}

	public int memberPointUpdate(String member_idx,int memberPoint) {
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		paraMap.put("member_idx", member_idx);
		paraMap.put("memberPoint", memberPoint);
		
		int n = sqlsession.update("psbMapper.memberPointUpdate", paraMap);
		return n ;
	}

	public int memberPointInsert(String member_idx, int memberPoint) {
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		paraMap.put("member_idx", member_idx);
		paraMap.put("memberPoint", memberPoint);
		
		int n = sqlsession.insert("psbMapper.memberPointInsert", paraMap);
		return n ;
	}

	public List<String> wordSellerSearchShow(String fk_sellerName) {
		List<String> wordList = sqlsession.selectList("psbMapper.wordSellerSearchShow", fk_sellerName);
		return wordList;
	}

	public List<String> wordHotelSearchShow(String fk_hotelName) {
		List<String> wordList = sqlsession.selectList("psbMapper.wordHotelSearchShow", fk_hotelName);
		return wordList;
	}

	public String getlastDate(String member_idx) {
		String lastDate = sqlsession.selectOne("psbMapper.getlastDate",member_idx);
		return lastDate;
	}

	public int total_Price() {
		int total_Price = sqlsession.selectOne("psbMapper.total_Price");
		return total_Price;
	}
	
	public int last_yearPrice() {
		int last_yearPrice = sqlsession.selectOne("psbMapper.last_yearPrice");
		return last_yearPrice;
	}

	public int yearPrice() {
		int yearPrice = sqlsession.selectOne("psbMapper.yearPrice");
		return yearPrice;
	}

	public int monthPrice() {
		int monthPrice = sqlsession.selectOne("psbMapper.monthPrice");
		return monthPrice;
	}

	public int dayPrice() {
		int dayPrice = sqlsession.selectOne("psbMapper.dayPrice");
		return dayPrice;
	}

	public int searchPrice(HashMap<String,String> paraMap) {
		int searchPrice = sqlsession.selectOne("psbMapper.searchPrice",paraMap);
		return searchPrice;
	}

	public List<HashMap<String, Object>> chart_MonthlyPrice() {
		List<HashMap<String, Object>> montlyPriceList = sqlsession.selectList("psbMapper.chart_MonthlyPrice");
		return montlyPriceList;
	}

	public List<HashMap<String, Object>> sales_gender() {
		List<HashMap<String, Object>> paraMap = sqlsession.selectList("psbMapper.sales_gender");
		return paraMap;
	}

	public List<HashMap<String, Object>> sales_age() {
		List<HashMap<String, Object>> paraMap = sqlsession.selectList("psbMapper.sales_age");
		return paraMap;
	}


	public List<HashMap<String, Object>> sales_grade() {
		List<HashMap<String, Object>> paraMap = sqlsession.selectList("psbMapper.sales_grade");
		return paraMap;
	}

	public List<HashMap<String, Object>> sales_addr() {
		List<HashMap<String, Object>> paraMap = sqlsession.selectList("psbMapper.sales_addr");
		return paraMap;
	}
	
	/////////////////////////////////////////////////////////////////////////// 판매자
	public int getTotalCountSeller(HashMap<String, Object> paraMap) {
		int count = sqlsession.selectOne("psbMapper.getTotalCountSeller", paraMap);
		return count;
	}

	public int getTotalSeller() {
		int count = sqlsession.selectOne("psbMapper.getTotalSeller");
		return count;
	}

	public List<KmtSellerMemberVO> sellerListWithPaging(HashMap<String, Object> paraMap) {
		List<KmtSellerMemberVO> sellerList = sqlsession.selectList("psbMapper.sellerListWithPaging", paraMap);
		return sellerList;
	}

	public KmtSellerMemberVO getOneSeller(String seller_idx) {
		KmtSellerMemberVO sellervo = sqlsession.selectOne("psbMapper.getOneSeller", seller_idx);
		return sellervo;
	}

	public int getHotelCount(String seller_idx) {
		int count = sqlsession.selectOne("psbMapper.getHotelCount", seller_idx);
		return count;
	}

	public int updateSellerStatus(String seller_idx) {
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		paraMap.put("seller_idx", seller_idx);
		
		int n = sqlsession.update("psbMapper.updateSellerStatus", paraMap);
		return n;
	}

	public List<BoardVO> getSellerBoardList(String seller_Name) {
		List<BoardVO> sellerBoardList = sqlsession.selectList("psbMapper.getSellerBoardList", seller_Name);
		return sellerBoardList;
	}

	public List<HashMap<String, Object>> chart_SellerMonthlyPrice(String seller_idx) {
		List<HashMap<String, Object>> montlyPriceList = sqlsession.selectList("psbMapper.chart_SellerMonthlyPrice",seller_idx);
		return montlyPriceList;
	}

	public List<String> getHotelArr(String seller_idx) {
		List<String> hotel_idx_Arr = sqlsession.selectList("psbMapper.getHotelArr", seller_idx);
		return hotel_idx_Arr;
	}

	public int stopSellerStatus(String seller_idx) {
		int n = sqlsession.update("psbMapper.stopSellerStatus", seller_idx);
		return n;
	}

	/////////////////////////////////////////////////////////////////////////// 호텔
	
	public int getTotalCountHotel(HashMap<String, Object> paraMap) {
		int count = sqlsession.selectOne("psbMapper.getTotalCountHotel", paraMap);
		return count;
	}

	public int getTotalHotel() {
		int count = sqlsession.selectOne("psbMapper.getTotalHotel");
		return count;
	}

	public List<KmtHotelInfoVO> hotelListWithPaging(HashMap<String, Object> paraMap) {
		List<KmtHotelInfoVO> hotelList = sqlsession.selectList("psbMapper.hotelListWithPaging", paraMap);
		return hotelList;
	}

	public KmtHotelInfoVO getOneHotel(String hotel_idx) {
		KmtHotelInfoVO hotelvo = sqlsession.selectOne("psbMapper.getOneHotel", hotel_idx);
		return hotelvo;
	}

	public int getRoomCount(String hotel_idx) {
		int count = sqlsession.selectOne("psbMapper.getRoomCount", hotel_idx);
		return count;
	}

	public List<BoardVO> getHotelBoardList(String hotel_Name) {
		List<BoardVO> hotelBoardList = sqlsession.selectList("psbMapper.getHotelBoardList", hotel_Name);
		return hotelBoardList;
	}

	
	public int updateHotelStatus(String[] hotel_idx) {
		HashMap<String,Object> paraMap = new HashMap<String,Object>();
		paraMap.put("hotel_idx", hotel_idx);
		int n = sqlsession.update("psbMapper.updateHotelStatus", paraMap);
		return n;
	}

	public int stopHotelStatus(String[] hotel_idx) {
		HashMap<String,Object> paraMap = new HashMap<String,Object>();
		paraMap.put("hotel_idx", hotel_idx);
		int n = sqlsession.update("psbMapper.stopHotelStatus", paraMap);
		return n;
	}

	public List<HashMap<String, Object>> chart_HotelMonthlyPrice(String hotel_idx) {
		List<HashMap<String, Object>> montlyPriceList = sqlsession.selectList("psbMapper.chart_HotelMonthlyPrice",hotel_idx);
		return montlyPriceList;
	}

	public List<HashMap<String, String>> chartHotelLocation() {
		List<HashMap<String, String>> hotelCountList = sqlsession.selectList("psbMapper.chartHotelLocation");
		return hotelCountList;
	}

	public List<HashMap<String, String>> chartHotelGrade() {
		List<HashMap<String, String>> hotelCountList = sqlsession.selectList("psbMapper.chartHotelGrade");
		return hotelCountList;
	}

	public int getSellerStatus(String hotel_idxStr) {
		int m  = sqlsession.selectOne("psbMapper.getSellerStatus",hotel_idxStr);
		return m;
	}

	public String getSellerIdx(String hotel_idxStr) {
		String idx = sqlsession.selectOne("psbMapper.getSellerIdx",hotel_idxStr);
		return idx;
	}

	/////////////////////////////////////////////////////////////////////////// 예약 리스트 
	
	public List<DwoReservationVO> reserveListWithPaging(HashMap<String, Object> paraMap) {
		List<DwoReservationVO> resrveList = sqlsession.selectList("psbMapper.reserveListWithPaging", paraMap);
		return resrveList;
	}

	public int getTotalCountRserve(HashMap<String, Object> paraMap) {
		int count = sqlsession.selectOne("psbMapper.getTotalCountRserve", paraMap);
		return count;
	}

	public int getTotalReserve() {
		int count = sqlsession.selectOne("psbMapper.getTotalReserve");
		return count;
	}

	public int getEndPay() {
		int n = sqlsession.selectOne("psbMapper.getEndPay");
		return n;
	}

	

	


}
