package com.project.yhj.faq;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.common.MyUtil;
import com.project.psb.AdminVO;
import com.project.smh.SmhMemberVO;

@Controller
public class YhjFaqController {

	@Resource
	private YhjFaqService service ;
	
		// 1대1 문의 메인 페이지
		@RequestMapping(value="/faq/main.bc")
		public String faqMain(HttpServletRequest request) {
	
			String msg = "";
			String loc = "";
			
			HttpSession session = request.getSession();
			SmhMemberVO loginuser = (SmhMemberVO)session.getAttribute("loginuser");
			AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
			
			if( loginuser != null && loginadmin == null ) {		
				
				// 고객으로 들어왔을 경우
				
				String fk_idx = String.valueOf(loginuser.getMember_idx());
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
				paraMap.put("fk_idx", fk_idx );
				
				totalCount = service.getFaqTotalCount(fk_idx);
				System.out.println("totalCount : "+totalCount);
				
				totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
				
				List<YhjAllFaqVO> faqList = service.getFaqList(paraMap);
				
				// ** 페이지바 만들기
				int blockSize = 5;
				int loop = 1;
				int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
				
				
				String pageBar = "<ul id='pageBar' style='list-style:none;'>";
				
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
				
				request.setAttribute("faqList", faqList );
				request.setAttribute("pageBar", pageBar );
				
				return "faq/faq_member.tiles_yhj";
				
			}
			
			else if( loginuser == null && loginadmin != null ) {	
				
				// 관리자로 들어왔을 경우
				
				String category = request.getParameter("category");		// 0 은 전체, 1~6은 카테고리 번호 
				String period = request.getParameter("period");			// 0 은 전체, 1은 1주일 이내, 2는 한달 이내
				String replyStatus = request.getParameter("replyStatus");	// 0 은 전체, 1은 답변대기중, 2는 답변완료
				
				if(category == null || "".equals(category) ) category = "0";
				if(period == null || "".equals(period)	) period = "0";
				if(replyStatus == null || "".equals(replyStatus)	) replyStatus = "0";
				
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
				
				System.out.println("category "+category);
				System.out.println("period "+period);
				System.out.println("replyStatus "+replyStatus);
				
				HashMap<String,String> paraMap = new HashMap<String,String>();
				paraMap.put("startRno", String.valueOf(startRno));
				paraMap.put("endRno", String.valueOf(endRno));
				paraMap.put("category", category );
				paraMap.put("period", period );
				paraMap.put("replyStatus", replyStatus );
				
				totalCount = service.getFaqAdminTotalCount(paraMap);
				System.out.println("totalCount : "+totalCount);
				
				totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
				
				List<YhjAllFaqVO> faqList = service.getAdminFaqList(paraMap);
				
				System.out.println("faqList : "+faqList.size());
				
				// ** 페이지바 만들기
				int blockSize = 5;
				int loop = 1;
				int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
				
				
				String pageBar = "<ul id='pageBar' style='list-style:none;'>";
				
				// *** [이전] 만들기 *** //    
				if(pageNo != 1) {
					pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo-1)+"&category="+category+"&period="+period+"&replyStatus="+replyStatus+"' style='color: #999999;'>&lt;</a></li>";
				}
				
				while( !(loop>blockSize || pageNo>totalPage) ) {		// true 면 반복
					
					if(pageNo == currentShowPageNo) {
						pageBar += "<li style='border:solid 1px #d9d9d9; border-radius: 4px; font-weight:bold; padding:0px 4px;'>"+pageNo+"</li>";
					}
					else {
						pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo)+"&category="+category+"&period="+period+"&replyStatus="+replyStatus+"'>"+pageNo+"</a></li>";
					}
					
					loop++;
					pageNo++;
					
				}// end of while---------------------------------
				
				// *** [다음] 만들기 *** //
				if( !(pageNo>totalPage) ) {
					pageBar += "<li><a href='main.bc?currentShowPageNo="+(pageNo+1)+"&category="+category+"&period="+period+"&replyStatus="+replyStatus+"' style='color: #999999;'>&gt;</a></li>"; 
				}
				
				pageBar += "</ul>";
				
				request.setAttribute("category", category );
				request.setAttribute("period", period );
				request.setAttribute("replyStatus", replyStatus );
				request.setAttribute("faqList", faqList );
				request.setAttribute("pageBar", pageBar );
				
				return "faq/faq_admin.tiles_yhj";
				
			}
			else if( loginuser == null && loginadmin == null ){		// 고객, 관리자 둘다 접속되어 있지 않는 경우
				
				msg = "로그인 먼저 해야 합니다.";
				loc = "javascript:location.href='"+request.getContextPath()+"/userLogin.bc'";
				
				request.setAttribute("msg", msg);
				request.setAttribute("loc", loc);
				
				return "msg";
			}
			else {		// 그 외의 경우
				msg = "잘못된 접근입니다.";
				loc = "javascript:history.back();";
				
				request.setAttribute("msg", msg);
				request.setAttribute("loc", loc);
				
				return "msg";
			}
			
			
		} // end of eventMain -----------------------------------
	
	
		// 회원 FAQ 입력하기
		@RequestMapping(value="/faq/memberWrite.bc", method= {RequestMethod.POST})
		public String loginCheck_faqMemberWrite(HttpServletRequest request, HttpServletResponse response, YhjMemberFaqVO fvo) {
			
			HttpSession session = request.getSession();
			SmhMemberVO loginuser = (SmhMemberVO) session.getAttribute("loginuser");
			fvo.setFk_idx(String.valueOf(loginuser.getMember_idx()));
			String content = fvo.getContent();
			content = MyUtil.replaceParameter(content);
			content = content.replaceAll("\r\n", "<br>");
			fvo.setContent(content);
			
			int n = service.insertMemberFaq(fvo);
			
			if( n==1)	request.setAttribute("msg", "정상적으로 등록되었습니다." );
			else 	request.setAttribute("msg", "질문 등록에 실패했습니다." );
			
			request.setAttribute("loc", request.getContextPath()+"/faq/main.bc" );
			
			return "msg";
		}
		
		@ResponseBody
		@RequestMapping(value="/faq/adminWrite.bc", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String adminCheck_WriteFaqAdminReply(HttpServletRequest request, HttpServletResponse response) {
			
			String jsonStr = "";
			
			String fk_no = request.getParameter("no");
			String content = request.getParameter("reply_content");
			HttpSession session = request.getSession();
			AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
			String fk_admin_idx = String.valueOf(loginadmin.getAdmin_idx());
			
			content = MyUtil.replaceSmartEditor(content);
			
			HashMap<String,String> paraMap = new HashMap<String,String>();
			paraMap.put("fk_no", fk_no );
			paraMap.put("content", content );
			paraMap.put("fk_admin_idx", fk_admin_idx );
			
			int n = service.writeFaqAdminReply(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			if( n==1 ) {
				
				jsonObj.put("msg", "success");
				jsonObj.put("rep_content", content);
				jsonStr = jsonObj.toString();
			}
			else {
				
				jsonObj.put("msg", "fail");
				jsonStr = jsonObj.toString();
			}
			return jsonStr;
		}
		
		
	
} // end of controller ----------------------------------------------
