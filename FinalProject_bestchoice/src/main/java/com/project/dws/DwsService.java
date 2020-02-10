package com.project.dws;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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

	public void insertReservation(DwoReservationVO reservationVO){
		// TODO Auto-generated method stub
		dao.insertReservation(reservationVO);
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
