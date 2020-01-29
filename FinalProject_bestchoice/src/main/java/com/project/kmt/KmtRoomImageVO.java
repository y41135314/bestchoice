package com.project.kmt;

public class KmtRoomImageVO {

	private int roomImage_Number;		// (시퀀스)객실정보이미지 넘버
	private String roomImage_FileName;	// 원래 이미지파일네임
	private String roomImage_wasFileName;	// WAS 변환 이미지파일명
	private int fk_room_idx;			// (foreignkey) 객실코드
	
	public KmtRoomImageVO() {}
	public KmtRoomImageVO(int roomImage_Number, String roomImage_FileName, String roomImage_wasFileName,
			int fk_room_idx) {
		super();
		this.roomImage_Number = roomImage_Number;
		this.roomImage_FileName = roomImage_FileName;
		this.roomImage_wasFileName = roomImage_wasFileName;
		this.fk_room_idx = fk_room_idx;
	}
	public int getRoomImage_Number() {
		return roomImage_Number;
	}
	public void setRoomImage_Number(int roomImage_Number) {
		this.roomImage_Number = roomImage_Number;
	}
	public String getRoomImage_FileName() {
		return roomImage_FileName;
	}
	public void setRoomImage_FileName(String roomImage_FileName) {
		this.roomImage_FileName = roomImage_FileName;
	}
	public String getRoomImage_wasFileName() {
		return roomImage_wasFileName;
	}
	public void setRoomImage_wasFileName(String roomImage_wasFileName) {
		this.roomImage_wasFileName = roomImage_wasFileName;
	}
	public int getFk_room_idx() {
		return fk_room_idx;
	}
	public void setFk_room_idx(int fk_room_idx) {
		this.fk_room_idx = fk_room_idx;
	}
	
	
	
}
