package com.project.yju;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.kmt.KmtHotelInfoVO;
import com.project.kmt.KmtRoomImageVO;

@Repository
public class YjuDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 새로이 입력할 리뷰번호(시퀀스) 가져오기
		public int getReviewseq() {
			
			int seq_here_review_no = sqlsession.selectOne("yjuMapper.getReviewseq");
			return seq_here_review_no;

		}

		// 리뷰테이블에 리뷰 등록하기
		public int addReview(HashMap<String, String> reviewMap) {
			int n = sqlsession.insert("yjuMapper.addReview", reviewMap);
			return n;
		}
		
		// 리뷰이미지테이블에 리뷰이미지파일 등록하기
		public int addReviewimage(HashMap<String, String> reviewImageMap) {
			int n = sqlsession.insert("yjuMapper.addReviewimage", reviewImageMap);
			return n;
		}
		// 리뷰목록 가져오기
		public List<HashMap<String, String>> getreview(HashMap<String, String> paraMap) {
			List<HashMap<String, String>> reviewMapList = sqlsession.selectList("yjuMapper.getreview", paraMap);
			return reviewMapList;
		}
		// 이미지 목록 알아오기
		public List<HashMap<String, Object>> getreviewImage() {
			List<HashMap<String, Object>> reviewImageMapList = sqlsession.selectList("yjuMapper.getreviewImage");
			return reviewImageMapList;
		}
		// 평점 목록 알아오기
		public HashMap<String, Object> getreviewGrade(String hotel_idx) {
			HashMap<String,Object> gradeMap = sqlsession.selectOne("yjuMapper.getreviewGrade", hotel_idx);
			return gradeMap;
		}
		
		// 호텔정보 알아오기
		public KmtHotelInfoVO getHotelInfo(String hotel_idx) {
			KmtHotelInfoVO hotelInfoVO = sqlsession.selectOne("yjuMapper.getHotelInfo", hotel_idx);
			return hotelInfoVO;
		}
		
		
		// 수정할 리뷰 가져오기
		public HashMap<String, Object> reviewEdit(String seq) {
			HashMap<String, Object> reviewEditMap = sqlsession.selectOne("yjuMapper.reviewEdit", seq);
			return reviewEditMap;
		}
		
		// 수정할 리뷰이미지 가져오기
		public List<HashMap<String, Object>> reviewImageEdit(String seq) {
			List<HashMap<String, Object>> reviewImageEditMapList = sqlsession.selectList("yjuMapper.reviewImageEdit",seq);
			return reviewImageEditMapList;
		}
		
		// 리뷰 수정하기
		// seq로 리뷰 no알아오기
		public String getReviewNO(String seq) {
			String review_no = sqlsession.selectOne("yjuMapper.getReviewNO", seq);
			return review_no;
		}
		
		// 1-2. 원래 첨부한 이미지 갯수알아오기
		public String orgReviewImage(String review_no) {
			String imageCount = sqlsession.selectOne("yjuMapper.orgReviewImage", review_no);
			return imageCount;
		}
		// 1-2. 원래 첨부한 이미지 delete하기
		public int delReviewImage(HashMap<String, Object> reviewMap) {
			int deleteReviewImage = sqlsession.delete("yjuMapper.delReviewImage", reviewMap);
			return deleteReviewImage;
		}
		// 2. 수정한 리뷰 update하기
		public int updateReview(HashMap<String, Object> reviewMap) {
			int updateReview = sqlsession.update("yjuMapper.updateReview", reviewMap);
			return updateReview;
		}

//		// 3. 수정한 평점 update하기
//		public int updateGrade(HashMap<String, Object> reviewMap) {
//			int updateGrade = sqlsession.update("yjuMapper.updateGrade", reviewMap); 
//			return updateGrade;
//		}
//		
		
		// 리뷰 삭제하기
			/*public int deleteImage(int review_no) {
				int delImage = sqlsession.delete("yjuMapper.deleteImage", review_no);
				return delImage;
			}*/
		
//		// 리뷰 평점 삭제하기
//		public int delReviewGrade(HashMap<String, Object> reviewMap) {
//			int delGrade = sqlsession.delete("yjuMapper.delReviewGrade",reviewMap);
//			return delGrade;
//		}
		
		public List<HashMap<String, Object>> getUseMyRoom(String member_idx) {
			List<HashMap<String, Object>> useMyRoomList = sqlsession.selectList("yjuMapper.getUseMyRoom",member_idx);
			return useMyRoomList;
		}

		/*public int getMyReview(String seq) {
			int myReview = sqlsession.selectOne("yjuMapper.getMyReview",seq);
			return myReview;
		}*/
		
		// seq가져오기
		public List<Integer> getReviewAllSeq(String member_idx) {
			List<Integer> seqList = sqlsession.selectList("yjuMapper.getReviewAllSeq",member_idx);
			return seqList;
		}
		
		// 총 리뷰 건수 구하기
		public int getReviewCnt(String hotel_idx) {
			int reviewCnt = sqlsession.selectOne("yjuMapper.getReviewCnt", hotel_idx);
			return reviewCnt;
		}

		
		// 객실정보 알아오기
		/*public KmtRoomInfoVO getRoomInfoVO(String hotel_idx) {
			KmtRoomInfoVO roomInfoVO = sqlsession.selectOne("yjuMapper.getRoomInfo", hotel_idx);
			return roomInfoVO;
		}*/
				
		// 호텔 서비스 정보 알아오기
		public List<HashMap<String, String>> getRoomService(String hotel_idx) {
			List<HashMap<String, String>> roomServiceList = sqlsession.selectList("yjuMapper.getRoomService", hotel_idx);
			return roomServiceList;
		}
		
		// 방정보 알아오기
		public List<HashMap<String, String>> getRoomInfo(HashMap<String, String> paraMap) {
			List<HashMap<String, String>> roomInfoList = sqlsession.selectList("yjuMapper.getRoomInfo", paraMap);
			return roomInfoList;
		}

		// 방수량 알아오기
		public List<HashMap<String, String>> getroomQuantity(HashMap<String, String> paraMap) {
			List<HashMap<String, String>> roomQuantityList = sqlsession.selectList("yjuMapper.getroomQuantity", paraMap);
			return roomQuantityList;
		}
		
		// 전체(호텔, 방) 이미지 알아오기
		public List<HashMap<String, String>> getHotelTotalImage(String hotel_idx) {
			List<HashMap<String, String>> HotelTotalImageList = sqlsession.selectList("yjuMapper.getHotelTotalImage",hotel_idx);
			return HotelTotalImageList;
		}
				
		// 방이미지 알아오기
		public List<KmtRoomImageVO> getRoomImage(String hotel_idx) {
			List<KmtRoomImageVO> roomImageList = sqlsession.selectList("yjuMapper.getRoomImage",hotel_idx);
			return roomImageList;
		}

		// 침대유형 알아오기
		public List<HashMap<String, String>> getBedtype(String hotel_idx) {
			List<HashMap<String, String>> bedtypeList = sqlsession.selectList("yjuMapper.getBedtype",hotel_idx);
			return bedtypeList;
		}
		
		// 스파유형 알아오기
		public List<HashMap<String, String>> getSpatype(String hotel_idx) {
			List<HashMap<String, String>> spatypeList = sqlsession.selectList("yjuMapper.getSpatype",hotel_idx);
			return spatypeList;
		}
		
		// 테마유형 알아오기
		public List<HashMap<String, String>> getThemetype(String hotel_idx) {
			List<HashMap<String, String>> themetype = sqlsession.selectList("yjuMapper.getThemetype",hotel_idx);
			return themetype;
		}
		
		// 내부객시설유형 알아오기
		public List<HashMap<String, String>> getServicetype(String hotel_idx) {
			List<HashMap<String, String>> servicetypeList = sqlsession.selectList("yjuMapper.getServicetype",hotel_idx);
			return servicetypeList;
		}
		
		

		
		

	

	

	
	
	
	
}
