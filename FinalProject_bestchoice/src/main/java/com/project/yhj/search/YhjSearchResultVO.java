package com.project.yhj.search;

public class YhjSearchResultVO {

	private String hotel_idx;					// 호텔 idx
	private String hotelImage_wasFileName ;		// 호텔 이미지명
	private String hotel_name;					// 호텔 이름
	private String hotel_Grade;					// 호텔 등급 ( 일반, 특급, 특1급 )
	private String gradePerHotel;				// 호텔별 평점
    private String roomprice;					// 호텔의 방 중에 최저 가격
    private String hotel_addr1;					// 호텔 주소 ( 시, 도 )
    private String hotel_geo_x;					// 호텔 위도 
    private String hotel_geo_y;					// 호텔 경도 
    
	public String getHotel_idx() {
		return hotel_idx;
	}
	public void setHotel_idx(String hotel_idx) {
		this.hotel_idx = hotel_idx;
	}
	public String getHotelImage_wasFileName() {
		return hotelImage_wasFileName;
	}
	public void setHotelImage_wasFileName(String hotelImage_wasFileName) {
		this.hotelImage_wasFileName = hotelImage_wasFileName;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getHotel_Grade() {
		return hotel_Grade;
	}
	public void setHotel_Grade(String hotel_Grade) {
		this.hotel_Grade = hotel_Grade;
	}
	public String getGradePerHotel() {
		return gradePerHotel;
	}
	public void setGradePerHotel(String gradePerHotel) {
		this.gradePerHotel = gradePerHotel;
	}
	public String getRoomprice() {
		return roomprice;
	}
	public void setRoomprice(String roomprice) {
		this.roomprice = roomprice;
	}
	public String getHotel_addr1() {
		return hotel_addr1;
	}
	public void setHotel_addr1(String hotel_addr1) {
		this.hotel_addr1 = hotel_addr1;
	}
	public String getHotel_geo_x() {
		return hotel_geo_x;
	}
	public void setHotel_geo_x(String hotel_geo_x) {
		this.hotel_geo_x = hotel_geo_x;
	}
	public String getHotel_geo_y() {
		return hotel_geo_y;
	}
	public void setHotel_geo_y(String hotel_geo_y) {
		this.hotel_geo_y = hotel_geo_y;
	}

	
	
	
	
	
	
	
	
} // end of class --------------------------------------------
