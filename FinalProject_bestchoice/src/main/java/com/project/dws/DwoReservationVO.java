package com.project.dws;

public class DwoReservationVO {
	
	String res_number;//예약번호
	String res_receipt; //영수증번호 
	String fk_member_idx; //회원 idx
	String fk_room_idx; //방코드
	String fk_coupon_code;//쿠폰코드
    String res_payment;//(0카드/신용 1카카오페이 2네이버)
    String res_startday; //입실일 =============================================수정 
	String res_endday; //퇴실일 =============================================수정 
	String res_totalprice;//최종결제금액  
	String res_point;//적립금 사용 또는 적립내역    
	String res_paymentstatus; //예약상태
	String finish_paymentstatus;//결제 상태 (0:예약전 1: 결제 o )
	String finish_addpoint;//추가적립금
    String res_paymentDay;//결제일
		
	///////////////////////////////////////////////////// 추가 
	String name  ;
	String hotel_name;
	String seller_name;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getSeller_name() {
		return seller_name;
	}
	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}
/////////////////////////////////////////////////////
	
	public String getRes_paymentDay() {
		return res_paymentDay;
	}
	public void setRes_paymentDay(String res_paymentDay) {
		this.res_paymentDay = res_paymentDay;
	}
	public String getRes_number() {
		return res_number;
	}
	public void setRes_number(String res_number) {
		this.res_number = res_number;
	}
	public String getRes_receipt() {
		return res_receipt;
	}
	public void setRes_receipt(String res_receipt) {
		this.res_receipt = res_receipt;
	}
	public String getFk_member_idx() {
		return fk_member_idx;
	}
	public void setFk_member_idx(String fk_member_idx) {
		this.fk_member_idx = fk_member_idx;
	}
	public String getFk_room_idx() {
		return fk_room_idx;
	}
	public void setFk_room_idx(String fk_room_idx) {
		this.fk_room_idx = fk_room_idx;
	}
	public String getFk_coupon_code() {
		return fk_coupon_code;
	}
	public void setFk_coupon_code(String fk_coupon_code) {
		this.fk_coupon_code = fk_coupon_code;
	}
	public String getRes_payment() {
		return res_payment;
	}
	public void setRes_payment(String res_payment) {
		this.res_payment = res_payment;
	}
	public String getRes_startday() {
		return res_startday;
	}
	public void setRes_startday(String res_startday) {
		this.res_startday = res_startday;
	}
	public String getRes_endday() {
		return res_endday;
	}
	public void setRes_endday(String res_endday) {
		this.res_endday = res_endday;
	}
	public String getRes_totalprice() {
		return res_totalprice;
	}
	public void setRes_totalprice(String res_totalprice) {
		this.res_totalprice = res_totalprice;
	}
	public String getRes_point() {
		return res_point;
	}
	public void setRes_point(String res_point) {
		this.res_point = res_point;
	}
	public String getRes_paymentstatus() {
		return res_paymentstatus;
	}
	public void setRes_paymentstatus(String res_paymentstatus) {
		this.res_paymentstatus = res_paymentstatus;
	}
	public String getFinish_paymentstatus() {
		return finish_paymentstatus;
	}
	public void setFinish_paymentstatus(String finish_paymentstatus) {
		this.finish_paymentstatus = finish_paymentstatus;
	}
	public String getFinish_addpoint() {
		return finish_addpoint;
	}
	public void setFinish_addpoint(String finish_addpoint) {
		this.finish_addpoint = finish_addpoint;
	}
	
	
	
	
}
