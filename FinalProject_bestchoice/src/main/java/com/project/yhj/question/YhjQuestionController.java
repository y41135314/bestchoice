package com.project.yhj.question;

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
public class YhjQuestionController {

	@Resource
	private YhjQuestionService service ;
	
		
		// 자주묻는질문 메인 페이지 
		@RequestMapping(value="/question/main.bc")
		public String questionMain(HttpServletRequest request) {
	
			String category = request.getParameter("category");
			if(category == null || category.isEmpty()) {
				category = "1";
			}
			
			// 리스트 받아오기
			List<YhjQuestionVO> questionList = service.getQuestionList(category);
			
			
			request.setAttribute("category", category );
			request.setAttribute("questionList", questionList );
			
			return "question/question.tiles_yhj";
		} // end of eventMain -----------------------------------
		
		
		
		// 자주묻는질문 수정하기/쓰기 페이지 요청
		@RequestMapping(value="/question/write.bc")
		public String adminCheck_questionWrite(HttpServletRequest request, HttpServletResponse response) {
			
			String revise = request.getParameter("revise");
			String no = request.getParameter("no");
			
			if(revise != null && !revise.isEmpty()) {
				
				YhjQuestionVO qvo = service.getOneQuestion(no);
				
				qvo.setTitle(MyUtil.reverseReplaceParam(qvo.getTitle()));
				
				qvo.setContent(MyUtil.reverseReplaceParam(qvo.getContent()));
				qvo.setContent(qvo.getContent().replaceAll("<br>", "\r\n")  );
				
				request.setAttribute("revise", revise);
				request.setAttribute("qvo", qvo);
			}
			
			return "question/question_write.tiles_yhj";
		} // end of eventMain -----------------------------------
		
		
		
		// 자주묻는질문 수정하기/쓰기 insert 하기 
		@RequestMapping(value="/question/writeEnd.bc", method= {RequestMethod.POST} )
		public String adminCheck_questionWriteEnd(HttpServletRequest request, HttpServletResponse response, YhjQuestionVO qvo) {
			
			String msg = "";
			String loc = "";
			
			HttpSession session = request.getSession();
			AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
			
			qvo.setFk_admin_idx(loginadmin.getAdmin_idx());
			
			qvo.setTitle(MyUtil.replaceParameter(qvo.getTitle()));
			qvo.setContent(MyUtil.replaceParameter(qvo.getContent()));
			qvo.setContent(qvo.getContent().replaceAll("\r\n", "<br>")  );
			
			if(qvo.getRevise().trim().isEmpty()) {		// 처음 쓰는 글
				
				int n = service.questionWrite(qvo);
				
				if(n==1) {
					msg="정상적으로 글이 등록되었습니다.";
					loc="main.bc?category="+qvo.getCategory();
				}
				else {
					msg="글 작성에 실패했습니다.";
					loc="main.bc";
				}
			}
			else {		// 수정하기
				
				int n = service.questionRevise(qvo);
				
				if(n==1) {
					msg="정상적으로 글이 수정되었습니다.";
					loc="main.bc?category="+qvo.getCategory();
				}
				else {
					msg="글 수정에 실패했습니다.";
					loc="main.bc?category="+qvo.getCategory();
				}
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			return "msg";
		} // end of eventMain -----------------------------------
				
	
		// 자주묻는질문 삭제하기
		@RequestMapping(value="/question/delete.bc")
		public String adminCheck_questionDelete(HttpServletRequest request, HttpServletResponse response) {
			
			String no = request.getParameter("no");
			
			int n = service.questionDelete(no);
			
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
