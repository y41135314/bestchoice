package com.project.yhj.notice;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.common.MyUtil;
import com.project.psb.AdminVO;

@Controller
public class YhjNoticeController {

	@Resource
	private YhjNoticeService service ;
	
	// 공지사항 메인 페이지
	@RequestMapping(value="/notice/main.bc")
	public String noticeMain(HttpServletRequest request) {

		
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
		
		totalCount = service.getNoticeTotalCount();
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		List<YhjNoticeVO> noticeList = service.getNoticeList(paraMap);
		
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
		
//		if(noticeList != null) {
//			
//			for(YhjNoticeVO nvo : noticeList) {
//				
//				nvo.setContent(MyUtil.reverseReplaceParam(nvo.getContent()));
//			}
//		}
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("noticeList", noticeList);
		
		return "notice/notice.tiles_yhj";
	} // end of eventMain -----------------------------------
		
	
	
	
	// 공지사항 작성/수정 페이지 (관리자만 )
	@RequestMapping(value="/notice/write.bc")
	public String adminCheck_noticeWrite(HttpServletRequest request, HttpServletResponse response) {
		
		String revise = request.getParameter("revise");
		
		if(revise != null && !revise.isEmpty()) {
			
			String no = request.getParameter("no");
			YhjNoticeVO nvo = service.getOneNotice(no);
			
			nvo.setTitle(MyUtil.reverseSmartEditor(nvo.getTitle()));
			
			nvo.setContent(MyUtil.reverseSmartEditor(nvo.getContent()));
			
			request.setAttribute("revise", revise);
			request.setAttribute("nvo", nvo);
		}
		
		
		return "notice/notice_write.tiles_yhj";
	} // end of eventMain -----------------------------------
	
	
	
	
	// 공지사항 작성/수정 완료하기 ( 관리자만 )
	@RequestMapping(value="/notice/writeEnd.bc", method= {RequestMethod.POST})
	public String adminCheck_noticeWriteEnd(HttpServletRequest request, HttpServletResponse response, YhjNoticeVO nvo) {
		
		String msg = "";
		
		System.out.println(nvo.getRevise());
		
		
		HttpSession session = request.getSession();
		AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
		
		nvo.setFk_admin_idx(loginadmin.getAdmin_idx());
		
		nvo.setTitle(MyUtil.replaceSmartEditor(nvo.getTitle()));
		nvo.setContent(MyUtil.replaceSmartEditor(nvo.getContent()));
		
		
		
		if( nvo.getRevise().trim().isEmpty() ) {		// 새로 쓰는 글
			
			int n = service.writeOneNotice(nvo);
			
			if(n==1)	msg="정상적으로 글이 등록되었습니다.";
			else 	msg="글 작성에 실패했습니다.";
		}
		else {		// 수정하는 글
			
			int n = service.reviseOneNotice(nvo);
			
			if(n==1)	msg="정상적으로 글이 등록되었습니다.";
			else 	msg="글 작성에 실패했습니다.";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", "main.bc");
		
		return "msg";
	}
	
	
	@RequestMapping(value="/notice/delete.bc")
	public String adminCheck_noticeDelete(HttpServletRequest request, HttpServletResponse response) {
		
		String no = request.getParameter("no");
		
		int n = service.noticeDelete(no);
		
		String msg = "";
		
		if(n==1) {
			msg="정상적으로 삭제되었습니다.";
		}
		else {
			msg="삭제에 실패했습니다.";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", "main.bc");
		
		return "msg";
	}
	
	
	
	
} // end of controller ----------------------------------------------
