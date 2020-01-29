package com.project.kmt;

public class KmtHotelInfoVO {
	
	private int hotel_idx;				// 호텔코드(시퀀스)
	private String hotel_name;			// 호텔명
	private int hotel_Category; 		// 호텔유형 (1은 호텔 2는모텔 3은 리조트 등등)
	private int hotel_Grade;			// 호텔등급 (5는 5성급, 4는 4성급...)
	private String hotel_Addr1;			// 호텔주소 ( 시 / 도 )
	private String hotel_Addr2;			// 호텔주소 ( 구 / 군  / 면)
	private String hotel_Addr3;			// 호텔주소 ( 상세주소  )
	private int hotel_Post;				// 호텔 우편번호
	private String hotel_RepName;		// 호텔 대표자명
	private String hotel_Homepage;		// 호텔 홈페이지주소
	private int hotel_Status;			// 호텔 상태 (1은 영업중 0은 비활성화 default는 0)
	private String hotel_registerday;	// 호텔 등록일 (default 는 sysdate)
	private int hotel_Phone;			// 호텔 대표전화번호
	private int hotel_Fax;				// 호텔 대표팩스번호
	private String hotel_Email;			// 호텔 대표이메일
	private String hotel_GEO;			// 호텔 (위,경도) 위치
	private String fk_seller_Id;		// (foreign key) 판매자아이디
			
	public KmtHotelInfoVO() {}
	
	public KmtHotelInfoVO(int hotel_idx, String hotel_name, int hotel_Category, int hotel_Grade, String hotel_Addr1,
			String hotel_Addr2, String hotel_Addr3, int hotel_Post, String hotel_RepName, String hotel_Homepage,
			int hotel_Status, String hotel_registerday, int hotel_Phone, int hotel_Fax, String hotel_Email,
			String hotel_GEO, String fk_seller_Id) {
		super();
		this.hotel_idx = hotel_idx;
		this.hotel_name = hotel_name;
		this.hotel_Category = hotel_Category;
		this.hotel_Grade = hotel_Grade;
		this.hotel_Addr1 = hotel_Addr1;
		this.hotel_Addr2 = hotel_Addr2;
		this.hotel_Addr3 = hotel_Addr3;
		this.hotel_Post = hotel_Post;
		this.hotel_RepName = hotel_RepName;
		this.hotel_Homepage = hotel_Homepage;
		this.hotel_Status = hotel_Status;
		this.hotel_registerday = hotel_registerday;
		this.hotel_Phone = hotel_Phone;
		this.hotel_Fax = hotel_Fax;
		this.hotel_Email = hotel_Email;
		this.hotel_GEO = hotel_GEO;
		this.fk_seller_Id = fk_seller_Id;
	}

	public int getHotel_idx() {
		return hotel_idx;
	}

	public void setHotel_idx(int hotel_idx) {
		this.hotel_idx = hotel_idx;
	}

	public String getHotel_name() {
		return hotel_name;
	}

	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}

	public int getHotel_Category() {
		return hotel_Category;
	}

	public void setHotel_Category(int hotel_Category) {
		this.hotel_Category = hotel_Category;
	}

	public int getHotel_Grade() {
		return hotel_Grade;
	}

	public void setHotel_Grade(int hotel_Grade) {
		this.hotel_Grade = hotel_Grade;
	}

	public String getHotel_Addr1() {
		return hotel_Addr1;
	}

	public void setHotel_Addr1(String hotel_Addr1) {
		this.hotel_Addr1 = hotel_Addr1;
	}

	public String getHotel_Addr2() {
		return hotel_Addr2;
	}

	public void setHotel_Addr2(String hotel_Addr2) {
		this.hotel_Addr2 = hotel_Addr2;
	}

	public String getHotel_Addr3() {
		return hotel_Addr3;
	}

	public void setHotel_Addr3(String hotel_Addr3) {
		this.hotel_Addr3 = hotel_Addr3;
	}

	public int getHotel_Post() {
		return hotel_Post;
	}

	public void setHotel_Post(int hotel_Post) {
		this.hotel_Post = hotel_Post;
	}

	public String getHotel_RepName() {
		return hotel_RepName;
	}

	public void setHotel_RepName(String hotel_RepName) {
		this.hotel_RepName = hotel_RepName;
	}

	public String getHotel_Homepage() {
		return hotel_Homepage;
	}

	public void setHotel_Homepage(String hotel_Homepage) {
		this.hotel_Homepage = hotel_Homepage;
	}

	public int getHotel_Status() {
		return hotel_Status;
	}

	public void setHotel_Status(int hotel_Status) {
		this.hotel_Status = hotel_Status;
	}

	public String getHotel_registerday() {
		return hotel_registerday;
	}

	public void setHotel_registerday(String hotel_registerday) {
		this.hotel_registerday = hotel_registerday;
	}

	public int getHotel_Phone() {
		return hotel_Phone;
	}

	public void setHotel_Phone(int hotel_Phone) {
		this.hotel_Phone = hotel_Phone;
	}

	public int getHotel_Fax() {
		return hotel_Fax;
	}

	public void setHotel_Fax(int hotel_Fax) {
		this.hotel_Fax = hotel_Fax;
	}

	public String getHotel_Email() {
		return hotel_Email;
	}

	public void setHotel_Email(String hotel_Email) {
		this.hotel_Email = hotel_Email;
	}

	public String getHotel_GEO() {
		return hotel_GEO;
	}

	public void setHotel_GEO(String hotel_GEO) {
		this.hotel_GEO = hotel_GEO;
	}

	public String getFk_seller_Id() {
		return fk_seller_Id;
	}

	public void setFk_seller_Id(String fk_seller_Id) {
		this.fk_seller_Id = fk_seller_Id;
	}

	
	
	
	
	
}