package com.project.yju;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.common.FileManager;
import com.project.kmt.KmtHotelInfoVO;
import com.project.kmt.KmtRoomImageVO;
import com.project.common.MyUtil;



@Controller
public class YjuController {

	@Resource
	private YjuService service ;
	
	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기 ===  
	@Autowired
	private FileManager fileManager;
	
	
	
	// 객실 상세 페이지
	@RequestMapping(value="/roomDetail.bc")
	public String productDetail(HttpServletRequest request) {
		
		String hotel_idx = request.getParameter("hotel_idx");
		//String hotel_idx = "4";
		
		// 호텔목록에서 가져올 경우~
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		
		/*if((startday == null || "".equals(startday)) &&  (endday == null || "".equals(endday))) {
			startday = "";
			endday = "";
		}*/
		
		// 내가 선택한 날짜로 바꿀경우~
		String datepicker = request.getParameter("datepicker"); // 20.02.24 ~ 20.02.27
		
		if(datepicker != null) {
			String[] dateArr = datepicker.trim().split("~");
			
			startday = dateArr[0];
			endday = dateArr[1].trim();
		}
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("hotel_idx", hotel_idx);
		paraMap.put("startday", startday);
		paraMap.put("endday", endday);
		
		// 평점 알아오기
		HashMap<String,Object> gradeMap = service.getreviewGrade(hotel_idx);
		
		// 호텔 정보 알아오기
		KmtHotelInfoVO hotelInfoVO = service.getHotelInfo(hotel_idx);
		String hotel_Addr = hotelInfoVO.getHotel_Addr1()+" "+hotelInfoVO.getHotel_Addr2()+" "+hotelInfoVO.getHotel_Addr3();
		int hotel_Category = hotelInfoVO.getHotel_Category(); 
		String str_hotel_Category = "";
		
		switch (hotel_Category) {
		case 0:
			str_hotel_Category = "특1급";
			break;
		case 1:
			str_hotel_Category = "특급";
			break;
		case 2:
			str_hotel_Category = "일반";
			break;
		default:
			break;
		}
		
		// 방정보 알아오기
		List<HashMap<String, String>> roomInfoList = service.getRoomInfo(paraMap);
		
		// 방수량 알아오기
		List<HashMap<String, String>> roomQuantityList = service.getroomQuantity(paraMap);
		
		// 전체(호텔, 방) 이미지 알아오기
		List<HashMap<String, String>> hotelTotalImageList = service.getHotelTotalImage(hotel_idx);
		
		// 방이미지 알아오기
		List<KmtRoomImageVO> roomImageList = service.getRoomImage(hotel_idx);
		
		// 침대유형 알아오기
		List<HashMap<String, String>> bedtypeList = service.getBedtype(hotel_idx);
		
		// 스파유형 알아오기
		List<HashMap<String, String>> spatypeList = service.getSpatype(hotel_idx);
		
		// 테마유형 알아오기
		List<HashMap<String, String>> themetypeList = service.getThemetype(hotel_idx);
		
		// 내부객시설유형 알아오기
		List<HashMap<String, String>> servicetypeList = service.getServicetype(hotel_idx);
		
		request.setAttribute("gradeMap", gradeMap);
		request.setAttribute("hotelInfoVO", hotelInfoVO);
		request.setAttribute("hotel_Addr", hotel_Addr);
		request.setAttribute("hotel_Category", str_hotel_Category);
		request.setAttribute("roomInfoList", roomInfoList);
		request.setAttribute("roomImageList", roomImageList);
		request.setAttribute("roomQuantityList", roomQuantityList);
		request.setAttribute("bedtypeList", bedtypeList);
		request.setAttribute("spatypeList", spatypeList);
		request.setAttribute("themetypeList", themetypeList);
		request.setAttribute("servicetypeList", servicetypeList);
		request.setAttribute("hotelTotalImageList", hotelTotalImageList);
		
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		
		return "room/room_detail.tiles1";
	}
	
	// 객실 편의사항 페이지
	@RequestMapping(value="/roomService.bc")
	public String productService(HttpServletRequest request) {
		String hotel_idx = request.getParameter("hotel_idx");
//		String hotel_idx = "4";
		
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		
		// 평점 알아오기
		HashMap<String,Object> gradeMap = service.getreviewGrade(hotel_idx);
		// 호텔 정보 알아오기
		KmtHotelInfoVO hotelInfoVO = service.getHotelInfo(hotel_idx);
		
		String hotel_Addr = hotelInfoVO.getHotel_Addr1()+" "+hotelInfoVO.getHotel_Addr2()+" "+hotelInfoVO.getHotel_Addr3();
		int hotel_Category = hotelInfoVO.getHotel_Category(); 
		String str_hotel_Category = "";
		
		switch (hotel_Category) {
		case 0:
			str_hotel_Category = "특1급";
			break;
		case 1:
			str_hotel_Category = "특급";
			break;
		case 2:
			str_hotel_Category = "일반";
			break;
		default:
			break;
		}
	
		request.setAttribute("gradeMap", gradeMap);
		request.setAttribute("hotelInfoVO", hotelInfoVO);
		request.setAttribute("hotel_Addr", hotel_Addr);
		request.setAttribute("hotel_Category", str_hotel_Category);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		// 전체(호텔, 방) 이미지 알아오기
		List<HashMap<String, String>> hotelTotalImageList = service.getHotelTotalImage(hotel_idx);
		request.setAttribute("hotelTotalImageList", hotelTotalImageList);
		
		return "room/room_service.tiles1";
	}
	
	// 객실 리뷰 페이지 oo
	@RequestMapping(value="/roomReview.bc")
	public String productReview(HttpServletRequest request) {
		
		String hotel_idx = request.getParameter("hotel_idx");
//		String hotel_idx = "4";
		
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo"); // 페이지바 
        int tatalCount = 0; 		// 총게시물 건수
        int sizePerPage = 5; 		// 한페이지당 보여줄 게시물 수
        int currentShowPageNo = 0;  // 현재 보여주는 페이지번호로서, 초기치료는 1페이지로 설정함
        int totalPage = 0;			// 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
        
        int startRno = 0;			// 시작 행번호
        int endRno = 0;				// 끝 행번호
      
        // 총 리뷰 건수 구하기
	    tatalCount = service.getReviewCnt(hotel_idx);
        totalPage = tatalCount/sizePerPage; 
        
        // 게시판에 보여지는 초기화면
        if(str_currentShowPageNo == null) {
        	currentShowPageNo = 1;
        }
        else {
        	try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
        }
        
        startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
        endRno = startRno + sizePerPage - 1;		
		
        HashMap<String, String> paraMap = new HashMap<String, String>(); 
        
        paraMap.put("hotel_idx",hotel_idx);
		paraMap.put("startRno",String.valueOf(startRno));
        paraMap.put("endRno",String.valueOf(endRno));
       
        // 리뷰목록 가져오기
 		List<HashMap<String, String>> reviewMapList = service.getreview(paraMap); 
		
	    // 페이징바 만들기
	    String pagebar = "<ul>";

		int blockSize = 3;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
				
		int loop = 1;
				
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
		String url = "roomReview.bc";	
			String lastStr = url.substring(url.length()-1);
			if(!"?".equals(lastStr)) 
				url += "?"; 
			
			// *** [이전] 만들기 *** // 
			if(pageNo != 1) {
				pagebar += "&nbsp;<a class='page-link' aria-label='Previous' href='roomReview.bc?currentShowPageNo="+(pageNo-1)+"'>"
			             + "<span aria-hidden='true'>&laquo;</span>"
						 + "<span class='sr-only'>Previous</span>"
			             + "</a>&nbsp;";
			}
			
			while(!(loop > blockSize || pageNo > totalPage)) {
			
				if(pageNo == currentShowPageNo) {
					pagebar += "&nbsp;<span style='font-weight: bold; background-color:#efefef'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pagebar += "&nbsp;<a class='page-link' href='roomReview.bc?currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";	
				}
				pageNo++;	
				loop++;		
			} // end of while-----------------------------------

			// *** [다음] 만들기 *** // 
			if(!(pageNo > totalPage))
				pagebar += "&nbsp;<a class='page-link' aria-label='Next' href='roomReview.bc?currentShowPageNo="+pageNo+"'>"
				         + "<span aria-hidden='true'>&raquo;</span>"
				         + "<span class='sr-only'>Next</span>"
				         + "</a>&nbsp;";
	    
	    pagebar += "</ul>";
	    
	    // 평점 알아오기
		HashMap<String,Object> gradeMap = service.getreviewGrade(hotel_idx);
		// 호텔 정보 알아오기
		KmtHotelInfoVO hotelInfoVO = service.getHotelInfo(hotel_idx);
		String hotel_Addr = hotelInfoVO.getHotel_Addr1()+" "+hotelInfoVO.getHotel_Addr2()+" "+hotelInfoVO.getHotel_Addr3();
		int hotel_Category = hotelInfoVO.getHotel_Category(); 
		String str_hotel_Category = "";
		
		switch (hotel_Category) {
		case 0:
			str_hotel_Category = "특1급";
			break;
		case 1:
			str_hotel_Category = "특급";
			break;
		case 2:
			str_hotel_Category = "일반";
			break;
		default:
			break;
		}
		
		// 전체(호텔, 방) 이미지 알아오기
		List<HashMap<String, String>> hotelTotalImageList = service.getHotelTotalImage(hotel_idx);
		
	    List<HashMap<String, Object>> reviewImageMapList = service.getreviewImage(); 
		request.setAttribute("reviewImageMapList", reviewImageMapList);
		request.setAttribute("gradeMap", gradeMap);
		request.setAttribute("hotelInfoVO", hotelInfoVO);
		request.setAttribute("hotel_Addr", hotel_Addr);
		request.setAttribute("hotel_Category", str_hotel_Category);
		
		
		request.setAttribute("reviewMapList", reviewMapList); // 리뷰목록
	    request.setAttribute("pagebar", pagebar); // 페이지바
		
	    request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		
		request.setAttribute("hotelTotalImageList", hotelTotalImageList);
		
		HttpSession session = request.getSession();
		String gobackURL = MyUtil.getCurrentURL(request);
		session.setAttribute("gobackReviewURL", gobackURL);

	   return "room/room_review.tiles1";
	
	}
	
	// 리뷰쓰기 버튼 누른 후객실 이용목록 가져오기 oo
	@RequestMapping(value="/reviewWriteList.bc")
	public String jyuAOP_reviewWriteList(HttpServletRequest request, HttpServletResponse response) {
		
		String member_idx = request.getParameter("member_idx");
		String gobackURL = request.getParameter("gobackURL");
		
		List<HashMap<String, Object>> useMyRoomList = service.getUseMyRoom(member_idx);
		
		request.setAttribute("useMyRoomList", useMyRoomList);
		
		/*if(useMyRoomList != null) {
			request.setAttribute("useMyRoomList", useMyRoomList);
		}
		else {
			request.setAttribute("useMyRoomList", "");
		}*/
		
		// 리뷰 목록에서 seq 가져오기
		List<Integer> seqList = service.getReviewAllSeq(member_idx);
		
		/*int i = 0;
		for(HashMap<String, Object> useMyRoomMap :useMyRoomList) {
			int seq = (Integer)useMyRoomMap.get("seq");
			System.out.println(i++ +".seq: "+seq);
			for(int j=0; j<seqList.size(); j++ ) {
				int n = seqList.get(j);
				System.out.println(j+".n: "+n);
				if(seq == n) {
					seqList.set(j, 0);
				}
				System.out.println(i+".seqList.set(i, 0): "+seqList.set(i, 0));
			}
		}*/
		
		request.setAttribute("seqList", seqList);
		request.setAttribute("gobackURL", gobackURL);
		
		return "room/reviewWriteList.tiles1";
	}
	
	
	// 객실 리뷰 쓰기 form페이지 -- 로그인한사람의 회원번호만 가능 oo
	@RequestMapping(value="/reviewWrite.bc")
	public String jyuAOP_reviewWrite(HttpServletRequest request, HttpServletResponse response) {
	    
	   String member_idx = request.getParameter("member_idx");
	   String seq = request.getParameter("seq");
	   String gobackURL = request.getParameter("gobackURL");
	  
	   HashMap<String, String> ReviewWriteMap = new HashMap<String, String>(); 
	  
	   ReviewWriteMap.put("member_idx", member_idx);
	   ReviewWriteMap.put("seq", seq);
	   
	   request.setAttribute("ReviewWriteMap", ReviewWriteMap);
	   request.setAttribute("gobackURL", gobackURL);
		
	   return "room/reviewWrite.tiles1"; // String 사용하는 view단: views/yju/reviewWrite.jsp 이다.
	}
	
	// 객실 리뷰 쓰기 완료페이지 oo
	@RequestMapping(value="/reviewWriteEnd.bc", method={RequestMethod.POST})
	public String reviewWriteEnd(MultipartHttpServletRequest request, HttpServletResponse response) {
		
		String seq_here_review_no = String.valueOf(service.getReviewseq()); // 먼저 리뷰번호 채번해오기
		String seq = request.getParameter("seq");
		String title = request.getParameter("title"); 
		String content = request.getParameter("content");
		String grade0 = request.getParameter("grade0");
		String grade1 = request.getParameter("grade1");
		String grade2 = request.getParameter("grade2");
		String grade3 = request.getParameter("grade3");
		String grade4 = request.getParameter("grade4");

		List<MultipartFile> attachList = request.getFiles("attach"); // !!! 이미지첨부 다중파일 !!!
		
		HashMap<String, String> reviewMap = new HashMap<String, String>(); // 글1개
		reviewMap.put("review_no", seq_here_review_no);
		reviewMap.put("seq", seq);
		reviewMap.put("title", title);
		reviewMap.put("content", content);
		reviewMap.put("grade0", grade0);
		reviewMap.put("grade1", grade1);
		reviewMap.put("grade2", grade2);
		reviewMap.put("grade3", grade3);
		reviewMap.put("grade4", grade4);
		
		List<HashMap<String, String>> reviewImageMapList = new ArrayList<HashMap<String, String>>();
		
		if(attachList != null) {  // 이미지첨부 다중파일을 받아왔다라면 
			// 이미지첨부 다중파일을 업로드할 WAS 의 webapp 의 절대경로를 알아와야 한다. 
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			String path = root + "resources"+File.separator+"files";
			// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
			String newFileName = ""; // WAS(톰캣) 디스크에 저장할 파일명 
			
			byte[] bytes = null;    // 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도 
			
			//long fileSize = 0;   	// 파일크기를 읽어오기 위한 용도
			
			for(int i=0; i<attachList.size(); i++) { 
				try {
					 bytes = attachList.get(i).getBytes(); // 첨부파일의 내용물(byte)을 읽어옴.
					 
					 // 파일업로드 한 후 업로드되어진 파일명  가져오기
					 newFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
					 // 예를들어 newFileName 에는  2019012519592316420706146795.png 와 같은 것이 들어옴.
					 
					 //fileSize = attachList.get(i).getSize(); // 첨부파일의 파일크기를 알아온다.
					 
					 HashMap<String, String> reviewImageMap = new HashMap<String, String>();
					// 제품1개에 딸린 다중 이미지
					 
					 reviewImageMap.put("fk_review_no", seq_here_review_no);
					 reviewImageMap.put("wasImgname", newFileName);
					 reviewImageMap.put("orgImgname", attachList.get(i).getOriginalFilename());
					 //reviewImageMap.put("IMAGEFILESIZE", String.valueOf(fileSize));
				
					 reviewImageMapList.add(reviewImageMap);
					 
				} catch (Exception e) {	}
				
			}// end of for------------------------------------------------
			
		}// end of if---------------------------------------
		
		
	  // **** 폼에서 입력받은 제품입력정보 값을 
	  //      Service 단으로 넘겨서 테이블에 insert 하기로 한다.
		   
       // 이미지파일첨부가 없는 경우 또는 이미지파일첨부가 있는 경우로 나누어서
	   // Service 단으로 호출하기
	   int n = 0;
	   int m = 0;
	   
	   int count = 0;
	   
	   if(attachList == null) { // 파일이 첨부된것이 없다면
		   n = service.addReview(reviewMap); // 트랜잭션
		   
	   }
	   else if(attachList != null) { // 파일이 첨부된것이 있다면
		   n = service.addReview(reviewMap); 
		   
		   for(int i=0; i<reviewImageMapList.size(); i++) {
			   m = service.addReviewimage(reviewImageMapList.get(i));
			   if(m==1) count++;
		   }
		   
		   if(reviewImageMapList.size() == count) {
			   n=1;
		   }
		   else {
			   n=0;
		   }
	   }
	   
	  
	   request.setAttribute("n", n);
	   
	   return "room/reviewWriteEnd.tiles1"; 
	}
	
	// 수정할 리뷰 읽어오기 oo
    @RequestMapping(value="/reviewEdit.bc" , method= {RequestMethod.GET})   
    public ModelAndView jyuAOP_reviewEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
    	
    	// 글수정은 로그인이 되어야지만 할 수 있기 때문에 requireLogin_를 붙여서 before advice가 되도록한다.
    	// LoginCheck를 하기위해서는 첫번째 파라미터, 두번째 파라미터가 반드시
    	// HttpServletRequest request, HttpServletResponse response 여야하므로 넣어준다.
    	
    	// 수정해야할 글번호 가져오기
    	String seq = request.getParameter("seq");
    	System.out.println("seq: "+seq);
    	
    	// 수정해야할 글 1개 내용 가져오기 (조회수 증가없이 글만 가져오기)
    	HashMap<String, Object> reviewEditMap = service.reviewEdit(seq);
    	List<HashMap<String, Object>> reviewImageEditMapList = service.reviewImageEdit(seq);
    	
    	mav.addObject("reviewEditMap",reviewEditMap);
    	mav.addObject("reviewImageEditMapList",reviewImageEditMapList);
        mav.setViewName("room/reviewEdit.tiles1");
    	
    	return mav;
    }
	
    // 리뷰 수정하기 oo
    @RequestMapping(value="/reviewEditEnd.bc" , method= {RequestMethod.POST})   
    public ModelAndView jyuAOP_reviewEditEnd(MultipartHttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
    	
    	String review_no = request.getParameter("review_no");
		String title = request.getParameter("title"); 
		String content = request.getParameter("content");
		String grade0 = request.getParameter("grade0");
		String grade1 = request.getParameter("grade1");
		String grade2 = request.getParameter("grade2");
		String grade3 = request.getParameter("grade3");
		String grade4 = request.getParameter("grade4");
		
    	HashMap<String, Object> reviewMap = new HashMap<String, Object>();
    	
    	// 기존 첨부되어진 파일
    	String[] orgAttachArr = request.getParameterValues("orgAttach");
    	reviewMap.put("orgAttachArr", orgAttachArr);
    	
		List<MultipartFile> attachList = request.getFiles("attach"); // !!! 이미지첨부 다중파일 !!!
		
		reviewMap.put("review_no", review_no);
		reviewMap.put("title", title);
		reviewMap.put("content", content);
		reviewMap.put("grade0", grade0);
		reviewMap.put("grade1", grade1);
		reviewMap.put("grade2", grade2);
		reviewMap.put("grade3", grade3);
		reviewMap.put("grade4", grade4);
		reviewMap.put("orgAttachArr", orgAttachArr);
		
		List<HashMap<String, String>> reviewImageMapList = new ArrayList<HashMap<String, String>>();
		
		if(attachList != null) {  // 이미지첨부 다중파일을 받아왔다라면 
			// 이미지첨부 다중파일을 업로드할 WAS 의 webapp 의 절대경로를 알아와야 한다. 
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			String path = root + "resources"+File.separator+"files";
			// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
			String newFileName = ""; // WAS(톰캣) 디스크에 저장할 파일명 
			
			byte[] bytes = null;    // 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도 
			
			//long fileSize = 0;   	// 파일크기를 읽어오기 위한 용도
			
			for(int i=0; i<attachList.size(); i++) { 
				try {
					 bytes = attachList.get(i).getBytes(); // 첨부파일의 내용물(byte)을 읽어옴.
					 
					 // 파일업로드 한 후 업로드되어진 파일명  가져오기
					 newFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
					 // 예를들어 newFileName 에는  2019012519592316420706146795.png 와 같은 것이 들어옴.
					 
					 //fileSize = attachList.get(i).getSize(); // 첨부파일의 파일크기를 알아온다.
					 
					 HashMap<String, String> reviewImageMap = new HashMap<String, String>();
					// 제품1개에 딸린 다중 이미지
					 
					 reviewImageMap.put("fk_review_no", review_no);
					 reviewImageMap.put("wasImgname", newFileName);
					 reviewImageMap.put("orgImgname", attachList.get(i).getOriginalFilename());
					 //reviewImageMap.put("IMAGEFILESIZE", String.valueOf(fileSize));
					 System.out.println("reviewImageMap: "+ reviewImageMap);
					 reviewImageMapList.add(reviewImageMap);
					 
				} catch (Exception e) {	}
				
			}// end of for------------------------------------------------
			
		}// end of if---------------------------------------
		
		
	  // **** 폼에서 입력받은 제품입력정보 값을 
	  //      Service 단으로 넘겨서 테이블에 insert 하기로 한다.
		   
       // 이미지파일첨부가 없는 경우 또는 이미지파일첨부가 있는 경우로 나누어서
	   // Service 단으로 호출하기
	   int n = 0;
	   int m = 0;
	   
	   int count = 0;
	   
	   if(attachList == null) { // 파일이 첨부된것이 없다면
		  
		   n = service.updateReview(reviewMap); // 트랜잭션
	   }
	   else if(attachList != null) { // 파일이 첨부된것이 있다면
		  
		   n = service.updateReview(reviewMap); // 트랜잭션
		   
		   for(int i=0; i<reviewImageMapList.size(); i++) {
			   m = service.addReviewimage(reviewImageMapList.get(i));
			   if(m==1) count++;
		   }
		   
		   if(reviewImageMapList.size() == count) {
			   n=1;
		   }
		   else {
			   n=0;
		   }
	   }
	   mav.addObject("n", n);
	   mav.setViewName("yju/reviewEditEnd");	   
	   return mav; // String 사용하는 view단: views/yju/reviewWrite.jsp 이다.
    	
    }
    
	// 리뷰 삭제하기 oo
    @RequestMapping(value="/reviewDel.bc" , method= {RequestMethod.GET}) 
    public ModelAndView jyuAOP_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
    	
    	// 삭제해야할 글번호를 받아온다.
    	String seq = request.getParameter("seq");
    	int n = service.del(seq);
    	
    	if(n==0) {
    		mav.addObject("msg", "글삭제 실패!!");
    	}
    	else {
    		mav.addObject("msg", "글삭제 성공!!");
    	}
    	
    	HttpSession session = request.getSession();
    	String gobackReviewURL = (String) session.getAttribute("gobackReviewURL");
    	
    	session.removeAttribute("gobackReviewURL");
    	
    	mav.addObject("loc", gobackReviewURL);
		mav.setViewName("msg");

		return mav;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @ResponseBody
    @RequestMapping(value="/topContentJSON.bc" , method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
    public String topContent(HttpServletRequest request) {
    						// VO, form태그(name명), DB컬럼명이 모두 같다면 다음과 같이 해주면 모든 값이 들어온다.
    	
    	String jsonStr = "";

    	try {
    		String hotel_idx = request.getParameter("hotel_idx");
//    		hotel_idx = "4";
    		
    		// 평점 알아오기
    		HashMap<String,Object> gradeMap = service.getreviewGrade(hotel_idx);
    		// 호텔 정보 알아오기
    		KmtHotelInfoVO hotelInfoVO = service.getHotelInfo(hotel_idx);
    		
    		String hotel_Addr = hotelInfoVO.getHotel_Addr1()+" "+hotelInfoVO.getHotel_Addr2()+" "+hotelInfoVO.getHotel_Addr3();
			
			JSONArray jsonArr = new JSONArray();
			
			JSONObject jsonobj = new JSONObject();
			
			// 평점 정보
			jsonobj.put("allGrade", gradeMap.get("allGrade"));
			jsonobj.put("str_allGrade", gradeMap.get("str_allGrade"));
			
			// 호텔 정보
			jsonobj.put("hotel_Name", hotelInfoVO.getHotel_Name());
			
			int hotel_Category = hotelInfoVO.getHotel_Category(); 
			String str_hotel_Category = "";
			
			switch (hotel_Category) {
			case 0:
				str_hotel_Category = "특1급";
				break;
			case 1:
				str_hotel_Category = "특급";
				break;
			case 2:
				str_hotel_Category = "일반";
				break;
			default:
				break;
			}
			jsonobj.put("hotel_Category", str_hotel_Category);
			
			jsonobj.put("hotel_Addr", hotel_Addr);
			
			jsonArr.put(jsonobj);
				
			jsonStr = jsonArr.toString();
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
    	
    	return jsonStr;
    }
    
    
 // 등급 차트 JSON
    @ResponseBody
    @RequestMapping(value="/gradeChartJSON.bc" , method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
    public String gradeChart(HttpServletRequest request) {
    						// VO, form태그(name명), DB컬럼명이 모두 같다면 다음과 같이 해주면 모든 값이 들어온다.
    	
    	String jsonStr = "";

    	try {
    		String hotel_idx = request.getParameter("hotel_idx");
//    		hotel_idx = "4";
    		
    		// 평점 알아오기
    		HashMap<String,Object> gradeMap = service.getreviewGrade(hotel_idx);
    		
    		// 호텔 정보 알아오기
    		KmtHotelInfoVO hotelInfoVO = service.getHotelInfo(hotel_idx);
    		
			JSONArray jsonArr = new JSONArray();
			
			JSONObject jsonobj = new JSONObject();
			
			// 평점 정보
			jsonobj.put("grade0", gradeMap.get("grade0"));
			jsonobj.put("grade1", gradeMap.get("grade1"));
			jsonobj.put("grade2", gradeMap.get("grade2"));
			jsonobj.put("grade3", gradeMap.get("grade3"));
			jsonobj.put("grade4", gradeMap.get("grade4"));
			jsonobj.put("allGrade", gradeMap.get("allGrade"));
			jsonobj.put("allReviewNum", gradeMap.get("allReviewNum"));
			// 호텔 정보
			jsonobj.put("hotel_Name", hotelInfoVO.getHotel_Name());
			int hotel_Category = hotelInfoVO.getHotel_Category(); 
			String str_hotel_Category = "";
			
			switch (hotel_Category) {
			case 0:
				str_hotel_Category = "특1급";
				break;
			case 1:
				str_hotel_Category = "특급";
				break;
			case 2:
				str_hotel_Category = "일반";
				break;
			default:
				break;
			}
			jsonobj.put("hotel_Category", str_hotel_Category);
			
			jsonArr.put(jsonobj);
				
			jsonStr = jsonArr.toString();
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
    	
    	return jsonStr;
    }
 
 	
    // 서비스 JSON
    @ResponseBody
    @RequestMapping(value="/roomServiceJSON.bc" , method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
    public String roomService(HttpServletRequest request) {
    						// VO, form태그(name명), DB컬럼명이 모두 같다면 다음과 같이 해주면 모든 값이 들어온다.
    	
    	String jsonStr = "";

    	try {
    		String hotel_idx = request.getParameter("hotel_idx");
//    		hotel_idx = "4";
    		
    		// 호텔 서비스 정보 알아오기
    		List<HashMap<String, String>> roomServiceList = service.getRoomService(hotel_idx);
    		
    		JSONArray jsonArr = new JSONArray();
    		
    		for(HashMap<String, String> roomServiceMap : roomServiceList) {
    			
    			JSONObject jsonobj = new JSONObject();
    			jsonobj.put("service", roomServiceMap.get("service"));
    			jsonobj.put("status", roomServiceMap.get("status"));
    			
    			String service = roomServiceMap.get("service");
    			String str_service ="";
    			
    			switch (service) {
				case "SPA":
					str_service = "스파";
					break;
				case "MINIBAR":
					str_service = "미니바";
					break;
				case "WIFI":
					str_service = "와이파이";
					break;
				case "TOWEL":
					str_service = "욕실용품";
					break;
				case "TV":
					str_service = "TV";
					break;
				case "AIRCONDITIONER":
					str_service = "에어컨";
					break;
				case "FRIDGE":
					str_service = "냉장고";
					break;
				case "SHOWERROOM":
					str_service = "객실샤워실";
					break;
				case "BATHTUB":
					str_service = "욕조";
					break;
				case "HAIRDRYER":
					str_service = "드라이기";
					break;
				case "IRON":
					str_service = "다리미";
					break;
				case "KITCHEN":
					str_service = "전기밥솥";
					break;
					
				default:
					break;
				}
    			jsonobj.put("str_service", str_service);
    			
    			jsonArr.put(jsonobj);
    		}
			
			jsonStr = jsonArr.toString();
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
    	
    	return jsonStr;
    }
 	
 	
}
