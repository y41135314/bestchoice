package com.project.psb;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.project.common.FileManager;
import com.project.common.MyUtil;
import com.project.dws.DwoReservationVO;
import com.project.kmt.KmtHotelInfoVO;
import com.project.kmt.KmtSellerMemberVO;
import com.project.smh.SmhMemberVO;


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
		
		if(session.getAttribute("loginuser") != null) {
			session.removeAttribute("loginuser");	
		}
		
		if(session.getAttribute("loginseller") != null) {
			session.removeAttribute("loginseller");	
		}
		
		mav.setViewName("psb/main");
		return mav;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////
						//////////////////// 회원 리스트  ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/adminMember_list.bc")
	public ModelAndView adminMember(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<SmhMemberVO> memberList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
		
		String gender = request.getParameter("gender");
		String[] ageArr = request.getParameterValues("age");
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		if(startDate == null) {
			startDate="";
		}
		if(endDate == null) {
			endDate="";
		}
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord==null|| searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		String orderType = request.getParameter("orderType");
		if(orderType == null) {
			orderType = "registerday";
		}
			
		String mstatus = request.getParameter("mstatus");
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		
		paraMap.put("gender", gender);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("orderType", orderType);
		paraMap.put("mstatus", mstatus);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("ageArr",ageArr);
		
		// System.out.println(orderType);
		
		if( ageArr != null ) {
			String ageStr = Arrays.toString(ageArr);
			ageStr = ageStr.substring(1, ageStr.length()-1);
			paraMap.put("ageStr",ageStr);
		}
		
		totalCount = service.getTotalCountMember(paraMap);	
		mav.addObject("totalCount", totalCount);
		
		// 총 회원 수 
		int totalMember = service.getTotalMember();
		mav.addObject("totalMember", totalMember);
		
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
		memberList = service.memberListWithPaging(paraMap); 
		
		// 검색어 값을 유지시키기 위함 
		mav.addObject("paraMap",paraMap);
		
		// === 페이지바 만들기 === /// 
		String pagebar = "<ul>";
		
		int blockSize = 5;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNO - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		String url = "adminMember_list.bc";	
		// *** [이전] 만들기 *** //    
		if(pageNo != 1) {
			if( ageArr == null & gender == null & mstatus == null ) {
				
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+ (pageNo-1)
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender == null & mstatus == null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) 
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
				
			}
			else if( ageArr == null & gender != null & mstatus == null ) {
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) + "&gender="+gender
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
				
			}
			else if( ageArr == null & gender == null & mstatus != null ) {
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) 
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
				
			}
			else if( ageArr != null & gender != null & mstatus == null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) + "&gender="+gender
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender == null & mstatus != null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) 
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			else if( ageArr == null & gender != null & mstatus != null ) {
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1)  + "&gender="+gender
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender != null & mstatus != null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) + "&gender="+gender
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
		}
			
		while( !(loop>blockSize || pageNo>totalPage) ) {
		
			if(pageNo == currentShowPageNO) {
				pagebar += "&nbsp;<span style='color: red; border: 1px solid gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";				
			}
			else {
				
				if( ageArr == null & gender == null & mstatus == null ) {
					
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
								+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( ageArr != null & gender == null & mstatus == null ) {
					String ageurl = "";
					for (int i = 0; i < ageArr.length; i++) {
						ageurl += "&age=" + ageArr[i] ;
					}
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
								+ageurl+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
					
				}
				else if( ageArr == null & gender != null & mstatus == null ) {
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
					
				}
				else if( ageArr == null & gender == null & mstatus != null ) {
					pagebar += "&nbsp;<a style='color:black;'  href='"+url+"?&currentShowPageNO="+pageNo 
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
					
				}
				else if( ageArr != null & gender != null & mstatus == null ) {
					String ageurl = "";
					for (int i = 0; i < ageArr.length; i++) {
						ageurl += "&age=" + ageArr[i] ;
					}
					pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
								+ageurl+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( ageArr != null & gender == null & mstatus != null ) {
					String ageurl = "";
					for (int i = 0; i < ageArr.length; i++) {
						ageurl += "&age=" + ageArr[i] ;
					}
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
								+ageurl+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( ageArr == null & gender != null & mstatus != null ) {
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo  + "&gender="+gender
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( ageArr != null & gender != null & mstatus != null ) {
					String ageurl = "";
					for (int i = 0; i < ageArr.length; i++) {
						ageurl += "&age=" + ageArr[i] ;
					}
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
								+ageurl+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
			
			}  
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// *** [다음] 만들기 *** //
		if( !(pageNo>totalPage) ) {

			if( ageArr == null & gender == null & mstatus == null ) {
				
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender == null & mstatus == null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
				
			}
			else if( ageArr == null & gender != null & mstatus == null ) {
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
				
			}
			else if( ageArr == null & gender == null & mstatus != null ) {
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
				
			}
			else if( ageArr != null & gender != null & mstatus == null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender == null & mstatus != null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( ageArr == null & gender != null & mstatus != null ) {
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo  + "&gender="+gender
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( ageArr != null & gender != null & mstatus != null ) {
				String ageurl = "";
				for (int i = 0; i < ageArr.length; i++) {
					ageurl += "&age=" + ageArr[i] ;
				}
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo + "&gender="+gender
							+ageurl+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&mstatus="+mstatus +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
		
		}
		
		pagebar += "</ul>";
		
		mav.addObject("pagebar", pagebar);
		
		///////////////////////////////////////////////////////////////////////////////////
		
		String gobackURL = MyUtil.getCurrentURL(request); // 우리가 만든 URL 알아오는 메소드 
		mav.addObject("gobackURL", gobackURL);
		
		///////////////////////////////////////////////////////////////////////////////////
		mav.addObject("memberList", memberList);
		
		mav.setViewName("tilesSB/adminMember_list.tilesSBM");
		return mav;
	}
	
	// 엑셀 다운 
	@RequestMapping(value="/memberExcelFile.bc", method= {RequestMethod.POST})
	public String memberExcelFile(HttpServletRequest request, Model model){
		List<SmhMemberVO> memberList = null;
		
		/*String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 5;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
*/		
		String gender = request.getParameter("gender");
		String[] ageArr = request.getParameterValues("age");
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		if(startDate == null) {
			startDate="";
		}
		if(endDate == null) {
			endDate="";
		}
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord==null|| searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		String orderType = request.getParameter("orderType");
		if(orderType == null) {
			orderType = "registerday";
		}
			
		String mstatus = request.getParameter("mstatus");
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		
		paraMap.put("gender", gender);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("orderType", orderType);
		paraMap.put("mstatus", mstatus);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("ageArr",ageArr);
		paraMap.put("startRno", "");
		paraMap.put("endRno", "");
		
		memberList = service.memberListWithPaging(paraMap);
		
		// 엑셀 파일 전체를 워크북이라고 부름
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet("여기는어때 회원 리스트"); // "시트 이름 지정"
		
		// 시트 열 너비 설정  (원하는 열 개수만큼)
		sheet.setColumnWidth(0,3000); // 컬럼 인덱스 : 0부터 시작
		sheet.setColumnWidth(1,4000); 
		sheet.setColumnWidth(2,8000); 
		sheet.setColumnWidth(3,4000); 
		sheet.setColumnWidth(4,3000);
		sheet.setColumnWidth(5,1500); 
		sheet.setColumnWidth(6,1500); 
		sheet.setColumnWidth(7,3000);
		sheet.setColumnWidth(8,3000); 
		
		// 행 위치를 나타내는 변수 선언 (행 인덱스 : 0부터 시작)
		int rowLocation = 0;
		
		/////////////////////////////////////////CELL STYLE///////////////////////////////////////////////
		// == CellStyle 정렬하기(Alignment) == //
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
		CellStyle mergeRowStyle = workbook.createCellStyle();          // 표 제목 단 설정  
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);        // 가로 가운데 정렬 
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);  // 세로 가운데  정렬 
		// import org.apache.poi.ss.usermodel.VerticalAlignment 으로 해야함.
		
		CellStyle headerStyle = workbook.createCellStyle();          // 컬럼명 설정  
		headerStyle.setAlignment(HorizontalAlignment.CENTER);        // 가로 가운데  정렬 
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);  // 세로  가운데 정렬 
		
		// == CellStyle 배경색(ForegroundColor)만들기 == //
		// setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
		// setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
		// mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		// mergeRowStyle : 표 제목 단  		
		
		headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다.  
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		// mergeRowStyle : 컬럼명  
		
		// == Cell 폰트(Font) 설정하기 == //
		// 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
		// 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
		// 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
		Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
		mergeRowFont.setFontName("나눔고딕");
		mergeRowFont.setFontHeight((short)400);
		mergeRowFont.setColor(IndexedColors.DARK_RED.getIndex());
		mergeRowFont.setBold(true);
		
		mergeRowStyle.setFont(mergeRowFont);   // 표 제목 단에 해당 폰트를 설정한다.
		
		
		// == CellStyle 테두리 Border == //
		// 테두리는 각 셀마다 상하좌우 모두 설정해준다.
		// setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
		headerStyle.setBorderTop(BorderStyle.THICK);   // 상하는 굵게
		headerStyle.setBorderBottom(BorderStyle.THICK);
		headerStyle.setBorderLeft(BorderStyle.THIN);  // 왼쪽, 오른쪽은 얇게
		headerStyle.setBorderRight(BorderStyle.THIN);
		
		// == Cell Merge 셀 병합시키기 == //
		/* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
		   CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
		*/
		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation);  // 엑셀에서 행의 시작은 0 부터 시작한다.
		
		// 병합할 행에 우리회사 사원정보로 셀을 만들어 셀에 스타일을 주기 
		for(int i=0; i<9; i++) {  
			Cell cell = mergeRow.createCell(i);
			cell.setCellStyle(mergeRowStyle);  // 해당 셀에 표 제목단 스타일을 설정 
			cell.setCellValue("여기는어때 회원 리스트");  // 해당 셀에 데이터 값 입력 
		}
		
		// 셀 병합하기 
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 8)); // 시작 행, 끝 행, 시작 열, 끝 열 
		
		// == CellStyle 천단위 쉼표, 금액 == // 
		CellStyle moneyStyle = workbook.createCellStyle();
		moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		////////////////////////////////////////////////////////////////////////////////////////	
		CellStyle centerStyle = workbook.createCellStyle();            
		centerStyle.setAlignment(HorizontalAlignment.CENTER); 
		
		// 헤더 행 생성 
		Row headerRow = sheet.createRow(++rowLocation); // 엑셀 기준 두번째 행부터 시작한다는 뜻 (첫번째 행은 비움) => rowLocation = 1
		                                                // ++rowLocation : 전위연산자
		
		// 헤더 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0 부터 시작한다.
        headerCell.setCellValue("회원번호");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("이름");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("이메일");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("휴대폰번호");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("가입일자");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 여섯번째 열 셀 생성
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("성별");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 일곱번째 열 셀 생성
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("나이");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 여덟번째 열 셀 생성
        headerCell = headerRow.createCell(7);
        headerCell.setCellValue("누적결제액");
        headerCell.setCellStyle(headerStyle);
        
        // 헤더 행의 여덟번째 열 셀 생성
        headerCell = headerRow.createCell(8);
        headerCell.setCellValue("누적예약수");
        headerCell.setCellStyle(headerStyle);
        
        // HR사원정보 내용(Body)에 해당하는 행 및 셀 생성하기 
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i=0; i<memberList.size(); i++) {  // DB에서 읽어온 결과물 : empList 
        	
        	SmhMemberVO membervo = memberList.get(i);
            
            // 행 생성
            bodyRow = sheet.createRow( i + (rowLocation+1) );  // rowLocation : 1 => index : 2 => 3번째 행 부터 시작  
         
            bodyCell = bodyRow.createCell(0);
            bodyCell.setCellValue(membervo.getMember_idx());
            bodyCell.setCellStyle(centerStyle);           
            
            bodyCell = bodyRow.createCell(1);
            bodyCell.setCellValue(membervo.getName());
            bodyCell.setCellStyle(centerStyle);  
            
            bodyCell = bodyRow.createCell(2);
            bodyCell.setCellValue(membervo.getEmail());
            bodyCell.setCellStyle(centerStyle);  
            
            bodyCell = bodyRow.createCell(3);
            if( membervo.getHp1() != null ) {
            	bodyCell.setCellValue(membervo.getHp1() + "-" + membervo.getHp2() + "-" + membervo.getHp3());
                bodyCell.setCellStyle(centerStyle);  
            }
            else {
            	bodyCell.setCellValue("--");
                bodyCell.setCellStyle(centerStyle);  
            }
         
            bodyCell = bodyRow.createCell(4);
            bodyCell.setCellValue(membervo.getRegisterday());
            bodyCell.setCellStyle(centerStyle);  
            
            // 데이터 성별 
            if ( "1".equals(membervo.getGender() )) {
            	bodyCell = bodyRow.createCell(5);
            	bodyCell.setCellValue("남");
                bodyCell.setCellStyle(centerStyle);  
            }
            else {
            	bodyCell = bodyRow.createCell(5);
            	bodyCell.setCellValue("여");
                bodyCell.setCellStyle(centerStyle);  
            }
             
            // 데이터 나이 
            bodyCell = bodyRow.createCell(6);
            bodyCell.setCellValue( membervo.getAge());
            bodyCell.setCellStyle(centerStyle);  
          
            // 누적 결제액 
            bodyCell = bodyRow.createCell(7);
            bodyCell.setCellValue(membervo.getTotalPrice());
            bodyCell.setCellStyle(moneyStyle); 
        	
            // DB에서 값을 읽어올 때 디폴트는 String 이므로, (사칙연산이) 필요한 경우 숫자로 바꿔야 한다.
          
            // 누적 예약수
            bodyCell = bodyRow.createCell(8);
            bodyCell.setCellValue(membervo.getTotalCount());
            bodyCell.setCellStyle(moneyStyle);   // 천단위 스타일 적용 
            
        } // end of for----------------------------------
        
        // request.setAttribute("key 값", 넘길 데이터 ) 역할
        model.addAttribute("locale", Locale.KOREA);  // 지역 표시를 해주는 것 (통화 단위 등을 한국에 맞춰줌)
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "여기는어때 회원 리스트");
		
		return "excelDownloadView";  // excelDownloadView 라는 bean 호출  (DB 결과물을 엑실파일로 만든 것. html 파일을 엑셀로 만든 것  X)
								     // 해당 bean 은  com.test.excel.ExcelDownloadView 라는 클래스를 작동시킴 
		
	}
	
	// 차트 생성 (성별, 인원별 인원) //
	@ResponseBody
	@RequestMapping(value="/chartMemberCount.bc", produces="text/plain;charset=UTF-8")
	public String chartMemberCount() {
	
		List<HashMap<String, String>> memberCountList = service.chartMemberCount();
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(memberCountList != null ) {
			for ( HashMap<String, String> map : memberCountList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
				
				jsonObj.addProperty("age", map.get("age"));
				jsonObj.addProperty("gender", map.get("gender"));
				jsonObj.addProperty("count", map.get("count"));
				jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
	
	@ResponseBody
	@RequestMapping(value="/chartMemberTrend.bc", produces="text/plain;charset=UTF-8")
	public String chartMemberTrend() {
		List<HashMap<String, String>> memberCountList = service.chartMemberTrend();
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(memberCountList != null ) {
			for ( HashMap<String, String> map : memberCountList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
				
				jsonObj.addProperty("age", map.get("age"));
				jsonObj.addProperty("gender", map.get("gender"));
				jsonObj.addProperty("registerday", map.get("registerday"));
				jsonObj.addProperty("count", map.get("count"));
				jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
	
	@RequestMapping(value="/memberDetail.bc")
	public ModelAndView adminMemberDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String member_idx = request.getParameter("member_idx");
		
		SmhMemberVO membervo = service.getOneMember(member_idx);
		mav.addObject("membervo", membervo);
		
		// 회원 적립금 가져오기
		int memberPoint = 0;
		try {
			memberPoint = service.getMemberPoint(member_idx);
			mav.addObject("memberPoint", memberPoint);
		} catch (NullPointerException e) {
			mav.addObject("memberPoint", 0);
		}
	
		// 최근 결제일 가져오기
		String lastDate = service.getlastDate(member_idx);
		if (lastDate != null ) {
			mav.addObject("lastDate", lastDate);
		}else {
			mav.addObject("lastDate", ".");
		}
		
		mav.setViewName("tilesSB/memberDetail.tilesSBM");
		return mav;
	}

	@RequestMapping(value="/adminMember_chart.bc")
	public ModelAndView adminMember_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		int totalMember = service.getTotalMember();
		mav.addObject("totalMember", totalMember);
		mav.setViewName("tilesSB/adminMember_chart.tilesSBM");
		return mav;
	}
	
	@RequestMapping(value="/memberPointUpdate.bc")
	public ModelAndView memberPointUpdate(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String member_idx = request.getParameter("member_idx");
		String memberPointStr = request.getParameter("memberPoint");
		
		int memberPoint = Integer.parseInt( memberPointStr.replaceAll(",", ""));
		
		int n = 0;
		try {
			int bool = service.getMemberPoint(member_idx);
			n = service.memberPointUpdate(member_idx, memberPoint);
		} catch (NullPointerException e) {
			n = service.memberPointInsert(member_idx, memberPoint);
		}
		
		if(n==1) {

			mav.addObject("msg","회원 적립금이 업데이트 되었습니다.");
			mav.addObject("loc", request.getContextPath() + "/memberDetail.bc?member_idx="+member_idx );

			mav.setViewName("psb/msg");
		}
		
		return mav;
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
						//////////////////// 판매자 리스트  ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
		
	@RequestMapping(value="/adminSeller_list.bc")
	public ModelAndView adminSeller_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<KmtSellerMemberVO> sellerList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		if(startDate == null) {
			startDate="";
		}
		if(endDate == null) {
			endDate="";
		}
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord==null|| searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		String orderType = request.getParameter("orderType");
		if(orderType == null) {
			orderType = "seller_registerday";
		}
			
		String seller_realStatus = request.getParameter("seller_realStatus");
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("orderType", orderType);
		paraMap.put("seller_realStatus", seller_realStatus);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		
		totalCount = service.getTotalCountSeller(paraMap);	
		mav.addObject("totalCount", totalCount);
		
		// 총 판매자 수 
		int totalSeller = service.getTotalSeller();
		mav.addObject("totalSeller", totalSeller);
		
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
		sellerList = service.sellerListWithPaging(paraMap); 
		
		// 검색어 값을 유지시키기 위함 
		mav.addObject("paraMap",paraMap);
		
		// === 페이지바 만들기 === /// 
		String pagebar = "<ul>";
		
		int blockSize = 5;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNO - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		String url = "adminSeller_list.bc";	
		// *** [이전] 만들기 *** //    
		if(pageNo != 1) {
			if( seller_realStatus == null ) {
				
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+ (pageNo-1)
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			else if( seller_realStatus != null ) {
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) 
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&seller_realStatus="+seller_realStatus +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
				
			}
		}
			
		while( !(loop>blockSize || pageNo>totalPage) ) {
		
			if(pageNo == currentShowPageNO) {
				pagebar += "&nbsp;<span style='color: red; border: 1px solid gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";				
			}
			else {
				
				if( seller_realStatus == null ) {
					
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
								+"&startDate="+startDate+"&endDate="+endDate
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( seller_realStatus != null ) {
					pagebar += "&nbsp;<a style='color:black;'  href='"+url+"?&currentShowPageNO="+pageNo 
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&seller_realStatus="+seller_realStatus +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
					
				}
			}  
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// *** [다음] 만들기 *** //
		if( !(pageNo>totalPage) ) {

			if( seller_realStatus == null  ) {
				
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
							+"&startDate="+startDate+"&endDate="+endDate
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( seller_realStatus != null ) {
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&seller_realStatus="+seller_realStatus +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
				
			}
		}
		
		pagebar += "</ul>";
		
		mav.addObject("pagebar", pagebar);
		
		///////////////////////////////////////////////////////////////////////////////////
		
		String gobackURL = MyUtil.getCurrentURL(request); // 우리가 만든 URL 알아오는 메소드 
		mav.addObject("gobackURL", gobackURL);
		
		///////////////////////////////////////////////////////////////////////////////////
		mav.addObject("sellerList", sellerList);
		
		mav.setViewName("tilesSB/adminSeller_list.tilesSBS");
		return mav;
	}
	

	@RequestMapping(value="/sellerDetail.bc")
	public ModelAndView adminSellerDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seller_idx = request.getParameter("seller_idx");
		
		KmtSellerMemberVO sellervo = service.getOneSeller(seller_idx);
		mav.addObject("sellervo", sellervo);
		
		// 보유한 호텔 수 구하기
		int seller_hotelCount = 0;
		seller_hotelCount = service.getHotelCount(seller_idx);
		mav.addObject("seller_hotelCount", seller_hotelCount);
		
		// 게시글 조회 
		String seller_Name = sellervo.getSeller_Name();
        List<BoardVO> boardList = service.getSellerBoardList(seller_Name);  // 원글에 달린 글 조회 
		
		mav.addObject("boardList", boardList);
		
		mav.setViewName("tilesSB/sellerDetail.tilesSBS");
		return mav;
	}
	
	// 판매자 상태 변경 
	@RequestMapping(value="/updateSellerStatus.bc")
	public ModelAndView updateSellerStatus(HttpServletRequest request, ModelAndView mav) {
		
		String seller_idx = request.getParameter("seller_idx");
		String seller_realStatus = request.getParameter("seller_realStatus");
		
		List<String> hotel_idx_list = service.getHotelArr(seller_idx);

		int n = 0;
		if ( "1".equals(seller_realStatus) ) {
			
			n = service.updateSellerStatus(seller_idx);
			
			if(hotel_idx_list != null ) {
				String[] hotel_idx_Arr = hotel_idx_list.toArray( new String[hotel_idx_list.size()] ) ;
				n = service.updateHotelStatus(hotel_idx_Arr);
			}
			
		} else {
			n = service.stopSellerStatus(seller_idx);
			if(hotel_idx_list != null ) {
				String[] hotel_idx_Arr = hotel_idx_list.toArray( new String[hotel_idx_list.size()] ) ;
				n = service.stopHotelStatus(hotel_idx_Arr);
			}
		}
		
		if(n != 0) {

			mav.addObject("msg","판매자 계정 상태가 변경되었습니다.");
			mav.addObject("loc", request.getContextPath() + "/sellerDetail.bc?seller_idx="+seller_idx );

			mav.setViewName("psb/msg");
		}
		
		return mav;
	}
	
	// 판매자 코멘트 
	@ResponseBody
	@RequestMapping(value="/addSellerComment.bc", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
	public String addSellerComment(BoardVO boardvo) {
		String jsonStr = "";
		
		try {
			int n = service.add(boardvo); 
			
			if(n==1) {  // 댓글쓰기가 insert & 원게시물 tblBoard 테이블의 댓글갯수는 +1 ==> 성공
				        // 원글에 달린 댓글 조회 
				// 게시글 조회 
				String seller_Name = boardvo.getFk_sellerName();
		        List<BoardVO> boardList = service.getSellerBoardList(seller_Name);  // 원글에 달린 글 조회 
			
				JSONArray jsonArr = new JSONArray();
				for( BoardVO vo : boardList ) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", vo.getName());
					jsonObj.put("fk_adminId", vo.getTitle());
					jsonObj.put("registerday", vo.getRegisterday());
					
					jsonArr.put(jsonObj);
				}
				jsonStr = jsonArr.toString();
				
			  } // end of if(n==1)============================
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
	
	// chart_SellerMonthlyPrice
	@ResponseBody
	@RequestMapping(value="/chart_SellerMonthlyPrice.bc", produces="text/plain;charset=UTF-8")
	public String chart_SellerMonthlyPrice(HttpServletRequest request) {
		String seller_idx = request.getParameter("seller_idx");
		List<HashMap<String, Object>> montlyPriceList = service.chart_SellerMonthlyPrice(seller_idx);

		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(montlyPriceList != null ) {
			for ( HashMap<String, Object> map : montlyPriceList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
				
				jsonObj.addProperty("MONTH", (String)map.get("MONTH"));
				jsonObj.addProperty("totalPrice", (int)map.get("totalPrice"));
				jsonObj.addProperty("totalCount", (int)map.get("totalCount"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
	
	/*@RequestMapping(value="/adminSeller_chart.bc")
	public ModelAndView adminSeller_chart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("tilesSB/adminSeller_chart.tilesSBS");
		return mav;
	}*/
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
					  //////////////////// 호텔 리스트   ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value="/adminHotel_list.bc")
	public ModelAndView adminHotel_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<KmtHotelInfoVO> hotelList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		if(startDate == null) {
			startDate="";
		}
		if(endDate == null) {
			endDate="";
		}
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord==null|| searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
	
		String orderType = request.getParameter("orderType");
		if(orderType == null) {
			orderType = "hotel_registerday";
		}
			
		String hotel_Status = request.getParameter("hotel_Status");
		String hotel_Category = request.getParameter("hotel_Category");
		String hotel_Addr1 = request.getParameter("hotel_Addr1");
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("orderType", orderType);
		paraMap.put("hotel_Status", hotel_Status);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);

		if (hotel_Category != null ) {
			paraMap.put("hotel_Category", hotel_Category);
		}else {
			paraMap.put("hotel_Category", "");
		}
		paraMap.put("hotel_Addr1", hotel_Addr1);
	
		if( hotel_Addr1 != null ) {
			
			if( hotel_Addr1.length() < 1 ) {
				paraMap.put("addrArr", "");
			} else {
				String[] addrArr = hotel_Addr1.split(",");
				paraMap.put("addrArr", addrArr);
			}
			
		} else {
			paraMap.put("addrArr", "");
		}
		
		totalCount = service.getTotalCountHotel(paraMap);	
		mav.addObject("totalCount", totalCount);
		
		// 총 판매자 수 
		int totalHotel = service.getTotalHotel();
		mav.addObject("totalHotel", totalHotel);
		
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
		hotelList = service.hotelListWithPaging(paraMap); 
		
		// 검색어 값을 유지시키기 위함 
		mav.addObject("paraMap",paraMap);
		
		// === 페이지바 만들기 === /// 
		String pagebar = "<ul>";
		
		int blockSize = 5;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNO - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		String url = "adminHotel_list.bc";	
		// *** [이전] 만들기 *** //    
		if(pageNo != 1) {
			if( hotel_Status == null ) {
				
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+ (pageNo-1)
							+"&startDate="+startDate+"&endDate="+endDate + "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
			}
			
			else if( hotel_Status != null ) {
				pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+(pageNo-1) 
						+"&startDate="+startDate+"&endDate="+endDate + "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&hotel_Status="+ hotel_Status +"&orderType="+orderType + "'>"+pageNo+"[이전]</a>&nbsp;"; 
				
			}
		}
			
		while( !(loop>blockSize || pageNo>totalPage) ) {
		
			if(pageNo == currentShowPageNO) {
				pagebar += "&nbsp;<span style='color: red; border: 1px solid gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";				
			}
			else {
				
				if( hotel_Status == null ) {
					
					pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
								+"&startDate="+startDate+"&endDate="+endDate+ "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
								+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
								+"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
				}
				else if( hotel_Status != null ) {
					pagebar += "&nbsp;<a style='color:black;'  href='"+url+"?&currentShowPageNO="+pageNo 
							+"&startDate="+startDate+"&endDate="+endDate + "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+ "&hotel_Status="+hotel_Status +"&orderType="+orderType + "'>"+pageNo+"</a>&nbsp;"; 
					
				}
			}  
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// *** [다음] 만들기 *** //
		if( !(pageNo>totalPage) ) {

			if( hotel_Status == null ) {
				
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo
							+"&startDate="+startDate+"&endDate="+endDate+ "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
							+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
							+"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
			}
			else if( hotel_Status != null ) {
				pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
						+"&startDate="+startDate+"&endDate="+endDate + "&hotel_Category=" + hotel_Category + "&hotel_Addr1="+hotel_Addr1
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+ "&hotel_Status="+hotel_Status +"&orderType="+orderType + "'>"+pageNo+"[다음]</a>&nbsp;"; 
				
			}
		}
		
		pagebar += "</ul>";
		
		mav.addObject("pagebar", pagebar);
		
		///////////////////////////////////////////////////////////////////////////////////
		
		String gobackURL = MyUtil.getCurrentURL(request); // 우리가 만든 URL 알아오는 메소드 
		mav.addObject("gobackURL", gobackURL);
		
		///////////////////////////////////////////////////////////////////////////////////
		mav.addObject("hotelList", hotelList);
		
		mav.setViewName("tilesSB/adminHotel_list.tilesSBS");
		return mav;
	}
	
	@RequestMapping(value="/hotelDetail.bc")
	public ModelAndView adminHotelDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String hotel_idx = request.getParameter("hotel_idx");
		
		KmtHotelInfoVO hotelvo = service.getOneHotel(hotel_idx);
		mav.addObject("hotelvo", hotelvo);
		
		// 보유한 방 수 구하기 
		int roomCount = 0;
		roomCount = service.getRoomCount(hotel_idx);
		mav.addObject("roomCount", roomCount);
		
		// 게시글 조회 
		String hotel_Name = hotelvo.getHotel_Name();
        List<BoardVO> boardList = service.getHotelBoardList(hotel_Name);  // 원글에 달린 글 조회 
		
		mav.addObject("boardList", boardList);
		
		mav.setViewName("tilesSB/hotelDetail.tilesSBS");
		return mav;
	}
	
	// 호텔 코멘트 
	@ResponseBody
	@RequestMapping(value="/addHotelComment.bc", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
	public String addHotelComment(BoardVO boardvo) {
		String jsonStr = "";
		
		try {
			int n = service.add(boardvo); 
			
			if(n==1) {  // 댓글쓰기가 insert & 원게시물 tblBoard 테이블의 댓글갯수는 +1 ==> 성공
				        // 원글에 달린 댓글 조회 
				// 게시글 조회 
				String hotel_Name = boardvo.getFk_hotelName();
		        List<BoardVO> boardList = service.getHotelBoardList(hotel_Name);  // 원글에 달린 글 조회 
			
				JSONArray jsonArr = new JSONArray();
				for( BoardVO vo : boardList ) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", vo.getName());
					jsonObj.put("fk_adminId", vo.getTitle());
					jsonObj.put("registerday", vo.getRegisterday());
					
					jsonArr.put(jsonObj);
				}
				jsonStr = jsonArr.toString();
				
			  } // end of if(n==1)============================
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
	
	// 호텔 상태 변경 
	@RequestMapping(value="/updateHotelStatus.bc")
	public ModelAndView updateHotelStatus(HttpServletRequest request, ModelAndView mav) {
		
		String hotel_idxStr = request.getParameter("hotel_idx");
		String hotel_Status = request.getParameter("hotel_Status");
		
	    int m  = service.getSellerStatus(hotel_idxStr);
		if(m==0) {
			mav.addObject("msg","판매자 계정이 휴먼 상태입니다.");
			mav.addObject("loc", request.getContextPath() + "/hotelDetail.bc?hotel_idx="+ hotel_idxStr );
			mav.setViewName("psb/msg");
		}
		else {
			String[] hotel_idx = hotel_idxStr.split(",");
			 
			int n = 0;
			if ( "1".equals(hotel_Status)) {
				 n = service.updateHotelStatus(hotel_idx);
			}else {
				n = service.stopHotelStatus(hotel_idx);
			}
			
			if(n==1) {
				mav.addObject("msg","호텔 영업상태가 변경되었습니다.");
				mav.addObject("loc", request.getContextPath() + "/hotelDetail.bc?hotel_idx="+ hotel_idxStr );
				mav.setViewName("psb/msg");
			}
		}
		
		return mav;
	}
	
	// 판매자 페이지로 이동 
	@RequestMapping(value="/goSellerPage.bc")
	public ModelAndView goSellerPage(HttpServletRequest request, ModelAndView mav) {
		
		String hotel_idxStr = request.getParameter("hotel_idx");
		
	    String idx  = service.getSellerIdx(hotel_idxStr);
	    
	    String url = "sellerDetail.bc?seller_idx="+ idx;
	    
		mav.setView(new RedirectView(url));
		
		return mav;
	}
		
	
	@ResponseBody
	@RequestMapping(value="/chart_HotelMonthlyPrice.bc", produces="text/plain;charset=UTF-8")
	public String chart_HotelMonthlyPrice(HttpServletRequest request) {
		String hotel_idx = request.getParameter("hotel_idx");
		
		List<HashMap<String, Object>> montlyPriceList = service.chart_HotelMonthlyPrice(hotel_idx);

		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(montlyPriceList != null ) {
			for ( HashMap<String, Object> map : montlyPriceList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
				
				jsonObj.addProperty("MONTH", (String)map.get("MONTH"));
				jsonObj.addProperty("totalPrice", (int)map.get("totalPrice"));
				jsonObj.addProperty("totalCount", (int)map.get("totalCount"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
			
	@RequestMapping(value="/adminHotel_chart.bc")
	public ModelAndView adminHotel_chart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		
		mav.setViewName("tilesSB/adminHotel_chart.tilesSBS");
		return mav;
	}

	@ResponseBody
	@RequestMapping(value="/chartHotelLocation.bc", produces="text/plain;charset=UTF-8")
	public String chartHotelLocation() {
	
		List<HashMap<String, String>> hotelCountList = service.chartHotelLocation();
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(hotelCountList != null ) {
			for ( HashMap<String, String> map : hotelCountList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
			
				jsonObj.addProperty("hotel_addr1", map.get("hotel_addr1"));
				jsonObj.addProperty("count", map.get("count"));
				jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
	
	@ResponseBody
	@RequestMapping(value="/chartHotelGrade.bc", produces="text/plain;charset=UTF-8")
	public String chartHotelGrade() {
	
		List<HashMap<String, String>> hotelCountList = service.chartHotelGrade();
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(hotelCountList != null ) {
			for ( HashMap<String, String> map : hotelCountList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
			
				jsonObj.addProperty("hotel_Category", map.get("hotel_Category"));
				jsonObj.addProperty("count", map.get("count"));
				jsonObj.addProperty("PERCENTAGE", map.get("PERCENTAGE"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
					//////////////////// 매출 통계  ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
		
	@RequestMapping(value="/salesStatistic.bc")
	public ModelAndView adminSalesStatistic(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 누적 매출액
		int toal_Price = service.total_Price();
		int last_yearPrice = service.last_yearPrice();
		int yearPrice = service.yearPrice();
		int monthPrice = service.monthPrice();
		int dayPrice = service.dayPrice();
		
		mav.addObject("toal_Price",toal_Price);
		mav.addObject("last_yearPrice", last_yearPrice);
		mav.addObject("yearPrice", yearPrice);
		mav.addObject("monthPrice", monthPrice);
		mav.addObject("dayPrice", dayPrice);
		
		// 회원 매출액 - 성별
		List<HashMap<String,Object>> paraMapList = service.sales_gender();
	    for ( HashMap<String, Object> map : paraMapList ) { 
			
	    	if ( map.get("gender").equals("1")) {
	    		mav.addObject("M_RCount",map.get("RCount"));
	    		mav.addObject("M_totalPrice",map.get("totalPrice"));
	    		mav.addObject("M_AVG",map.get("AVG"));
	    	}
	    	
	    	if ( map.get("gender").equals("2")) {
	    		mav.addObject("F_RCount",map.get("RCount"));
	    		mav.addObject("F_totalPrice",map.get("totalPrice"));
	    		mav.addObject("F_AVG",map.get("AVG"));
	    	}
		}
		
	    // 회원 매출액 - 연령대
		List<HashMap<String,Object>> paraMapList2 = service.sales_age();
		int Count70 = 0; 
		int Price70 = 0;
		int Avg70 = 0;
		
	    for ( HashMap<String, Object> map : paraMapList2 ) { 
			
	    	if ( map.get("age").equals("10")) {
	    		mav.addObject("RCount_10",map.get("RCount"));
	    		mav.addObject("totalPrice_10",map.get("totalPrice"));
	    		mav.addObject("AVG_10",map.get("AVG"));
	    		
	    	}
	    	
	    	if ( map.get("age").equals("20")) {
	    		mav.addObject("RCount_20",map.get("RCount"));
	    		mav.addObject("totalPrice_20",map.get("totalPrice"));
	    		mav.addObject("AVG_20",map.get("AVG"));
	    	}
	    	
	    	if ( map.get("age").equals("30")) {
	    		mav.addObject("RCount_30",map.get("RCount"));
	    		mav.addObject("totalPrice_30",map.get("totalPrice"));
	    		mav.addObject("AVG_30",map.get("AVG"));
	    	}
	    	
	    	if ( map.get("age").equals("40")) {
	    		mav.addObject("RCount_40",map.get("RCount"));
	    		mav.addObject("totalPrice_40",map.get("totalPrice"));
	    		mav.addObject("AVG_40",map.get("AVG"));
	    	}
	    	
	    	if ( map.get("age").equals("50")) {
	    		mav.addObject("RCount_50",map.get("RCount"));
	    		mav.addObject("totalPrice_50",map.get("totalPrice"));
	    		mav.addObject("AVG_50",map.get("AVG"));
	    	}
	    	
	    	if ( map.get("age").equals("60")) {
	    		mav.addObject("RCount_60",map.get("RCount"));
	    		mav.addObject("totalPrice_60",map.get("totalPrice"));
	    		mav.addObject("AVG_60",map.get("AVG"));
	    	}
	    	
	    	if ( Integer.parseInt((String) map.get("age")) >= 70  ) {
	    		Count70 += (int)map.get("RCount"); 
	    		Price70 += (int)map.get("totalPrice");
	    		Avg70 += (int)map.get("AVG");
	    	}
		}
	    mav.addObject("RCount_70",Count70);
		mav.addObject("totalPrice_70",Price70);
		if(Count70 != 0) {
			mav.addObject("AVG_70",Price70/Count70);
		} else {
			mav.addObject("AVG_70",0);
		}
		
		
		// 상품별 매출액 - 등급
		List<HashMap<String,Object>> paraMapList3 = service.sales_grade();
	
		String gradeStr = "";
		for ( HashMap<String, Object> map : paraMapList3 ) { 
			gradeStr += map.get("hotel_Category");
		}
		
		if( ! gradeStr.contains("1")) {
			mav.addObject("totalCount_G1",0);
    		mav.addObject("totalPrice_G1",0);
    		mav.addObject("AVG_G1", 0);
		}
		if( ! gradeStr.contains("2")) {
			mav.addObject("totalCount_G2",0);
    		mav.addObject("totalPrice_G2",0);
    		mav.addObject("AVG_G2", 0);
		}
		if( ! gradeStr.contains("3")) {
			mav.addObject("totalCount_G3",0);
    		mav.addObject("totalPrice_G3",0);
    		mav.addObject("AVG_G3", 0);
		}
		if( ! gradeStr.contains("4")) {
			mav.addObject("totalCount_G4",0);
    		mav.addObject("totalPrice_G4",0);
    		mav.addObject("AVG_G4", 0);
		}
		if( ! gradeStr.contains("5")) {
			mav.addObject("totalCount_G5",0);
    		mav.addObject("totalPrice_G5",0);
    		mav.addObject("AVG_G5", 0);
		}
		
	    for ( HashMap<String, Object> map : paraMapList3 ) { 
	    	
	    	if ( map.get("hotel_Category").equals("0")) {
	    		mav.addObject("totalCount_G0",map.get("totalCount"));
	    		mav.addObject("totalPrice_G0",map.get("totalPrice"));
	    		mav.addObject("AVG_G0", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_Category").equals("1") ) {
	    		mav.addObject("totalCount_G1",map.get("totalCount"));
	    		mav.addObject("totalPrice_G1",map.get("totalPrice"));
	    		mav.addObject("AVG_G1", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_Category").equals("2") ) {
	    		mav.addObject("totalCount_G2",map.get("totalCount"));
	    		mav.addObject("totalPrice_G2",map.get("totalPrice"));
	    		mav.addObject("AVG_G2", map.get("AVG"));
	    	}
	    	
	    	/*if ( map.get("hotel_Category").equals("4") ) {
	    		mav.addObject("totalCount_G4",map.get("totalCount"));
	    		mav.addObject("totalPrice_G4",map.get("totalPrice"));
	    		mav.addObject("AVG_G4", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_Category").equals("5") ) {
	    		mav.addObject("totalCount_G5",map.get("totalCount"));
	    		mav.addObject("totalPrice_G5",map.get("totalPrice"));
	    		mav.addObject("AVG_G5", map.get("AVG"));
	    	}*/
		}
	    
	    // 상품별 매출액 - 등급
	    List<HashMap<String,Object>> paraMapList4 = service.sales_addr();
	    
	    String addrStr = "";
		for ( HashMap<String, Object> map : paraMapList4 ) { 
			addrStr += map.get("hotel_addr1");
		}
		
		if( ! addrStr.contains("서울")) {
			mav.addObject("totalCount_Seoul",0);
    		mav.addObject("totalPrice_Seoul",0);
    		mav.addObject("AVG_Seoul", 0);
		}
		if( ! addrStr.contains("경기")) {
			mav.addObject("totalCount_Gyeongi",0);
    		mav.addObject("totalPrice_Gyeongi",0);
    		mav.addObject("AVG_Gyeongi", 0);
		}
		if( ! addrStr.contains("인천")) {
			mav.addObject("totalCount_Incheon",0);
    		mav.addObject("totalPrice_Incheon",0);
    		mav.addObject("AVG_Incheon", 0);
		}
		if( ! addrStr.contains("강원")) {
			mav.addObject("totalCount_Gang",0);
    		mav.addObject("totalPrice_Gang",0);
    		mav.addObject("AVG_Gang", 0);
		}
		if( ! addrStr.contains("대전")) {
			mav.addObject("totalCount_Daejeon",0);
    		mav.addObject("totalPrice_Daejeon",0);
    		mav.addObject("AVG_Daejeon", 0);
		}
		if( ! addrStr.contains("충남")) {
			mav.addObject("totalCount_CN",0);
    		mav.addObject("totalPrice_CN",0);
    		mav.addObject("AVG_CN", 0);
		}
		if( ! addrStr.contains("충북")) {
			mav.addObject("totalCount_CB",0);
    		mav.addObject("totalPrice_CB",0);
    		mav.addObject("AVG_CB", 0);
		}
		if( ! addrStr.contains("대구")) {
			mav.addObject("totalCount_Daegu",0);
    		mav.addObject("totalPrice_Daegu",0);
    		mav.addObject("AVG_Daegu", 0);
		}
		if( ! addrStr.contains("경남")) {
			mav.addObject("totalCount_GN",0);
    		mav.addObject("totalPrice_GN",0);
    		mav.addObject("AVG_GN", 0);
		}
		if( ! addrStr.contains("경북")) {
			mav.addObject("totalCount_GB",0);
    		mav.addObject("totalPrice_GB",0);
    		mav.addObject("AVG_GB", 0);
		}
		if( ! addrStr.contains("울산")) {
			mav.addObject("totalCount_WS",0);
    		mav.addObject("totalPrice_WS",0);
    		mav.addObject("AVG_WS", 0);
		}
		if( ! addrStr.contains("부산")) {
	 		mav.addObject("totalCount_BS",0);
    		mav.addObject("totalPrice_BS",0);
    		mav.addObject("AVG_BS", 0);
		}
		if( ! addrStr.contains("광주")) {
			mav.addObject("totalCount_GJ",0);
    		mav.addObject("totalPrice_GJ",0);
    		mav.addObject("AVG_GJ", 0);
		}
		if( ! addrStr.contains("전남")) {
			mav.addObject("totalCount_JN",0);
    		mav.addObject("totalPrice_JN",0);
    		mav.addObject("AVG_JN", 0);
		}
		if( ! addrStr.contains("전북")) {
			mav.addObject("totalCount_JB",0);
    		mav.addObject("totalPrice_JB",0);
    		mav.addObject("AVG_JB", 0);
		}
		if( ! addrStr.contains("제주")) {
			mav.addObject("totalCount_JJ",0);
    		mav.addObject("totalPrice_JJ",0);
    		mav.addObject("AVG_JJ", 0);
		}
		
		for ( HashMap<String, Object> map : paraMapList4 ) { 
			
	    	if ( map.get("hotel_addr1").equals("서울") ) {
	    		mav.addObject("totalCount_Seoul",map.get("totalCount"));
	    		mav.addObject("totalPrice_Seoul",map.get("totalPrice"));
	    		mav.addObject("AVG_Seoul", map.get("AVG"));
	    	}
	    	if ( map.get("hotel_addr1").equals("경기") ) {
	    		mav.addObject("totalCount_Gyeongi",map.get("totalCount"));
	    		mav.addObject("totalPrice_Gyeongi",map.get("totalPrice"));
	    		mav.addObject("AVG_Gyeongi", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("인천") ) {
	    		mav.addObject("totalCount_Incheon",map.get("totalCount"));
	    		mav.addObject("totalPrice_Incheon",map.get("totalPrice"));
	    		mav.addObject("AVG_Incheon", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("강원") ) {
	    		mav.addObject("totalCount_Gang",map.get("totalCount"));
	    		mav.addObject("totalPrice_Gang",map.get("totalPrice"));
	    		mav.addObject("AVG_Gang", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("대전") ) {
	    		mav.addObject("totalCount_Daejeon",map.get("totalCount"));
	    		mav.addObject("totalPrice_Daejeon",map.get("totalPrice"));
	    		mav.addObject("AVG_Daejeon", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("충남") ) {
	    		mav.addObject("totalCount_CN",map.get("totalCount"));
	    		mav.addObject("totalPrice_CN",map.get("totalPrice"));
	    		mav.addObject("AVG_CN", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_addr1").equals("충북") ) {
	    		mav.addObject("totalCount_CB",map.get("totalCount"));
	    		mav.addObject("totalPrice_CB",map.get("totalPrice"));
	    		mav.addObject("AVG_CB", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("대구") ) {
	    		mav.addObject("totalCount_Daegu",map.get("totalCount"));
	    		mav.addObject("totalPrice_Daegu",map.get("totalPrice"));
	    		mav.addObject("AVG_Daegu", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_addr1").equals("경남") ) {
	    		mav.addObject("totalCount_GN",map.get("totalCount"));
	    		mav.addObject("totalPrice_GN",map.get("totalPrice"));
	    		mav.addObject("AVG_GN", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_addr1").equals("경북") ) {
	    		mav.addObject("totalCount_GB",map.get("totalCount"));
	    		mav.addObject("totalPrice_GB",map.get("totalPrice"));
	    		mav.addObject("AVG_GB", map.get("AVG"));
	    	} 
	    	if ( map.get("hotel_addr1").equals("울산") ) {
	    		mav.addObject("totalCount_WS",map.get("totalCount"));
	    		mav.addObject("totalPrice_WS",map.get("totalPrice"));
	    		mav.addObject("AVG_WS", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_addr1").equals("부산") ) {
	    		mav.addObject("totalCount_BS",map.get("totalCount"));
	    		mav.addObject("totalPrice_BS",map.get("totalPrice"));
	    		mav.addObject("AVG_BS", map.get("AVG"));
	    	} 
	    	
	    	if ( map.get("hotel_addr1").equals("광주") ) {
	    		mav.addObject("totalCount_GJ",map.get("totalCount"));
	    		mav.addObject("totalPrice_GJ",map.get("totalPrice"));
	    		mav.addObject("AVG_GJ", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("전남") ) {
	    		mav.addObject("totalCount_JN",map.get("totalCount"));
	    		mav.addObject("totalPrice_JN",map.get("totalPrice"));
	    		mav.addObject("AVG_JN", map.get("AVG"));
	    	} 
	    	if ( map.get("hotel_addr1").equals("전북") ) {
	    		mav.addObject("totalCount_JB",map.get("totalCount"));
	    		mav.addObject("totalPrice_JB",map.get("totalPrice"));
	    		mav.addObject("AVG_JB", map.get("AVG"));
	    	}
	    	
	    	if ( map.get("hotel_addr1").equals("제주") ) {
	    		mav.addObject("totalCount_JJ",map.get("totalCount"));
	    		mav.addObject("totalPrice_JJ",map.get("totalPrice"));
	    		mav.addObject("AVG_JJ", map.get("AVG"));
	    	}
	    	
		}


		mav.setViewName("tilesSB/salesStatistic.tilesSBSAT");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/viewPrice.bc", produces="text/plain;charset=UTF-8")
	public String viewPrice(HttpServletRequest request) {
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		
		int searchPrice = service.searchPrice(paraMap);

		Gson gson = new Gson();
		JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
		jsonObj.addProperty("searchPrice",searchPrice);
		return gson.toJson(jsonObj);  
	}
	
	//chart_MonthlyPrice
	@ResponseBody
	@RequestMapping(value="/chart_MonthlyPrice.bc", produces="text/plain;charset=UTF-8")
	public String chart_MonthlyPrice(HttpServletRequest request) {
		
		List<HashMap<String, Object>> montlyPriceList = service.chart_MonthlyPrice();

		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();   // JSONArray (org.json) 와 다름 
		
		if(montlyPriceList != null ) {
			for ( HashMap<String, Object> map : montlyPriceList ) { 
				
				JsonObject jsonObj = new JsonObject();  // JSONObject (org.json) 와 다름 
				
				jsonObj.addProperty("MONTH", (String)map.get("MONTH"));
				jsonObj.addProperty("totalPrice", (int)map.get("totalPrice"));
				jsonObj.addProperty("totalCount", (int)map.get("totalCount"));
				
				jsonArr.add(jsonObj);
			}
		}
		return gson.toJson(jsonArr);  
	}

	
	/////////////////////////////////////////////////////////////////////////////////////////////////
						//////////////////// 관리자 게시판 ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value="/adminCommentBoard.bc")
	public ModelAndView adminCommentBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<BoardVO> boardList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10;  // 한 페이지당 보여줄 게시물 수
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
		List<CommentVO> commentList = service.getCommentList(adminBoard_idx);  // 원글에 달린 댓글 조회 
		
		mav.addObject("commentList", commentList);
		
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

	// 스마트에디터 사진 업로 
	@RequestMapping(value="/admin/multiplePhotoUpload.bc", method={RequestMethod.POST})
	public void multiplePhotoUpload(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"photo_upload";
		
		File dir = new File(path);
		if(!dir.exists())
		    dir.mkdirs();
			
		String strURL = "";
			
		try {
			if(!"OPTIONS".equals(req.getMethod().toUpperCase())) {
			    String filename = req.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명
		    		
		        // System.out.println(">>>> 확인용 filename ==> " + filename); 
		        // >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg
		    		
		    	   InputStream is = req.getInputStream();
		    	/*
		          요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
		          혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
		          이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.
	
	               	  서블릿에서 payload body는 Request.getParameter()가 아니라 
	            	  Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
		    	*/
		    	   String newFilename = fileManager.doFileUpload(is, filename, path);
		    	
			   int width = fileManager.getImageWidth(path+File.separator+newFilename);
				
			   if(width > 600)
			      width = 600;
					 	
			   String CP = req.getContextPath(); 
				
			   strURL += "&bNewLine=true&sFileName="; 
	            	   strURL += newFilename;
	            	   strURL += "&sWidth="+width;
	            	   strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
		    	}
			
		    	/// 웹브라우저상에 사진 이미지를 쓰기 ///
			   PrintWriter out = res.getWriter();
			   out.print(strURL);
		} catch(Exception e){
				e.printStackTrace();
		}
	 
		
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
		mav.addObject("loc", mrequest.getContextPath() + "/adCommentDetail.bc?adminBoard_idx="+boardvo.getAdminBoard_idx()+"&rno="+mrequest.getParameter("rno") );

		mav.setViewName("psb/msg");
	
		return mav;
	}
	
	// 글 삭제 페이지 요청
	@RequestMapping(value="/adBoardDelete.bc", method={RequestMethod.GET} )
	public ModelAndView adminBoardDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
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
	
	// 게시판 댓글 등록
	@ResponseBody
	@RequestMapping(value="/adComment.bc", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
	public String adCommentAdd(CommentVO commentvo) {
		String jsonStr = "";
		
		try {
			int n = service.addComment(commentvo);
			
			if(n==1) {  // 댓글쓰기가 insert & 원게시물 tblBoard 테이블의 댓글갯수는 +1 ==> 성공
				        // 원글에 달린 댓글 조회 
				List<CommentVO> commentList = service.getCommentList(commentvo.getFk_parentIdx()); 
				
				JSONArray jsonArr = new JSONArray();
				for( CommentVO cmtvo : commentList ) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", cmtvo.getName());
					jsonObj.put("fk_adminId", cmtvo.getFk_adminId());
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("registerday", cmtvo.getRegisterday());
					
					jsonArr.put(jsonObj);
				}
				jsonStr = jsonArr.toString();
				
			  } // end of if(n==1)============================
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
	 
	// 게시판 댓글 삭제 
	@ResponseBody
	@RequestMapping(value="/adDelComment.bc", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
	public String adDelComment(String adminComment_idx, String fk_parentIdx) {
		String jsonStr = "";
		
		try {
			
			CommentVO commentvo = service.getViewComment(adminComment_idx);
			
			int n = service.adDelComment(adminComment_idx,fk_parentIdx);
			
			if(n==1) {  // 댓글쓰기가 insert & 원게시물 tblBoard 테이블의 댓글갯수는 +1 ==> 성공
				        // 원글에 달린 댓글 조회 
				List<CommentVO> commentList = service.getCommentList(commentvo.getFk_parentIdx()); 
				
				JSONArray jsonArr = new JSONArray();
				for( CommentVO cmtvo : commentList ) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", cmtvo.getName());
					jsonObj.put("fk_adminId", cmtvo.getFk_adminId());
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("registerday", cmtvo.getRegisterday());
					
					jsonArr.put(jsonObj);
				}
				jsonStr = jsonArr.toString();
				
			  } // end of if(n==1)============================
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
	
	// 게시판 댓글 수정  upComment
	@ResponseBody
	@RequestMapping(value="/upComment.bc", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
	public String upComment(String adminComment_idx, String content, String fk_parentIdx) {
		String jsonStr = "";
		
		try {
			int n = service.updateComment(adminComment_idx, content);
			
			if(n==1) {  
				
				List<CommentVO> commentList = service.getCommentList(fk_parentIdx); 
				
				JSONArray jsonArr = new JSONArray();
				for( CommentVO cmtvo : commentList ) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", cmtvo.getName());
					jsonObj.put("fk_adminId", cmtvo.getFk_adminId());
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("registerday", cmtvo.getRegisterday());
					
					jsonArr.put(jsonObj);
				}
				jsonStr = jsonArr.toString();
				
			  } // end of if(n==1)============================
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
	
	// 자동입력
	@ResponseBody
	@RequestMapping(value="/wordSellerSearchShow.bc", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8" )
	public String wordSellerSearchShow(HttpServletRequest request) {
		
		String fk_sellerName = request.getParameter("fk_sellerName");
	
		List<String> wordList = service.wordSellerSearchShow(fk_sellerName);
		
		JSONArray jsonArr = new JSONArray();
		if( wordList != null ) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word",word);
				jsonArr.put(jsonObj);
			}
		}
		return jsonArr.toString();
		
	}
	
	@ResponseBody
	@RequestMapping(value="/wordHotelSearchShow.bc", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8" )
	public String wordHotelSearchShow(HttpServletRequest request) {
		
		String fk_hotelName = request.getParameter("fk_hotelName");
	
		List<String> wordList = service.wordHotelSearchShow(fk_hotelName);
		
		JSONArray jsonArr = new JSONArray();
		if( wordList != null ) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word",word);
				jsonArr.put(jsonObj);
			}
		}
		return jsonArr.toString();
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
						//////////////////// 예약 내역 ///////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	@RequestMapping(value="/adminReservList.bc")
	public ModelAndView adminReservList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		List<DwoReservationVO> rserveList = null;
		
		String str_currentShowPageNO = request.getParameter("currentShowPageNO");
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10;  // 한 페이지당 보여줄 게시물 수
		int currentShowPageNO = 0 ;// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함
		int totalPage = 0 ; // 총 페이지수(웹브라우저상에 보여줄 총 페이지 갯수, 페이지바)
		
		int startRno = 0;  // 시작 행번호
		int endRno = 0; // 끝 행번호 
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		if(startDate == null) {
			startDate="";
		}
		if(endDate == null) {
			endDate="";
		}
		
		String res_startday =  request.getParameter("res_startday");
		String res_startdayEnd = 	 request.getParameter("res_startdayEnd");
		if(res_startday == null) {
			res_startday="";
		}
		if(res_startdayEnd == null) {
			res_startdayEnd="";
		}
		
		String searchType = request.getParameter("searchType"); 
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord==null|| searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		HashMap<String, Object> paraMap = new HashMap<String,Object>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
	
		paraMap.put("startDate", startDate);
		paraMap.put("res_startdayEnd", res_startdayEnd);
		
		paraMap.put("res_startday", res_startday);
		paraMap.put("endDate", endDate);
		
		totalCount = service.getTotalCountRserve(paraMap);	
		mav.addObject("totalCount", totalCount);
		
		// 총 판매자 수 
		int totalReserve = service.getTotalReserve();
		mav.addObject("totalReserve", totalReserve);
		
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
		rserveList = service.reserveListWithPaging(paraMap); 
		
		// 검색어 값을 유지시키기 위함 
		mav.addObject("paraMap",paraMap);
		
		// === 페이지바 만들기 === /// 
		String pagebar = "<ul>";
		
		int blockSize = 5;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수 이다.
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNO - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		String url = "adminReservList.bc";	
		// *** [이전] 만들기 *** //    
		if(pageNo != 1) {
			pagebar += "&nbsp;<a href='"+url+"?&currentShowPageNO="+ (pageNo-1)
					+"&startDate="+startDate+"&endDate="+endDate
					+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
					+"&res_startday="+res_startday +"&res_startdayEnd="+res_startdayEnd+ "'>"+pageNo+"[이전]</a>&nbsp;"; 
		}
			
		while( !(loop>blockSize || pageNo>totalPage) ) {
		
			if(pageNo == currentShowPageNO) {
				pagebar += "&nbsp;<span style='color: red; border: 1px solid gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";				
			}
			else {
				pagebar += "&nbsp;<a style='color:black;'  href='"+url+"?&currentShowPageNO="+pageNo 
						+"&startDate="+startDate+"&endDate="+endDate
						+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
						+"&res_startday="+res_startday +"&res_startdayEnd="+res_startdayEnd+ "'>"+pageNo+"</a>&nbsp;"; 
			}  
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// *** [다음] 만들기 *** //
		if( !(pageNo>totalPage) ) {

			pagebar += "&nbsp;<a style='color:black;' href='"+url+"?&currentShowPageNO="+pageNo 
					+"&startDate="+startDate+"&endDate="+endDate
					+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord
					+"&res_startday="+res_startday +"&res_startdayEnd="+res_startdayEnd+ "'>"+pageNo+"[다음]</a>&nbsp;"; 
		}
		
		pagebar += "</ul>";
		
		mav.addObject("pagebar", pagebar);
		
		///////////////////////////////////////////////////////////////////////////////////
		
		String gobackURL = MyUtil.getCurrentURL(request); // 우리가 만든 URL 알아오는 메소드 
		mav.addObject("gobackURL", gobackURL);
		
		///////////////////////////////////////////////////////////////////////////////////
		int endPay = service.getEndPay();
		mav.addObject("endPay", endPay);
		
		mav.addObject("rserveList", rserveList);
		
		mav.setViewName("tilesSB/adminReservList.tilesSBSAT");
		return mav;
	}
	
	
	
}	
