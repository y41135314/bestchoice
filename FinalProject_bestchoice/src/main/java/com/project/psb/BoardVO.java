package com.project.psb;

import org.springframework.web.multipart.MultipartFile;

// === #52. VO 생성하기
//     먼저, 오라클에서 tblBoard 테이블을 생성해야 한다. 
public class BoardVO { 

	private String adminBoard_idx;          // 글번호 
	
	private String rno; // 행번호 
	
	private String fk_adminId;    // 사용자ID
	private String name;         // 글쓴이 
	private String fk_hotelName;         
	private String fk_sellerName;       
	private String registerday;      // 글쓴시간
	private String title;      // 글제목
	private String content;      // 글내용 
	private String status;        
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	// === #84. 댓글형 게시판을 위한 commentCount 필드 추가하기 
	//          먼저 tblBoard 테이블에 commentCount 라는 컬럼이 존재해야 한다. 
	private String commentCount;     // 댓글수 
	
	
	// === #127. 답변형 게시판을 위한 필드 추가하기
	//           먼저, 오라클에서 tblComment 테이블과 tblBoard 테이블을 drop 한 후에
	//           tblComment 테이블과 tblBoard 테이블을 재생성 한 이후에 아래처럼 해야 한다.
	private String groupno;
	/*
	   답변글쓰기에 있어서 그룹번호 
           원글(부모글)과 답변글은 동일한 groupno 를 가진다.
           답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다. 
	*/
	
	private String fk_seq;
	/*
	  fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
      fk_seq 컬럼은 자신의 글(답변글)에 있어서 
            원글(부모글)이 누구인지에 대한 정보값이다.
            답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
            원글(부모글)의 seq 컬럼의 값을 가지게 되며,
            답변글이 아닌 원글일 경우 0 을 가지도록 한다. 
	*/
	
	private String depthno;
	/*
	    답변글쓰기에 있어서 답변글 이라면
            원글(부모글)의 depthno + 1 을 가지게 되며,
            답변글이 아닌 원글일 경우 0 을 가지도록 한다. 
	*/
	
	/*
	   === #140. 파일을 첨부하도록 VO 수정하기
	             먼저, 오라클에서 tblBoard 테이블에
	             3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다.   
	*/
	private String fileName;      // WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
	private String orgFilename;   // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String fileSize;      // 파일크기 
	
	private MultipartFile attach; // 진짜 파일 ==> WAS(톰캣) 디스크에 저장됨.
	// !!!!!! MultipartFile attach 는 오라클 데이터베이스 tblBoard 테이블의 컬럼이 아니다.!!!!!!  
	// /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	// 동일해야만 파일첨부가 가능해진다.!!!!

	public BoardVO() { }

	public BoardVO(String rno, String adminBoard_idx, String fk_adminId, String name, String fk_hotelName, String fk_sellerName, String registerday,
			String title, String content, String status, String previousseq, String previoussubject, String nextseq,
			String nextsubject, String commentCount, String groupno, String fk_seq, String depthno, String fileName,
			String orgFilename, String fileSize, MultipartFile attach) {
		super();
		this.rno = rno;
		this.adminBoard_idx = adminBoard_idx;
		this.fk_adminId = fk_adminId;
		this.name = name;
		this.fk_hotelName = fk_hotelName;
		this.fk_sellerName = fk_sellerName;
		this.registerday = registerday;
		this.title = title;
		this.content = content;
		this.status = status;
		this.previousseq = previousseq;
		this.previoussubject = previoussubject;
		this.nextseq = nextseq;
		this.nextsubject = nextsubject;
		this.commentCount = commentCount;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.attach = attach;
	}

	public String getRno() {
		return rno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}
	
	public String getAdminBoard_idx() {
		return adminBoard_idx;
	}

	public void setAdminBoard_idx(String adminBoard_idx) {
		this.adminBoard_idx = adminBoard_idx;
	}

	public String getFk_adminId() {
		return fk_adminId;
	}

	public void setFk_adminId(String fk_adminId) {
		this.fk_adminId = fk_adminId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFk_hotelName() {
		return fk_hotelName;
	}

	public void setFk_hotelName(String fk_hotelName) {
		this.fk_hotelName = fk_hotelName;
	}

	public String getFk_sellerName() {
		return fk_sellerName;
	}

	public void setFk_sellerName(String fk_sellerName) {
		this.fk_sellerName = fk_sellerName;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
}
