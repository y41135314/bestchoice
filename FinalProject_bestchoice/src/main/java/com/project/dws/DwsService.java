package com.project.dws;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.smh.SmhMemberVO;


///수정
@Service
public class DwsService {

	@Resource
	private DwsDAO dao ;

	public DwoReservationVO selectReservation(String res_number) {
		return dao.selectReservation(res_number);
	}

	public SmhMemberVO selectMember(String member_idx) {
		return dao.selectMember(member_idx);
	}

	public void updateReservation(DwoReservationVO dwoReservation) {
		dao.updateReservation(dwoReservation);
	}

	public void insertFinish(DwoReservationVO dwoReservation) {
		dao.insertFinish(dwoReservation);
	}

	public void updatePayStatus(DwoReservationVO reservationVO) {
		dao.updatePayStatus(reservationVO);
	}

	public String selectMpointCash(String meber_idx) {
		return dao.selectMpointCash(meber_idx);
	}

	public void updateDeductionMpointCash(DwoReservationVO dwoReservation) {
		dao.updateDeductionMpointCash(dwoReservation);
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertReservation(DwoReservationVO reservationVO) throws Throwable{

		int n = 0;
		
		String res_number = selectResNumber();
		
		System.out.println("res_number : "+res_number);
		System.out.println("res_receipt : "+reservationVO.getRes_receipt());
		System.out.println("fk_member_idx : "+reservationVO.getFk_member_idx());
		System.out.println("room_idx : "+reservationVO.getRoom_idx());
		System.out.println("res_payment : "+reservationVO.getRes_payment());
		System.out.println("res_totalprice : "+reservationVO.getRes_totalprice());
		System.out.println("mpointCash : "+reservationVO.getMpointCash());

		System.out.println("finish_addpoint : "+reservationVO.getFinish_addpoint());
		
		reservationVO.setRes_number(res_number);
		
		// reservation 테이블에 인서트
		n = dao.insertReservation(reservationVO);
		
		if(n==1) {	// finish 테이블에 인서트
			
			n =dao.insertFinish(reservationVO);
			
			// 적립금 변경
			if(n==1) {
				
				n = dao.updateMpoint(reservationVO);
			}
		}
		
		return n;
	}

	
	
	
	public String selectResNumber() {
		return dao.selectResNumber();
	}

	public HashMap<String, String> getRoomInfo(HashMap<String, String> paraMap) {

		return dao.getRoomInfo(paraMap);
	}

	public List<HashMap<String, String>> getCouponList(String member_idx) {
		// TODO Auto-generated method stub
		return dao.getCouponList(member_idx);
	}

	//커밋
}
