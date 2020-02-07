package com.project.dws;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.smh.SmhMemberVO;

@Repository
public class DwsDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;
	
	public DwoReservationVO selectReservation(String res_number) {
		return sqlsession.selectOne("dwsMapper.selectReservation",res_number);
	}

	public SmhMemberVO selectMember(String member_idx) {
		return sqlsession.selectOne("dwsMapper.selectMember",member_idx);
	}

	public void updateReservation(DwoReservationVO dwoReservation) {
		sqlsession.update("dwsMapper.updateReservation",dwoReservation);
	}
	
	public void insertFinish(DwoReservationVO dwoReservation) {
		sqlsession.insert("dwsMapper.insertFinish",dwoReservation);
	}

	public void updatePayStatus(DwoReservationVO reservationVO) {
		sqlsession.update("dwsMapper.updatePayStatus",reservationVO);
	}

	public String selectMpointCash(String meber_idx) {
		return sqlsession.selectOne("dwsMapper.selectMpointCash",meber_idx);
	}

	public void insertReservation(DwoReservationVO reservationVO){
		sqlsession.insert("dwsMapper.insertReservation",reservationVO);
	}

	public String selectResNumber() {
		return sqlsession.selectOne("dwsMapper.selectResNumber");
	}

	public void updateDeductionMpointCash(DwoReservationVO dwoReservation) {
		sqlsession.update("dwsMapper.updateDeductionMpointCash",dwoReservation);
	}
	
}
