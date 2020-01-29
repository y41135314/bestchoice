package com.project.kmt;

public class KmtHotelImageVO {
	
	private int hotelImage_Number;		// 이미지넘버 (시퀀스)
	private int fk_hotel_idx;			// 호텔코드 (foreign key)
	private String hotelImage_FileName;	// 원래 이미지파일네임
	private String hotelImage_wasFileName; // WAS 변환 이미지파일네임
	
	
	public KmtHotelImageVO() {}
	
	public KmtHotelImageVO(int hotelImage_Number, int fk_hotel_idx, String hotelImage_FileName,
			String hotelImage_wasFileName) {
	
		super();
		this.hotelImage_Number = hotelImage_Number;
		this.fk_hotel_idx = fk_hotel_idx;
		this.hotelImage_FileName = hotelImage_FileName;
		this.hotelImage_wasFileName = hotelImage_wasFileName;
	}


	public int getHotelImage_Number() {
		return hotelImage_Number;
	}


	public void setHotelImage_Number(int hotelImage_Number) {
		this.hotelImage_Number = hotelImage_Number;
	}


	public int getFk_hotel_idx() {
		return fk_hotel_idx;
	}


	public void setFk_hotel_idx(int fk_hotel_idx) {
		this.fk_hotel_idx = fk_hotel_idx;
	}


	public String getHotelImage_FileName() {
		return hotelImage_FileName;
	}


	public void setHotelImage_FileName(String hotelImage_FileName) {
		this.hotelImage_FileName = hotelImage_FileName;
	}


	public String getHotelImage_wasFileName() {
		return hotelImage_wasFileName;
	}


	public void setHotelImage_wasFileName(String hotelImage_wasFileName) {
		this.hotelImage_wasFileName = hotelImage_wasFileName;
	}
	
	
	
	
	
}
