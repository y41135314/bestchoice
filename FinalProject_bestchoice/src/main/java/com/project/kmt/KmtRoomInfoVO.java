package com.project.kmt;

public class KmtRoomInfoVO {
	
	private int room_idx;				// (시퀀스,primary) 객실코드

	private String room_name;			// 방이름 (예: 오션뷰 디럭스 룸, 수퍼 패밀리 사이즈 룸 , 스탠다드 등등)
	private int room_CS;				// 방면적 (예: 25평 13평, 59m^2 등등..)
	private String room_CheckinTime;	// 체크인시간
	private String room_CheckoutTime; 	// 체크아웃시간
	private int room_Person;			// 방 수용 기본인원
	private int room_AddPerson;			// 최대 수용인원 
	private int room_AddPerCharge;		// 추가 수용인원당 추가금액
	private int fk_hotel_idx; 			// (foreignkey, 호텔코드)
	
	public KmtRoomInfoVO() {}
	public KmtRoomInfoVO(int room_idx, String room_name, int room_CS,
			String room_CheckinTime, String room_CheckoutTime, int room_Person, int room_AddPerson,
			int room_AddPerCharge, int fk_hotel_idx) {
		super();
		this.room_idx = room_idx;

		this.room_name = room_name;
		this.room_CS = room_CS;
		this.room_CheckinTime = room_CheckinTime;
		this.room_CheckoutTime = room_CheckoutTime;
		this.room_Person = room_Person;
		this.room_AddPerson = room_AddPerson;
		this.room_AddPerCharge = room_AddPerCharge;
		this.fk_hotel_idx = fk_hotel_idx;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getRoom_CS() {
		return room_CS;
	}
	public void setRoom_CS(int room_CS) {
		this.room_CS = room_CS;
	}
	public String getRoom_CheckinTime() {
		return room_CheckinTime;
	}
	public void setRoom_CheckinTime(String room_CheckinTime) {
		this.room_CheckinTime = room_CheckinTime;
	}
	public String getRoom_CheckoutTime() {
		return room_CheckoutTime;
	}
	public void setRoom_CheckoutTime(String room_CheckoutTime) {
		this.room_CheckoutTime = room_CheckoutTime;
	}
	public int getRoom_Person() {
		return room_Person;
	}
	public void setRoom_Person(int room_Person) {
		this.room_Person = room_Person;
	}
	public int getRoom_AddPerson() {
		return room_AddPerson;
	}
	public void setRoom_AddPerson(int room_AddPerson) {
		this.room_AddPerson = room_AddPerson;
	}
	public int getRoom_AddPerCharge() {
		return room_AddPerCharge;
	}
	public void setRoom_AddPerCharge(int room_AddPerCharge) {
		this.room_AddPerCharge = room_AddPerCharge;
	}
	public int getFk_hotel_idx() {
		return fk_hotel_idx;
	}
	public void setFk_hotel_idx(int fk_hotel_idx) {
		this.fk_hotel_idx = fk_hotel_idx;
	}
	
	
	
	
	
}
