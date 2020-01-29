package com.project.yhj.faq;

public class YhjMemberFaqVO {

	private String no;				// 글번호
	private String fk_idx;			//  fk_회원번호
	private String type ;			//  문의유형 ( 1:이벤트 , 2:예약/결제 , 3:이용문의 , 4:회원정보 , 5:리뷰 , 6:기타 )
	private String phone ;			//  문의휴대폰
	private String content ;		//  문의내용 ( 네이버 에디터 사용 안함 )
	private String writeday ;		//  등록일
	private String status ;			//  상태 ( 0: 삭제됨, 1: 존재함 )
	
	
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getFk_idx() {
		return fk_idx;
	}
	public void setFk_idx(String fk_idx) {
		this.fk_idx = fk_idx;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
} // end of class ------------------------------
