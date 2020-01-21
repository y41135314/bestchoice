package com.project.psb;

public class AdminVO {
	private String seq;          
	private String adminId;   
	private String adminPwd;        
	private String name;   
	private String registerday;
	private String email;
	private int status;
	private int grade;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPwd() {
		return adminPwd;
	}
	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public AdminVO() {}
	
	public AdminVO(String seq, String adminId, String adminPwd, String name, String registerday, String email, int status,
			int grade) {
		super();
		this.seq = seq;
		this.adminId = adminId;
		this.adminPwd = adminPwd;
		this.name = name;
		this.registerday = registerday;
		this.email = email;
		this.status = status;
		this.grade = grade;
	}
	
	

}
