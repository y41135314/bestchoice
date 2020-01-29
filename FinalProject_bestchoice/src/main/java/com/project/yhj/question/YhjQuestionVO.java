package com.project.yhj.question;

public class YhjQuestionVO {

	private String no ;				// 글번호
	private String fk_admin_idx  ;	//  fk_관리자번호
	private String category  ;		// 카테고리 ( 1: top7 , 2: 이용문의 , 3:예약취소, 4:결제/영수증 , 5:예약문의 , 6:쿠폰/포인트 , 7:회원정보 , 8:리뷰 )
	private String title  ;			//  글제목
	private String content  ;		//  글내용 ( 네이버 에디터 사용 안함 )
	private String writeday  ;		//  등록일
	private String reviseday  ;		//  수정일
	private String status  ;		//  글 상태 ( 0: 삭제됨, 1: 있음 )
	
	private String revise ; 		// 수정한다면 값이 있음.
	
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getFk_admin_idx() {
		return fk_admin_idx;
	}
	public void setFk_admin_idx(String fk_admin_idx) {
		this.fk_admin_idx = fk_admin_idx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getReviseday() {
		return reviseday;
	}
	public void setReviseday(String reviseday) {
		this.reviseday = reviseday;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRevise() {
		return revise;
	}
	public void setRevise(String revise) {
		this.revise = revise;
	}
	
	
	
	
} // end of class -----------------------------------------------------
