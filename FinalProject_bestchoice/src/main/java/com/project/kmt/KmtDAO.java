package com.project.kmt;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class KmtDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 아이디 찾아오기
	public int checkSellerId(String seller_Id) {

		int n = sqlsession.selectOne("kmtMapper.checkSellerId", seller_Id);
		return n;
	}

	// 판매자 회원가입
	public int registerSeller(KmtSellerMemberVO mvo) {

		int n = sqlsession.insert("kmtMapper.registerSeller", mvo);
		return n;
	}

	// 호텔 등록하기
	public int registerHotel(KmtHotelInfoVO hvo) {

		int n = sqlsession.insert("kmtMapper.registerHotel", hvo);
		return n;
	}

	// 호텔 idx 가져오기
	public String getHotelIdx(KmtHotelInfoVO hvo) {

		String n = sqlsession.selectOne("kmtMapper.getHotelIdx", hvo);
		return n;
	}

	// 호텔 이미지 등록하기
	public int insertHotelImage(HashMap<String, String> imageMap) {

		int n = sqlsession.insert("kmtMapper.insertHotelImage", imageMap);
		return n;
	}

	// 판매자 로그인하기
	public KmtSellerMemberVO sellerLogin(HashMap<String,String> paraMap) {

		KmtSellerMemberVO loginseller = sqlsession.selectOne("kmtMapper.sellerLogin", paraMap);
		return loginseller;
	}

	// 판매자 소유의 호텔 중 제일 처음 등록한 것 가져오기
	public String getFk_hotel_idx(String seller_id) {

		String fk_hotel_idx = sqlsession.selectOne("kmtMapper.getFk_hotel_idx", seller_id);
		return fk_hotel_idx;
	}

	// 특정 호텔의 가격 목록 읽어오기
	public List<HashMap<String, String>> getRoomPriceList(HashMap<String,String> paraMap) {

		List<HashMap<String, String>> roomPriceList = sqlsession.selectList("kmtMapper.getRoomPriceList", paraMap);
		return roomPriceList;
	}

	// 특정 유저의 소유 호텔 리스트 받아오기
	public List<HashMap<String, String>> getHotelListOfUser(String seller_Id) {

		List<HashMap<String, String>> sellerHotelList = sqlsession.selectList("kmtMapper.getHotelListOfUser", seller_Id);
		return sellerHotelList;
	}

	// 
	public int roomRegister(HashMap<String, String> paraMap) {

		int n = sqlsession.insert("kmtMapper.roomRegister", paraMap);
		return n;
	}

	public int spaRegister(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("kmtMapper.spaRegister", paraMap);
		return n;
	}

	public int themeRegister(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("kmtMapper.themeRegister", paraMap);
		return n;
	}

	public int bedRegister(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("kmtMapper.bedRegister", paraMap);
		return n;
	}

	public int serviceRegister(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("kmtMapper.serviceRegister", paraMap);
		return n;
	}

	public String getFk_Room_Idx(HashMap<String, String> paraMap) {
		String fk_room_idx = sqlsession.selectOne("kmtMapper.getFk_Room_Idx", paraMap);
		return fk_room_idx;
	}

	// 방 가격 새로 입력하기
	public int insertRoomPrice(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("kmtMapper.insertRoomPrice", paraMap);
		return n;
	}

	// 방 가격 수정하기
	public int updateRoomPrice(HashMap<String, String> paraMap) {
		int n = sqlsession.update("kmtMapper.updateRoomPrice", paraMap);
		return n;
	}

	
	
	
	
}
