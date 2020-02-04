package com.project.kmt;

public class KmtRoomPriceVO {

	private int fk_room_idx;		// 방코드
	private int roomPrice_SeqNo;	// 방가격시퀀스넘버 (primary)
	private String roomPrice_Date;	// 방가격 날짜
	private int roomPrice;			// 방가격
	// 이렇게 해놓으면 연도 월 일 의 가격을 판매자가 직접 수정이 가능합니다. 그래서 방가격의 primary 키가 시퀀스 입니다. ( 예 :   1       방코드  	2020	02	13 	  50000) 
	
	public KmtRoomPriceVO() {}
	public KmtRoomPriceVO(int fk_room_idx, int roomPrice_SeqNo, String roomPrice_Date, int roomPrice) {
		super();
		this.fk_room_idx = fk_room_idx;
		this.roomPrice_SeqNo = roomPrice_SeqNo;
		this.roomPrice_Date = roomPrice_Date;

	}
	public int getFk_room_idx() {
		return fk_room_idx;
	}
	public void setFk_room_idx(int fk_room_idx) {
		this.fk_room_idx = fk_room_idx;
	}
	public int getRoomPrice_SeqNo() {
		return roomPrice_SeqNo;
	}
	public void setRoomPrice_SeqNo(int roomPrice_SeqNo) {
		this.roomPrice_SeqNo = roomPrice_SeqNo;
	}
	public String getRoomPrice_Date() {
		return roomPrice_Date;
	}
	public void setRoomPrice_Date(String roomPrice_Date) {
		this.roomPrice_Date = roomPrice_Date;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	
	
	
}
