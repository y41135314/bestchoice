package com.project.dws;

/**
 * @author ghlee
 *
 */
public class DwoReservationVO {
	
	String res_number;//예약번호
	String res_receipt; //영수증번호 
	String fk_member_idx; //회원 idx
	String fk_room_idx; //방코드
	String fk_coupon_code;//쿠폰코드
    String res_payment;//(0카드/신용 1카카오페이 2네이버)
    
    String startday;
    String endday;
    
    String resstatus_in_day; //입실일
	String resstatus_out_day; //퇴실일
	String res_totalprice;//최종결제금액  
	String res_point;//적립금 사용 또는 적립내역    
	String res_paymentstatus; //예약상태 
	String finish_paymentstatus;//결제 상태 (0:예약전  1: 결제 o )
	String finish_addpoint;//추가적립금
	String res_paymentDay; //결제일
	String mpointCash; //사용적립금
	String hotel_idx;  //호텔이름 
	String hotel_name;  //호텔이름 
	String room_name; // 룸타임
	String room_checkintime; // 체크인시간
	String room_checkouttime; // 체크아웃 시간
	String room_idx;
	String member_idx;
	String name;
	String seller_name;
	
	@Override
	public String toString() {
		return "DwoReservationVO [res_receipt=" + res_receipt + ", fk_room_idx=" + fk_room_idx + ", fk_coupon_code="
				+ fk_coupon_code + ", resstatus_in_day=" + resstatus_in_day + ", resstatus_out_day=" + resstatus_out_day
				+ ", res_totalprice=" + res_totalprice + ", res_point=" + res_point + ", res_paymentstatus="
				+ res_paymentstatus + ", hotel_idx=" + hotel_idx + ", member_idx=" + member_idx + "]";
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
	public String getResstatus_in_day() {
		return resstatus_in_day;
	}
	public void setResstatus_in_day(String resstatus_in_day) {
		this.resstatus_in_day = resstatus_in_day;
	}
	public String getResstatus_out_day() {
		return resstatus_out_day;
	}
	public void setResstatus_out_day(String resstatus_out_day) {
		this.resstatus_out_day = resstatus_out_day;
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
		
		try {
			
			int res_point = Integer.parseInt(mpointCash);
			
			if( res_point == 0) {
				
				int totalprice = Integer.parseInt(res_totalprice);
				int point = totalprice/10*1;
				
				return String.valueOf(point);
			}
			else {
				
				return "0";
			}
			
		} catch (Exception e) {
		
			return "0";
		}
		
	}
	public void setFinish_addpoint(String finish_addpoint) {
		this.finish_addpoint = finish_addpoint;
	}
	public String getRes_paymentDay() {
		return res_paymentDay;
	}
	public void setRes_paymentDay(String res_paymentDay) {
		this.res_paymentDay = res_paymentDay;
	}
	public String getMpointCash() {
		return mpointCash;
	}
	public void setMpointCash(String mpointCash) {
		this.mpointCash = mpointCash;
	}
	public String getHotel_idx() {
		return hotel_idx;
	}
	public void setHotel_idx(String hotel_idx) {
		this.hotel_idx = hotel_idx;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoom_checkintime() {
		return room_checkintime;
	}
	public void setRoom_checkintime(String room_checkintime) {
		this.room_checkintime = room_checkintime;
	}
	public String getRoom_checkouttime() {
		return room_checkouttime;
	}
	public void setRoom_checkouttime(String room_checkouttime) {
		this.room_checkouttime = room_checkouttime;
	}
	public String getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(String room_idx) {
		this.room_idx = room_idx;
	}
	public String getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(String member_idx) {
		this.member_idx = member_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSeller_name() {
		return seller_name;
	}
	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
		this.endday = endday;
	}
	
	//커밋 테스트!!!
	
	
}
