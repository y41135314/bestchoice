package com.project.kmt;

public class KmtSellerMemberVO {
	private String seller_Id;		// 판매자 아이디
	private int seller_idx;			// 회원넘버
	private String seller_Pwd;		// 비밀번호
	private String seller_Name;		// 사업자명
	private String seller_No;		// 사업자번호
	private String seller_Regday;	// 사업자등록신청일
	private String seller_Phone;		// 사업자대표전화번호
	private String seller_Mobile;		// 사업자휴대전화
	private String seller_Addr;		// 사업자소재지(주소)
	private String seller_Post;		// 우편번호
	private String seller_RepName;	// 대표자명
	private String seller_homepage; // 홈페이지주소
	private int seller_Form;		// 사업형태 (1.개인법인 2.단체법인...)
	private String seller_Item;		// 취급품목 (호텔, 모텔 등등 default 는 호텔)
	private String seller_registerday;	// 여기는어때 가입일
	private int seller_realStatus;	// 여기는어때 내에서 활성화(1) 비활성화(0) default는 0 
	
	public KmtSellerMemberVO() {}
	
	public KmtSellerMemberVO(String seller_Id, int seller_idx, String seller_Pwd, String seller_Name, String seller_No,
			String seller_Regday, String seller_Phone, String seller_Mobile, String seller_Addr, String seller_Post,
			String seller_RepName, String seller_homepage, int seller_Form, String seller_Item,
			String seller_registerday, int seller_realStatus) {

		super();
		this.seller_Id = seller_Id;
		this.seller_idx = seller_idx;
		this.seller_Pwd = seller_Pwd;
		this.seller_Name = seller_Name;
		this.seller_No = seller_No;
		this.seller_Regday = seller_Regday;
		this.seller_Phone = seller_Phone;
		this.seller_Mobile = seller_Mobile;
		this.seller_Addr = seller_Addr;
		this.seller_Post = seller_Post;
		this.seller_RepName = seller_RepName;
		this.seller_homepage = seller_homepage;
		this.seller_Form = seller_Form;
		this.seller_Item = seller_Item;
		this.seller_registerday = seller_registerday;
		this.seller_realStatus = seller_realStatus;
	}

	public String getSeller_Id() {
		return seller_Id;
	}

	public void setSeller_Id(String seller_Id) {
		this.seller_Id = seller_Id;
	}

	public int getSeller_idx() {
		return seller_idx;
	}

	public void setSeller_idx(int seller_idx) {
		this.seller_idx = seller_idx;
	}

	public String getSeller_Pwd() {
		return seller_Pwd;
	}

	public void setSeller_Pwd(String seller_Pwd) {
		this.seller_Pwd = seller_Pwd;
	}

	public String getSeller_Name() {
		return seller_Name;
	}

	public void setSeller_Name(String seller_Name) {
		this.seller_Name = seller_Name;
	}

	public String getSeller_No() {
		return seller_No;
	}

	public void setSeller_No(String seller_No) {
		this.seller_No = seller_No;
	}

	public String getSeller_Regday() {
		return seller_Regday;
	}

	public void setSeller_Regday(String seller_Regday) {
		this.seller_Regday = seller_Regday;
	}

	public String getSeller_Phone() {
		return seller_Phone;
	}

	public void setSeller_Phone(String seller_Phone) {
		this.seller_Phone = seller_Phone;
	}

	public String getSeller_Mobile() {
		return seller_Mobile;
	}

	public void setSeller_Mobile(String seller_Mobile) {
		this.seller_Mobile = seller_Mobile;
	}

	public String getSeller_Addr() {
		return seller_Addr;
	}

	public void setSeller_Addr(String seller_Addr) {
		this.seller_Addr = seller_Addr;
	}

	public String getSeller_Post() {
		return seller_Post;
	}

	public void setSeller_Post(String seller_Post) {
		this.seller_Post = seller_Post;
	}

	public String getSeller_RepName() {
		return seller_RepName;
	}

	public void setSeller_RepName(String seller_RepName) {
		this.seller_RepName = seller_RepName;
	}

	public String getSeller_homepage() {
		return seller_homepage;
	}

	public void setSeller_homepage(String seller_homepage) {
		this.seller_homepage = seller_homepage;
	}

	public int getSeller_Form() {
		return seller_Form;
	}

	public void setSeller_Form(int seller_Form) {
		this.seller_Form = seller_Form;
	}

	public String getSeller_Item() {
		return seller_Item;
	}

	public void setSeller_Item(String seller_Item) {
		this.seller_Item = seller_Item;
	}

	public String getSeller_registerday() {
		return seller_registerday;
	}

	public void setSeller_registerday(String seller_registerday) {
		this.seller_registerday = seller_registerday;
	}

	public int getSeller_realStatus() {
		return seller_realStatus;
	}

	public void setSeller_realStatus(int seller_realStatus) {
		this.seller_realStatus = seller_realStatus;
	}
	
	
	////////////////////////////////////////// 추가 
	private int totalPrice;
	private int totalCount;


		public int getTotalPrice() {
			return totalPrice;
		}
		
		public void setTotalPrice(int totalPrice) {
			this.totalPrice = totalPrice;
		}
		
		public int getTotalCount() {
			return totalCount;
		}
		
		public void setTotalCount(int totalCount) {
			this.totalCount = totalCount;
		}
	//////////////////////////////////////////
	
	
	
	
}
