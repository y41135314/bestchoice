package com.project.psb;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.project.common.MyUtil;

@Controller
public class PsbController {

	@Autowired
	private PsbService service ;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/adminLogin.bc")
	public String loginAdmin(HttpServletRequest request) {
		return "psb/adminLogin";
	}
	
	@RequestMapping(value="/loginAdminEnd.bc", method= {RequestMethod.POST})
	public ModelAndView loginAdminEnd(HttpServletRequest request, ModelAndView mav) {
		String adminId = request.getParameter("adminId");
		String adminPwd = request.getParameter("adminPwd");
		
		HashMap<String, String> paraMap = new HashMap<String, String>(); 
	 	paraMap.put("adminId", adminId);
		paraMap.put("adminPwd", adminPwd);   //  SHA256.encrypt(pwd)   ######
		
		AdminVO loginadmin = service.getLoginAdmin(paraMap);
		
		HttpSession session = request.getSession();
		
		if(loginadmin == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("psb/msg");
		}
		else {
			session.setAttribute("loginadmin", loginadmin);
			mav.setViewName("psb/main");
		}
		return mav;
	}
	
	@RequestMapping(value="/main.bc")
	public String main(HttpServletRequest request) {
		
		return "psb/main";
	}
	
	@RequestMapping(value="/main_logout.bc")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();

		if(session.getAttribute("loginadmin") != null) {
			session.removeAttribute("loginadmin");	
		}
		
		mav.setViewName("psb/main");
		return mav;
	}
	
	@RequestMapping(value="/adminMember_list.bc")
	public ModelAndView adminMember(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminMember_list.tilesSBM");
		return mav;
	}
	
	@RequestMapping(value="/adminMember_chart.bc")
	public ModelAndView adminMember_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminMember_chart.tilesSBM");
		return mav;
	}
	
	@RequestMapping(value="/adminSeller_list.bc")
	public ModelAndView adminSeller_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminSeller_list.tilesSBS");
		return mav;
	}
	
	@RequestMapping(value="/adminSeller_chart.bc")
	public ModelAndView adminSeller_chart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminSeller_chart.tilesSBS");
		return mav;
	}
	
	@RequestMapping(value="/adminHotel_list.bc")
	public ModelAndView adminHotel_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminHotel_list.tilesSBS");
		return mav;
	}
	
	@RequestMapping(value="/adminHotel_chart.bc")
	public ModelAndView adminHotel_chart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminHotel_chart.tilesSBS");
		return mav;
	}
	
	
	@RequestMapping(value="/salesStatistic.bc")
	public ModelAndView adminSalesStatistic(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/salesStatistic.tilesSBSAT");
		return mav;
	}
	
	@RequestMapping(value="/adminReservList.bc")
	public ModelAndView adminReservList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminReservList.tilesSBSAT");
		return mav;
	}
	
	@RequestMapping(value="/memberDetail.bc")
	public ModelAndView adminMemberDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/memberDetail.tilesSBM");
		return mav;
	}

	@RequestMapping(value="/sellerDetail.bc")
	public ModelAndView adminSellerDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/sellerDetail.tilesSBS");
		return mav;
	}
	
	@RequestMapping(value="/hotelDetail.bc")
	public ModelAndView adminHotelDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/hotelDetail.tilesSBS");
		return mav;
	}
	
	///////////////////////////================================================/////////////////////////////////
	//////////////////// 관리자 게시판 ///////////////////////////
	
	@RequestMapping(value="/adminCommentBoard.bc")
	public ModelAndView adminCommentBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<BoardVO> boardList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 5;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if( searchWord == null || searchWord.trim().isEmpty() ) {
		searchWord = "";
		}
		
		HashMap<String, String> paraMap = new HashMap<String,String>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 총 게시물 건수를 구해와야 한다. 
		// 총 게시물 건수는 검색조건이 있을 때와 없을때로 나누어진다.
		
		if("".equals(searchWord)) {  // 검색조건이 없을 경우의 총 게시물 건수(totalCount)
		totalCount = service.getTotalCountWithNoSearch();
		}
		else { 	// 검색조건이 있을 경우의 총 게시물 건수(totalCount)
		totalCount = service.getTotalCountWithSearch(paraMap);
		}
		
		totalPage = (int)Math.ceil( (double)totalCount/sizePerPage );
		
		// 게시판에 보여지는 초기화면 
		if(str_currentShowPageNO == null ) {
			currentShowPageNO = 1;  // 첫 페이지는 1페이지 
		}
		else {
			try {
				currentShowPageNO = Integer.parseInt(str_currentShowPageNO);
				
				if(currentShowPageNO < 1 || currentShowPageNO > totalPage) {
					currentShowPageNO = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNO = 1;
			}
		}
	
		startRno = ((currentShowPageNO-1)*sizePerPage) + 1;
		endRno = startRno + sizePerPage -1;
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징 처리한 글목록 보여주기 (검색어 유무와는 상관 없음. 모두 포함함)
		boardList = service.boardListWithPaging(paraMap);  // paraMap : searchType,searchWord,startRno,endRno
		
		// 검색어 값을 유지시키기 위함 
		if( !"".equals(searchWord)) {
			mav.addObject("paraMap",paraMap);
		}
		
		// === 페이지바 만들기 === /// 
		String pagebar = "<ul>";
		
		int blockSize = 5;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		/*
		1 2 3 4 5           -- 1개 블럭 
		6 7 8 9 10  -- 1개 블럭  
		*/
		
		int loop = 1;
		/*
		loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은  10개(==blockSize))까지만 증가하는 용도이다. 
		*/
		
		int pageNo = ((currentShowPageNO - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		
		String url = "adminCommentBoard.bc";	
		// *** [이전] 만들기 *** //    
		if(pageNo != 1) {
			pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
		}
		
		while( !(loop>blockSize || pageNo>totalPage) ) {
		
			if(pageNo == currentShowPageNO) {
				pagebar += "&nbsp;<span style='color: red; border: 1px solid gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
			}
			else {
			pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;"; 
			// ""+1+"&nbsp;"+2+"&nbsp;"+3+"&nbsp;"+......+10+"&nbsp;"
			}
			
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// *** [다음] 만들기 *** //
		if( !(pageNo>totalPage) ) {
			pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;"; 
		}
		
		pagebar += "</ul>";
		
		mav.addObject("pagebar", pagebar);
		
		///////////////////////////////////////////////////////////////////////////////////
		
		/* === 페이징 처리한 후 특정 글 제목 클릭 => 상세 내용을 본 후 다시 목록보기 버튼을 클릭했을 때, 돌아갈 페이지를 알려주기 위해
		현재 페이지 주소를 view 단으로 넘겨준다. ===
		*/
		String gobackURL = MyUtil.getCurrentURL(request); // 우리가 만든 URL 알아오는 메소드 
		mav.addObject("gobackURL", gobackURL);
		
		///////////////////////////////////////////////////////////////////////////////////
		mav.addObject("boardList", boardList);
	
		mav.setViewName("tilesSB/board/adminCommentBoard.tilesSBS");
		
		return mav;
	}
	
	@RequestMapping(value="/adCommentDetail.bc")
	public ModelAndView adminCommentDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String adminBoard_idx = request.getParameter("adminBoard_idx");
		String rno = request.getParameter("rno");
		
		String gobackURL = request.getParameter("gobackURL");
		mav.addObject("gobackURL",gobackURL);
		
		BoardVO boardvo = null;
		
		boardvo = service.getViewWithNoAddCount(adminBoard_idx);
		
		// === 댓글쓰기가 있는 게시판의 경우, 원글의 내용과 원글에 달린 댓글의 내용도 함께 보여준다. === // 
		/*List<CommentVO> commentList = service.getCommentList(adminBoard_idx);  // 원글에 달린 댓글 조회 
		mav.addObject("commentList", commentList);*/
		/////////////////////////////////////////////	
		mav.addObject("boardvo", boardvo);
		mav.addObject("rno", rno);
		mav.setViewName("tilesSB/board/adCommentDetail.tilesSBS");
		return mav;
	}
	
	// 관리자 게시판 글쓰기
	@RequestMapping(value="/adminWrite.bc")
	public ModelAndView adminWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/board/adminWrite.tilesSBS");
		
		// === #130. 답변 글쓰기가 추가된 경우 === // 
		String fk_seq =request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno",groupno);
		mav.addObject("depthno", depthno);	
		
		return mav;
	}

	// 관리자 게시판 글쓰기 완료 
	@RequestMapping(value="/adminBoardEnd.bc", method={RequestMethod.POST} )
	public String addEnd(BoardVO boardvo, MultipartHttpServletRequest mrequest) {	
		 
		MultipartFile attach = boardvo.getAttach();
		
		if (!attach.isEmpty()) {
			
			// WAS 의  webapp/resources/files 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "files";
		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
		 	  
		 	/*
			   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기        
			*/
		 	String newFileName = "";  // WAS(톰캣)의 디스크에 저장될 파일명 (중복방지를 위해 파일명을 다르게 만들 것임)
		 	
		 	byte[] bytes = null; 	 // 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	long fileSize = 0; 	    // 파일크기를 읽어오기 위한 용도 
		 	
		 	try {
				bytes = attach.getBytes();
				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 이제 파일올리기를 한다.  ==> 의존객체 fileManager, FileManager에서 만든 doFileUpload 메소드
				
				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다. 
				  // ==> 원래 있는 메소드(첨부된 파일명 가져오는 것)
			
				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
				boardvo.setFileName(newFileName);
				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.png)
				
				boardvo.setOrgFilename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
				
				fileSize = attach.getSize();
				boardvo.setFileSize(String.valueOf(fileSize));
				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
				
			} catch (Exception e) {
				e.printStackTrace();
			}

		}  // ========= !!첨부파일이 있는지 없는지 알아오기 끝!! ========= */ 
		
		boardvo.setTitle(MyUtil.replaceParameter(boardvo.getTitle()));
		boardvo.setContent(MyUtil.replaceParameter(boardvo.getContent()));
		boardvo.setContent(boardvo.getContent().replaceAll("\r\n","<br/>"));
	
		// === 파일첨부가 있는 경우와 없는 경우에 따라서 Service단 호출하기 === // 
		int n = 0;
		if(attach.isEmpty()) {
			// 첨부파일이 없는 경우이라면
			n = service.add(boardvo); 
		}
		else {
			// 첨부파일이 있는 경우이라면
			n = service.add_withFile(boardvo);
		}
		
		mrequest.setAttribute("n", n);
		return "psb/board/addEnd";
	}
	
	// 첨부파일 다운 
	@RequestMapping(value="/adminDownload.bc", method={RequestMethod.GET} )
	public void adminDownload(HttpServletRequest request, HttpServletResponse response) {
		String adminBoard_idx = request.getParameter("adminBoard_idx");
		BoardVO vo = service.getViewWithNoAddCount(adminBoard_idx); 

		String fileName = vo.getFileName(); 
		// 201907250930481985323774614.png 와 같은 것이다.
		// 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
		
		String orgFilename = vo.getOrgFilename(); 
		
		HttpSession session = request.getSession();
		
		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"files";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
		
		// **** 다운로드 하기 **** //
		// 다운로드가 실패할 경우 메시지를 띄워주기 위해서
		// boolean 타입 변수 flag 를 선언한다.
		boolean flag = false;
		
		flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
		// 다운로드가 성공이면 true 를 반납해주고,
		// 다운로드가 실패이면 false 를 반납해준다.
		
		if(!flag) {
			// 다운로드가 실패할 경우 메시지를 띄워준다.
			
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = null;
			
			try {
				writer = response.getWriter();
				// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
			} catch (IOException e) {
				
			}
			writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");    
		}
		 
	}
	
	// 관리자 게시판 글쓰기 수정
	@RequestMapping(value="/adCommentUpdate.bc", method={RequestMethod.GET} )
	public ModelAndView adminCommentUpdate(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		// 수정해야 할 글 번호 가져오기
		String adminBoard_idx = request.getParameter("adminBoard_idx");
		
		// 수정해야 할 글 내용 가져오기 
		BoardVO boardvo = null;
		boardvo = service.getViewWithNoAddCount(adminBoard_idx); 
		
		HttpSession session = request.getSession();
		AdminVO loginadmin= (AdminVO)session.getAttribute("loginadmin");
		
		mav.addObject("boardvo", boardvo);
		
		if ( (!loginadmin.getAdminId().equals(boardvo.getFk_adminId())) && loginadmin.getGrade() != 10 ) {
			// 다른 사용자의 글 수정 버튼 클릭 
			String msg = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("psb/msg");
		}
		else {
			mav.addObject("boardvo", boardvo);
			mav.setViewName("tilesSB/board/adminEdit.tilesSBS");
		} 
		
		return mav;
	}
	
	// 업로드한 파일 삭제
	@ResponseBody
	@RequestMapping(value="/fileDel.bc", produces="text/plain;charset=UTF-8" )
	public String fileDel(HttpServletRequest request, HttpServletResponse response,  BoardVO boardvo) {
		
		String jsonStr = "";
		JSONObject jsonObj = new JSONObject();

		String adminBoard_idx = request.getParameter("adminBoard_idx");
		
		boardvo = service.getViewWithNoAddCount(adminBoard_idx); 
		String fileName  = boardvo.getFileName();
		
		HttpSession session = request.getSession();
	 	String root = session.getServletContext().getRealPath("/");
	 	String path = root + "resources" + File.separator + "files" + "/" + fileName;
	
	 	File file = new File(path);
		
	 	if (file.delete()) {
			
	 		int n = service.fileDel(adminBoard_idx);
	 		jsonObj.put("n", n);
		}
		jsonStr = jsonObj.toString();
		return jsonStr;
	}
	
	// === 글수정 페이지 완료하기  === // 
	@RequestMapping(value="/adBoardEditEnd.bc", method={RequestMethod.POST} )
	public ModelAndView adBoardEditEnd(MultipartHttpServletRequest mrequest, HttpServletResponse response, 
			                                 BoardVO boardvo, ModelAndView mav) {
		
		MultipartFile attach = boardvo.getAttach();
		
		if (!attach.isEmpty()) {
		
			// WAS 의  webapp/resources/files 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
		 	String root = session.getServletContext().getRealPath("/");
		 	String path = root + "resources" + File.separator + "files";
		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
		 	  
		 	/*
			   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기        
			*/
		 	String newFileName = "";  // WAS(톰캣)의 디스크에 저장될 파일명 (중복방지를 위해 파일명을 다르게 만들 것임)
		 	
		 	byte[] bytes = null; 	 // 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		 	
		 	long fileSize = 0; 	    // 파일크기를 읽어오기 위한 용도 
		 	
		 	try {
				bytes = attach.getBytes();
				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 이제 파일올리기를 한다.  ==> 의존객체 fileManager, FileManager에서 만든 doFileUpload 메소드
				
				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다. 
				  // ==> 원래 있는 메소드(첨부된 파일명 가져오는 것)
			
				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
				boardvo.setFileName(newFileName);
				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.png)
				
				boardvo.setOrgFilename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
				
				fileSize = attach.getSize();
				boardvo.setFileSize(String.valueOf(fileSize));
				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
				
			} catch (Exception e) {
				e.printStackTrace();
			}

		}  // ========= !!첨부파일이 있는지 없는지 알아오기 끝!! ========= */ 
	
		boardvo.setTitle(MyUtil.replaceParameter(boardvo.getTitle()));
		boardvo.setContent(MyUtil.replaceParameter(boardvo.getContent()));
		boardvo.setContent(boardvo.getContent().replaceAll("\r\n","<br/>"));
		
		// === 파일첨부가 있는 경우와 없는 경우에 따라서 Service단 호출하기 === // 
		int n = 0;
		if(attach.isEmpty()) {
			// 첨부파일이 없는 경우이라면
			n = service.edit(boardvo); 
		}
		else {
			// 첨부파일이 있는 경우이라면
			n = service.edit_withFile(boardvo);
		}
			
		mav.addObject("n", n);
		mav.addObject("msg","글 수정 완료");
		mav.addObject("loc", mrequest.getContextPath() + "/adCommentDetail.bc?adminBoard_idx="+boardvo.getAdminBoard_idx() );

		mav.setViewName("psb/msg");
	
		return mav;
	}
	
	// 글 삭제 페이지 요청
	@RequestMapping(value="/adCommentDelete.bc", method={RequestMethod.GET} )
	public ModelAndView adminCommentDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String adminBoard_idx = request.getParameter("adminBoard_idx");
		
		BoardVO boardvo = null;
		boardvo = service.getViewWithNoAddCount(adminBoard_idx); 
		
		HttpSession session = request.getSession();
		AdminVO loginadmin= (AdminVO)session.getAttribute("loginadmin");
		
		mav.addObject("boardvo", boardvo);
		
		if ((!loginadmin.getAdminId().equals(boardvo.getFk_adminId())) && loginadmin.getGrade() != 10 ) {
			// 다른 사용자의 글 수정 버튼 클릭 
			String msg = "다른 사용자의 글은 삭제가 불가합니다.";
			String loc = "javascript:history.back()";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("psb/msg");
		}
		else {
			int n = service.adBoardDel(boardvo);
			if (n==1) {
				mav.addObject("msg", "글이 삭제되었습니다.");
				mav.addObject("loc", request.getContextPath()+ "/adminCommentBoard.bc");
				mav.setViewName("psb/msg");	
			}
		} 
		return mav;
	}
	
	
	
}	
