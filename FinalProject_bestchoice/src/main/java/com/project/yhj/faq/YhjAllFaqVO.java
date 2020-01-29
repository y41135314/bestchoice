package com.project.yhj.faq;

public class YhjAllFaqVO {

	
	private String no ;				// 글번호
	private String fk_idx ;			// 회원 idx 
	private String type ;			// 문의유형 ( 1:이벤트 , 2:예약/결제 , 3:이용문의 , 4:회원정보 , 5:리뷰 , 6:기타 )
	private String phone ;			// 휴대폰 번호
	private String content ;		// 문의 내용
	private String writeday ;		// 등록일
	private String status ;			// 상태 ( 0: 삭제됨, 1: 존재함 )
	private String rep_no ;			// 답변 글번호
	private String rep_fk_no ;		// fk_faq글번호
	private String rep_admin_idx ;	// 관리자 idx
	private String rep_content ;	// 답변 내용
	private String rep_writeday ;	// 답변 날짜
	private String rep_status ;		// 답변 상태 ( 0: 삭제됨, 1: 존재함 )
	
	
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
	public String getRep_no() {
		return rep_no;
	}
	public void setRep_no(String rep_no) {
		this.rep_no = rep_no;
	}
	public String getRep_fk_no() {
		return rep_fk_no;
	}
	public void setRep_fk_no(String rep_fk_no) {
		this.rep_fk_no = rep_fk_no;
	}
	public String getRep_admin_idx() {
		return rep_admin_idx;
	}
	public void setRep_admin_idx(String rep_admin_idx) {
		this.rep_admin_idx = rep_admin_idx;
	}
	public String getRep_content() {
		return rep_content;
	}
	public void setRep_content(String rep_content) {
		this.rep_content = rep_content;
	}
	public String getRep_writeday() {
		return rep_writeday;
	}
	public void setRep_writeday(String rep_writeday) {
		this.rep_writeday = rep_writeday;
	}
	public String getRep_status() {
		return rep_status;
	}
	public void setRep_status(String rep_status) {
		this.rep_status = rep_status;
	}
	
	public String getType_str() {
		
		String type_num = this.type ;
		String result ="";
		
		switch (type_num) {
			case "1":
				result="이벤트";
				break;
			case "2":
				result="예약/결제";
				break;
			case "3":
				result="이용문의";			
				break;
			case "4":
				result="회원정보";
				break;
			case "5":
				result="리뷰";
				break;
			case "6":
				result="기타";
				break;
		}
		
		return result;
	}
	
	public String getContent_short() {
		
		String content_str = this.content;
		
		if(content_str.length() > 10) {
			
			content_str = content_str.substring(0, 10)+"....";
		}
		
		return content_str;
	}
	
	
	
	
} // end of class -------------------------------------
