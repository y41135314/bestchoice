package com.project.kmt;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class KmtService {

	@Resource
	private KmtDAO dao ;

	// 아이디 가져오기
	public int checkSellerId(String seller_Id) {
		
		System.out.println("~~~~~ Service : " + seller_Id); 
		
		int n = dao.checkSellerId(seller_Id);
		return n;
	}

	// 판매자 등록 후 호텔 등록하기
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int registerSellerNHotel(KmtSellerMemberVO mvo, KmtHotelInfoVO hvo, List<HashMap<String,String>> imageMapList) {

		int n = 0;
		
		try {
			n = dao.registerSeller(mvo);
			
				if( n==1) {
					
				hvo.setFk_seller_Id(mvo.getSeller_Id());
				n = dao.registerHotel(hvo);
				
				if( n==1 ) {
					
					String fk_hotel_idx = dao.getHotelIdx(hvo);
					System.out.println(fk_hotel_idx);
					
					for(int i = 0; i<imageMapList.size(); i++) {
						
						HashMap<String,String> imageMap = imageMapList.get(i);
						
						imageMap.put("fk_hotel_idx", fk_hotel_idx);
						n = dao.insertHotelImage(imageMap);
						
					} // end of for ------------
				}
			
			}
		}
		catch(Throwable e) {
			e.printStackTrace();
		}
		
		return n;
	}

	// 판매자 로그인하기
	public KmtSellerMemberVO sellerLogin(HashMap<String,String> paraMap) {

		KmtSellerMemberVO loginseller = dao.sellerLogin(paraMap);
		return loginseller;
	}

	// 판매자 소유의 호텔 중 제일 처음 등록한 것 가져오기
	public String getFk_hotel_idx(String seller_id) {

		String fk_hotel_idx = dao.getFk_hotel_idx(seller_id);
		return fk_hotel_idx;
	}

	// 특정 호텔의 방 유형 이름과 가격 불러오기
	public List<HashMap<String, String>> getRoomPriceList(HashMap<String,String> paraMap) {

		List<HashMap<String, String>> roomPriceList = dao.getRoomPriceList(paraMap);
		return roomPriceList;
	}

	// 특정 유저의 소유 호텔 리스트 받아오기
	public List<HashMap<String, String>> getHotelListOfUser(String seller_Id) {

		List<HashMap<String, String>> sellerHotelList = dao.getHotelListOfUser(seller_Id);
		return sellerHotelList;
	}

	// 특정 유저의 소유 호텔 객실 등록하기
	public int roomRegister(HashMap<String, String> paraMap) {

		int n = dao.roomRegister(paraMap);
		
		if(n==1) {
			
			String fk_room_idx = dao.getFk_Room_Idx(paraMap);
			
			if( fk_room_idx != null && !fk_room_idx.isEmpty()) {
				
				paraMap.put("fk_room_idx",fk_room_idx);
				
				n = dao.spaRegister(paraMap);
				n = dao.themeRegister(paraMap);
				n = dao.bedRegister(paraMap);
				n = dao.serviceRegister(paraMap);
			}
			
		}
		
		return n;
	}

	// 날짜에 따른 방값 조정하기
	public int adjustRoomPrice(HashMap<String, String> paraMap) {

		int n = 0;
		String roomprice_seqno = paraMap.get("roomprice_seqno");
		
		if(roomprice_seqno == null || "".equals(roomprice_seqno)) {		// insert 하기
			
			n = dao.insertRoomPrice(paraMap);
		}
		else {		// update 하기
			
			n =dao.updateRoomPrice(paraMap);
		}
		
		return n;
	}

	public String modifyHome(HashMap<String, String> paraMap) {
		
		return null;
	}

	// Home 에 정보 뿌려주기
	
	
	
	
}
