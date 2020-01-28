package com.project.psb;

public class CommentVO {
	
	private String adminComment_idx;          // 댓글번호
	private String fk_adminId; 
	private String fk_parentIdx;    
	private String name;         // 성명
	private String content;      // 댓글내용
	private String registerday;      // 작성일자
	
	public CommentVO() { }

	public String getAdminComment_idx() {
		return adminComment_idx;
	}

	public void setAdminComment_idx(String adminComment_idx) {
		this.adminComment_idx = adminComment_idx;
	}

	public String getFk_adminId() {
		return fk_adminId;
	}

	public void setFk_adminId(String fk_adminId) {
		this.fk_adminId = fk_adminId;
	}

	public String getFk_parentIdx() {
		return fk_parentIdx;
	}

	public void setFk_parentIdx(String fk_parentIdx) {
		this.fk_parentIdx = fk_parentIdx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public CommentVO(String adminComment_idx, String fk_adminId, String fk_parentIdx, String name, String content,
			String registerday) {
		super();
		this.adminComment_idx = adminComment_idx;
		this.fk_adminId = fk_adminId;
		this.fk_parentIdx = fk_parentIdx;
		this.name = name;
		this.content = content;
		this.registerday = registerday;
	}
	
	
}
