package com.project.yhj.event;

import java.io.File;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.common.FileManager;
import com.project.common.MyUtil;
import com.project.psb.AdminVO;
import com.project.smh.SmhMemberVO;
import com.project.yhj.notice.YhjNoticeVO;

@Controller
public class YhjEventController {

	@Resource
	private YhjEventService service ;
	
	@Autowired
	private FileManager fileManager;
	
	
		// 이벤트 메인 페이지
		@RequestMapping(value="/event/main.bc")
		public String eventMain(HttpServletRequest request) {
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			// ** 페이지바 생성하기 위해 필요한 것들 ** 
			int totalCount = 0;			// 총 게시물 건수 
			int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 수
			int currentShowPageNo =0;	// 현재 보여주는 페이지 번호 ( 초기 설정 1 )
			int totalPage = 0;			// 웹에 보여줄 총 페이지 갯수 ( 페이지바 )
			
			int startRno = 0;			// 시작행번호
			int endRno = 0;				// 끝행번호
			
			if(str_currentShowPageNo != null && !str_currentShowPageNo.isEmpty()) {
				
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				} catch (Exception e) {
					currentShowPageNo = 1;
				}
			}
			else {
				currentShowPageNo = 1;
			}
			
			startRno = (currentShowPageNo -1 ) * sizePerPage +1 ;
			endRno = startRno + sizePerPage -1;
			
			HashMap<String,String> paraMap = new HashMap<String,String>();
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			totalCount = service.getEventTotalCount();
			System.out.println("totalCount : "+totalCount);
			
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
			
			List<HashMap<String,String>> eventList = service.getEventList(paraMap);
			
			// ** 페이지바 만들기
			int blockSize = 5;
			int loop = 1;
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			
			String pageBar = "<ul id='pageBar'>";
			
			// *** [이전] 만들기 *** //    
			if(pageNo != 1) {
				pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo-1)+"' style='color: #999999;'>&lt;</a></li>";
			}
			
			while( !(loop>blockSize || pageNo>totalPage) ) {		// true 면 반복
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='border:solid 1px #d9d9d9; border-radius: 4px; font-weight:bold; padding:0px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo)+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
				
			}// end of while---------------------------------
			
			// *** [다음] 만들기 *** //
			if( !(pageNo>totalPage) ) {
				pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo+1)+"' style='color: #999999;'>&gt;</a></li>"; 
			}
			
			pageBar += "</ul>";
			
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("eventList", eventList);
			
			
			return "event/event.tiles_yhj";
		} // end of eventMain -----------------------------------
		
		

		
		// 이벤트 페이지 보기
		@RequestMapping(value="/event/detail.bc")
		public String eventDetail(HttpServletRequest request) {
			
			String event_code = request.getParameter("no");
			
			HashMap<String,String> eventMap = service.getOneEventWithLagLead(event_code);
			List<HashMap<String,String>> eventImgMapList = service.getOneEventImg(event_code);
			
			request.setAttribute("eventMap", eventMap );
			request.setAttribute("eventImgMapList", eventImgMapList );
			
			return "event/eventDetail"+event_code+".tiles_yhj";
		}
		
		
		
		
		// 이벤트 작성/수정 페이지
		@RequestMapping(value="/event/write.bc")
		public String adminCheck_eventWrite(HttpServletRequest request, HttpServletResponse response) {
	
			// 수정 사항 긁어오기
			String event_code = request.getParameter("event_code");
			
			if(event_code != null && !event_code.isEmpty()) {
				
				try {
					int event_code_num = Integer.parseInt(event_code);
					
					if(event_code_num <= 0 ) {
						request.setAttribute("msg", "잘못된 접근입니다.");
						request.setAttribute("loc", "javascript:history.back()");
						
						return "msg";
					}
					else {

						HashMap<String,String> eventMap = service.getOneEvent(event_code);
						List<HashMap<String,String>> eventImgMap = service.getOneEventImg(event_code);
						 
						eventMap.put("event_name", MyUtil.reverseReplaceParam(eventMap.get("event_name")));
						
						String event_explain = eventMap.get("event_explain");
						event_explain = MyUtil.reverseReplaceParam(event_explain);
						event_explain = event_explain.replaceAll("<br>","\r\n");
						
						eventMap.put("event_explain", event_explain );
						
						request.setAttribute("eventMap", eventMap);
						request.setAttribute("eventImgMap", eventImgMap);
						request.setAttribute("revise", "1");
						request.setAttribute("event_code", event_code);
					}
					
					
				} catch (NumberFormatException e) {
					request.setAttribute("msg", "잘못된 접근입니다.");
					request.setAttribute("loc", "javascript:history.back()");
					
					return "msg";
				}
			}
			
			return "event/event_write.tiles_yhj";
		} // end of eventMain -----------------------------------
		
		
		
		
		
		// 이벤트 작성/수정 완료
		@RequestMapping(value="/event/writeEnd.bc", method= {RequestMethod.POST} )
		public String adminCheck_eventWriteEnd(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mprequest) {
	
			String revise = mprequest.getParameter("revise");
			String event_code = mprequest.getParameter("event_code");
			
			HttpSession session = mprequest.getSession();
			AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
			
			// 불러온 이벤트로 입력하기
			String event_name = mprequest.getParameter("event_name");
			String event_explain = mprequest.getParameter("event_explain");
			String event_discountMon = mprequest.getParameter("event_discountMon");
			String event_discountPct = mprequest.getParameter("event_discountPct");
			String event_startday = mprequest.getParameter("event_startday");
			String event_endday = mprequest.getParameter("event_endday");
			
			event_name = MyUtil.replaceParameter(event_name);
			event_explain = MyUtil.replaceParameter(event_explain);
			event_explain = event_explain.replaceAll("\r\n", "<br>");
			
			HashMap<String,String> paraMap = new HashMap<String,String>();	// 이벤트 담을 해쉬맵
			paraMap.put("revise", revise );
			paraMap.put("event_code", event_code );
			paraMap.put("fk_admin_idx", loginadmin.getAdmin_idx());
			paraMap.put("event_name", event_name );
			paraMap.put("event_explain", event_explain );
			paraMap.put("event_discountMon", event_discountMon );
			paraMap.put("event_discountPct", event_discountPct );
			paraMap.put("event_startday", event_startday );
			paraMap.put("event_endday", event_endday );
			
			
			List<HashMap<String,String>> imageMapList = new ArrayList<HashMap<String,String>>();	// 이미지만 담을 해쉬맵 리스트
			
			// 이미지 삽입하기
			List<MultipartFile> attachList = mprequest.getFiles("attach"); 	// view 에서 받아온 이미지 파일들 ( 4개 )
			
			String root = session.getServletContext().getRealPath("/"); 
			String path = root + "resources"+File.separator+"images"+File.separator+"yhj"+File.separator+"event";
			
			System.out.println("이벤트 이미지 저장 장소 : "+path);
			
			String wasFilename = "";		// was 에 저장되는 이름
			byte[] bytes = null;    // 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도 

			for(int i=0; i<attachList.size(); i++) { 
				
				if(attachList.get(i).getOriginalFilename() != null && !attachList.get(i).getOriginalFilename().isEmpty()   ) {
					
					try {
						 bytes = attachList.get(i).getBytes(); 	// 첨부파일의 내용물(byte)을 읽어옴.
						 
						 // 파일업로드 한 후 업로드되어진 파일명  가져오기
						 wasFilename = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						 
						 HashMap<String, String> imageMap = new HashMap<String, String>();
						 
						 imageMap.put("wasFilename", wasFilename);
						 imageMap.put("orgFilename", attachList.get(i).getOriginalFilename());
						 
						 imageMapList.add(imageMap);
						 
					} catch (Exception e) {	}
					
				}
				
			}// end of for------------------------------------------------
			
			int n = service.insertOrReviseEvent( paraMap,imageMapList );
			
			String msg = "";
			if(n==1) msg="이벤트 등록/수정에 성공했습니다.";
			else {
				
				if(revise != null && !revise.isEmpty()) {
					msg="이벤트 수정에 실패했습니다.";
				}
				else {
					msg="이벤트 등록에 실패했습니다.";
				}
				
			}
			
			mprequest.setAttribute("msg", msg);
			mprequest.setAttribute("loc", mprequest.getContextPath()+"/event/main.bc" );	
			
			return "msg";
		} // end of eventMain -----------------------------------
		
		
		
		// 이벤트 삭제하기 
		@RequestMapping(value="/event/delete.bc")
		public String adminCheck_delete(HttpServletRequest request, HttpServletResponse response) {
			
			String event_code = request.getParameter("event_code");
			int n = service.deleteEvent(event_code);
			String msg = "";
			
			if(n==1)  msg = "이벤트가 정상적으로 삭제되었습니다.";
			else  msg = "이벤트 삭제에 실패하였습니다.";
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", "main.bc");
			
			return "msg";
		}
		
		
		
		// ---------------------------------------- 이벤트 실제 구현 파트 ------------------------------------------------
		
		// 4번 이벤트 구현하기 ( 적립금 추가하기 )
		@RequestMapping(value="/event/detailEnd4.bc", method= {RequestMethod.POST})
		public String loginCheck_eventDetailEnd4(HttpServletRequest request, HttpServletResponse response) {
			
			HttpSession session = request.getSession();
			SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
			
			String fk_idx = String.valueOf(loginuser.getMember_idx());
			String event_code = request.getParameter("event_code");
			
			System.out.println(fk_idx);
			System.out.println(event_code);
						
			HashMap<String,String> paraMap = new HashMap<String,String>();
			paraMap.put("fk_idx", fk_idx );
			paraMap.put("event_code", event_code );
			
			int result = service.doEventEnd4(paraMap);
			
			if(result==1) {
				request.setAttribute("msg", "적립금이 추가되었습니다.");
				request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/event/detail.bc?no=4'");
			}
			else if ( result==0 ) {
				request.setAttribute("msg", "이미 적립금을 추가받으셨습니다.");
				request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/event/detail.bc?no=4'");
			}

			return "msg";
		}
		
		
		// 6번 이벤트 구현하기  ( 쿠폰 추가하기 ) 
		@RequestMapping(value="/event/detailEnd6.bc", method= {RequestMethod.POST})
		public String loginCheck_eventDetailEnd6(HttpServletRequest request, HttpServletResponse response) {
			
			HttpSession session = request.getSession();
			SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
			
			String fk_idx = String.valueOf(loginuser.getMember_idx());
			String event_code = request.getParameter("event_code");
			
			// System.out.println(fk_idx);
			// System.out.println(event_code);
			
			HashMap<String,String> paraMap = new HashMap<String,String>();
			paraMap.put("fk_idx", fk_idx );
			paraMap.put("event_code", event_code );
			
			int n = service.doEventEnd6(paraMap);
			
			if(n==1) {
				request.setAttribute("msg", "쿠폰이 발급되었습니다.");
				request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/event/detail.bc?no=6'");
			}
			else if ( n==0 ) {
				request.setAttribute("msg", "이미 발급된 쿠폰이 있습니다.");
				request.setAttribute("loc", "javascript:location.href='"+request.getContextPath()+"/event/detail.bc?no=6'");
			}

			return "msg";
		}
		
		
	
} // end of controller ----------------------------------------------
