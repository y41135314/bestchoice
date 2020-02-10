package com.project.yju;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.kmt.KmtHotelInfoVO;
import com.project.kmt.KmtRoomImageVO;


@Service
public class YjuService {

	@Resource
	private YjuDAO dao ;
	
	// 새로이 입력할 리뷰번호(시퀀스) 가져오기
	public int getReviewseq() {
		int seq_here_review_no = dao.getReviewseq();
		return seq_here_review_no;
	}

	// 리뷰가 insert 되면 리뷰 평점에도 insert하기
	public int addReview(HashMap<String, String> reviewMap) {
		
		// 리뷰 테이블에 insert
		int insertReview = dao.addReview(reviewMap);
		
		return insertReview;
	}

	public int addReviewimage(HashMap<String, String> reviewImageMap) {
		int n = dao.addReviewimage(reviewImageMap);
		return n;
	}

	// 리뷰목록 가져오기
	public List<HashMap<String, String>> getreview(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewMapList = dao.getreview(paraMap); 
		return reviewMapList;
	}
	// 이미지 목록 알아오기
	public List<HashMap<String, Object>> getreviewImage() {
		List<HashMap<String, Object>> reviewImageMapList = dao.getreviewImage(); 
		return reviewImageMapList;
	}
	// 평점 목록 알아오기
	public HashMap<String, Object> getreviewGrade(String hotel_idx) {
		HashMap<String,Object> gradeMap = dao.getreviewGrade(hotel_idx);
		
		if(gradeMap != null) {
			double double_allGrade = (double)gradeMap.get("allGrade");
			int allGrade = (int)double_allGrade;
			
			String str_allGrade = "";
			
			switch (allGrade) {
			case 9 :
				str_allGrade = "최고에요";
				break;
			case 8 :
				str_allGrade = "추천해요";
				break;
			case 7 :
				str_allGrade = "추천해요";
				break;
			case 6 :
				str_allGrade = "만족해요";
				break;
			case 5 :
				str_allGrade = "만족해요";
				break;
			case 4 :
				str_allGrade = "별로에요";
				break;
			case 3 :
				str_allGrade = "별로에요";
				break;
			case 2 :
				str_allGrade = "최악이에요";
				break;
			case 1 :
				str_allGrade = "최악이에요";
				break;
			case 0 :
				str_allGrade = "최악이에요";
				break;
			default:
				break;
			}
			
			gradeMap.put("str_allGrade", str_allGrade);
			
		}
		
		return gradeMap;
	}
	
	// 호텔 정보 알아오기
	public KmtHotelInfoVO getHotelInfo(String hotel_idx) {
		KmtHotelInfoVO hotelInfoVO = dao.getHotelInfo(hotel_idx);
		return hotelInfoVO;
	}

	// 내가 쓴글 가져오기
	public HashMap<String, Object> reviewEdit(String seq) {
		HashMap<String, Object> reviewEditMap = dao.reviewEdit(seq);
		return reviewEditMap;
	}
	
	// 첨부한 사진 가져오기
	public List<HashMap<String, Object>> reviewImageEdit(String seq) {
		List<HashMap<String, Object>> reviewImageEditMapList = dao.reviewImageEdit(seq);
		return reviewImageEditMapList;
	}
	
	// 리뷰 수정하기
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int updateReview(HashMap<String, Object> reviewMap) {
		
		// 1. 원래 첨부한 이미지 delete하기
		// 2. 수정한 리뷰 update하기
		
		int deleteReviewImage = 0;
		int updateReview = 0;
		
		String review_no = (String)reviewMap.get("review_no");
		// 원래 첨부된 이미지 갯수 알아오기
		String imageCount = dao.orgReviewImage(review_no);
		
		// 원래 첨부된 이미지 갯수가 없다면~
		if(imageCount == null) {
			imageCount = "0";
		}
		
		// 리뷰 이미지 테이블에서 원래 첨부한 이미지 delete
		deleteReviewImage = dao.delReviewImage(reviewMap);

		// 원래 첨부된 사진갯수보다 작을 경우(성공)
		if( deleteReviewImage <= Integer.parseInt(imageCount)) {
		
			// 리뷰 테이블에 update
			updateReview = dao.updateReview(reviewMap);
			
		}
		
		return updateReview;
	}
	
	// 글 삭제하기
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int del(String seq) {
		
		// 1. 리뷰이미지 삭제하기
		// seq로 리뷰 no알아오기
		String review_no = dao.getReviewNO(seq);
		
		// 원래 첨부된 이미지 갯수 알아오기
		String imageCount = dao.orgReviewImage(review_no);	// 이미지가 없다면 null, 있다면 이미지 갯수
		
		System.out.println("1.imageCount: "+imageCount);
		
		if(imageCount == null) {
			imageCount = "0";
		}
		System.out.println("2.imageCount: "+imageCount);
		
		int delImage = 0;
		int upReview = 0;
		HashMap<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("review_no", review_no);
		
		// 첨부된 이미지가 있다
		if(Integer.parseInt(imageCount) > 0) {
			delImage = dao.delReviewImage(reviewMap); // 원글의 번호를 알아야 삭제하지? 파라미터로 넣어주기
		}
		
		// 삭제된 이미지 행과 원래 첨부된 이미지 갯수가 같다면
		if(delImage >= 0) {
			
			//  리뷰 상태 0으로 update
			// 2. 리뷰삭제하기
			upReview = dao.updateReview(reviewMap);
			
		}
		
		return upReview;
	}
	
	// 내가 이용한 객실 목록 불러오기
	public List<HashMap<String, Object>> getUseMyRoom(String member_idx) {
		
		List<HashMap<String, Object>> useMyRoomList = dao.getUseMyRoom(member_idx);
		return useMyRoomList;
	}
	
	// 내가 쓴글 읽어오기
	/*public int getMyReview(String seq) {
		int myReview = dao.getMyReview(seq);
		return myReview;
	}*/

	// 리뷰 목록에서 seq 가져오기
	public List<Integer> getReviewAllSeq(String member_idx) {
		List<Integer> seqList = dao.getReviewAllSeq(member_idx);
		return seqList;
	}
	
	// 총 리뷰 건수 구하기
	public int getReviewCnt(String hotel_idx) {
		
		int reviewCnt = dao.getReviewCnt(hotel_idx);
		return reviewCnt;
	}
	
	// 객실정보 알아오기
	/*public KmtRoomInfoVO getRoomInfoVO(String hotel_idx) {
		
		KmtRoomInfoVO roomInfoVO = dao.getRoomInfoVO(hotel_idx);
		return roomInfoVO;
	}*/
	
	// 호텔 서비스 정보 알아오기
	public List<HashMap<String, String>> getRoomService(String hotel_idx) {
		List<HashMap<String, String>> roomServiceList = dao.getRoomService(hotel_idx);
		return roomServiceList;
	}
	
	// 방정보 알아오기
	public List<HashMap<String, String>> getRoomInfo(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> roomInfoList = dao.getRoomInfo(paraMap);
		return roomInfoList;
	}

	// 방수량 알아오기
	public List<HashMap<String, String>> getroomQuantity(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> roomQuantityList = dao.getroomQuantity(paraMap);
		return roomQuantityList;
	}
		
	// 방이미지 알아오기
	public List<KmtRoomImageVO> getRoomImage(String hotel_idx) {
		List<KmtRoomImageVO> roomImageList = dao.getRoomImage(hotel_idx);
		return roomImageList;
	}

	// 침대유형 알아오기
	public List<HashMap<String, String>> getBedtype(String hotel_idx) {
		List<HashMap<String, String>> bedtypeList = dao.getBedtype(hotel_idx);
		return bedtypeList;
	}
	
	// 스파유형 알아오기
	public List<HashMap<String, String>> getSpatype(String hotel_idx) {
		List<HashMap<String, String>> spatypeList = dao.getSpatype(hotel_idx);
		return spatypeList;
	}
	
	// 테마유형 알아오기
	public List<HashMap<String, String>> getThemetype(String hotel_idx) {
		List<HashMap<String, String>> themetype = dao.getThemetype(hotel_idx);
		return themetype;
	}
	
	// 내부객시설유형 알아오기
	public List<HashMap<String, String>> getServicetype(String hotel_idx) {
		List<HashMap<String, String>> servicetypeList = dao.getServicetype(hotel_idx);
		return servicetypeList;
	}
	
	
	
	
	

	

	
	
}
