package com.project.kmt;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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

import com.project.common.FileManager;

@Controller
public class KmtController {
	
	@Resource
	private KmtService service ;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/sellerJoin.bc")
	public String joinSeller(HttpServletRequest request) {
		return "kmt/sellerJoin";
	}
	
	// 판매자관리 페이지
	@RequestMapping(value="/sellerModify.bc")
	public String modifySeller(HttpServletRequest request) {
		
		return "kmt/sellerModify";
	}
	
	// 판매자 아이디 중복확인
	@ResponseBody
	@RequestMapping(value="/seller/checkId.bc", produces="text/plain;charset=UTF-8")
	public String checkSellerId(HttpServletRequest request) {
		
		String jsonStr = "";
		
		String seller_Id = request.getParameter("seller_Id");
		
		System.out.println(seller_Id);
		
		int n = service.checkSellerId(seller_Id);
		
		System.out.println("n : "+ n); 
		
		JSONObject jsonObj = new JSONObject();
		
		if( n==0 ) {
			jsonObj.put("n","0");
			jsonObj.put("msg", "사용가능한 아이디입니다.");
			jsonStr = jsonObj.toString();
		}
		else {
			jsonObj.put("n","1");
			jsonObj.put("msg", "다른 아이디를 사용해주세요.");
			jsonStr = jsonObj.toString();
		}
		return jsonStr;
		
	}
	
	// 판매자 , 호텔, 호텔 이미지 등록하기
	@RequestMapping(value="/seller/registerSeller.bc", method= {RequestMethod.POST})
	public String registerSeller(MultipartHttpServletRequest mprequest , KmtSellerMemberVO mvo, KmtHotelInfoVO hvo) throws Throwable {
		
		HttpSession session = mprequest.getSession();

		List<HashMap<String,String>> imageMapList = new ArrayList<HashMap<String,String>>();	// 이미지만 담을 해쉬맵 리스트
		
		// 이미지 삽입하기
		List<MultipartFile> attachList = mprequest.getFiles("hotelImage_FileName"); 	// view 에서 받아온 이미지 파일들 ( 지금은 1개 )

		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"images"+File.separator+"kmt"+File.separator+"hotelImage";
		
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
					 
					 imageMap.put("hotelImage_wasFileName", wasFilename);
					 imageMap.put("hotelImage_FileName", attachList.get(i).getOriginalFilename());
					 
					 System.out.println(wasFilename);
					 System.out.println(attachList.get(i).getOriginalFilename());
					 
					 imageMapList.add(imageMap);
					 
				} catch (Exception e) {	}
				
			}
			
		}// end of for------------------------------------------------

		int n = service.registerSellerNHotel(mvo,hvo,imageMapList);
		
		String msg = "";
		String loc = "";
		
		if(n==1 ) {
			msg="정상적으로 회원가입이 되었습니다.";
			loc=mprequest.getContextPath()+"/seller/login.bc";
		}
		else {
			msg="회원가입에 실패했습니다.";
			loc=mprequest.getContextPath()+"/sellerJoin.bc";
		}
		
		mprequest.setAttribute("msg", msg);
		mprequest.setAttribute("loc", loc);
		
		return "msg";
	}
	
	// 판매자 로그인 페이지
	@RequestMapping(value="/seller/login.bc")
	public String sellerLogin(HttpServletRequest request) {
		
		return "kmt/sellerLoginForm";
	}
	
	// 판매자 로그인
	@RequestMapping(value="/seller/loginEnd.bc", method= {RequestMethod.POST})
	public String sellerLoginEnd(HttpServletRequest request) {
		
		String seller_id = request.getParameter("seller_id");
		String seller_pwd = request.getParameter("seller_pwd");
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("seller_id", seller_id );
		paraMap.put("seller_pwd", seller_pwd );
		
		KmtSellerMemberVO loginseller = service.sellerLogin(paraMap);
		
		String msg = "";
		String loc = "";
		
		if(loginseller != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginseller", loginseller);
			
			msg = loginseller.getSeller_RepName()+" 님 환영합니다.";
			loc = request.getContextPath()+"/sellerModify.bc";
		}
		else {
			msg = "로그인에 실패했습니다.";
			loc = request.getContextPath()+"/seller/login.bc";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "msg";
	}
	
	// 판매자 객실 등록
	@RequestMapping(value="/seller/roomRegister.bc",method= {RequestMethod.POST})
	public String sellerRoomRegister(HttpServletRequest request) {
		
		int n = 0;
		String msg = "";
		
		for(int i = 1; i<=7;i++) {
			
			HashMap<String,String> paraMap = new HashMap<String,String>();
			
			String fk_hotel_idx = request.getParameter("fk_hotel_idx"+i);
			String room_name = request.getParameter("room_name"+i);
			
			if(room_name== null || "".equals(room_name)) {
				continue;
			}
			
			String ROOM_CHECKINTIME = request.getParameter("ROOM_CHECKINTIME"+i);
			String ROOM_CHECKOUTTIME = request.getParameter("ROOM_CHECKOUTTIME"+i);
			String ROOM_PERSON = request.getParameter("ROOM_PERSON"+i);
			String ROOM_ADDPERSON = request.getParameter("ROOM_ADDPERSON"+i);
			String ROOM_ADDPERCHARGE = request.getParameter("ROOM_ADDPERCHARGE"+i);
			String BED_SINGLE = request.getParameter("BED_SINGLE"+i);
			String BED_DOUBLE = request.getParameter("BED_DOUBLE"+i);
			String BED_TWIN = request.getParameter("BED_TWIN"+i);
			String BED_ONDOL = request.getParameter("BED_ONDOL"+i);
			String SPA_WPOOL = request.getParameter("SPA_WPOOL"+i);
			String SPA_SAUNA = request.getParameter("SPA_SAUNA"+i);
			String SPA_MASSAGE = request.getParameter("SPA_MASSAGE"+i);
			String SPA_HINOKKI = request.getParameter("SPA_HINOKKI"+i);
			String SPA_OPENBATH = request.getParameter("SPA_OPENBATH"+i);
			String SPA_HALFPOOL = request.getParameter("SPA_HALFPOOL"+i);
			String SPA_TV = request.getParameter("SPA_TV"+i);
			String THEME_MOOIN = request.getParameter("THEME_MOOIN"+i);
			String THEME_PARTY = request.getParameter("THEME_PARTY"+i);
			String THEME_MIRROR = request.getParameter("THEME_MIRROR"+i);
			String THEME_DOUBLEFLOOR = request.getParameter("THEME_DOUBLEFLOOR"+i);
			String THEME_PRINCESS = request.getParameter("THEME_PRINCESS"+i);
			String THEME_TERRAS = request.getParameter("THEME_TERRAS"+i);
			String THEME_OCEAN = request.getParameter("THEME_OCEAN"+i);
			String THEME_LAKE = request.getParameter("THEME_LAKE"+i);
			String THEME_SKY = request.getParameter("THEME_SKY"+i);
			String SERVICE_SPA = request.getParameter("SERVICE_SPA"+i);
			String SERVICE_MINIBAR = request.getParameter("SERVICE_MINIBAR"+i);
			String SERVICE_WIFI = request.getParameter("SERVICE_WIFI"+i);
			String SERVICE_TOWEL = request.getParameter("SERVICE_TOWEL"+i);
			String SERVICE_TV = request.getParameter("SERVICE_TV"+i);
			String SERVICE_AIRCONDITIONER = request.getParameter("SERVICE_AIRCONDITIONER"+i);
			String SERVICE_FRIDGE = request.getParameter("SERVICE_FRIDGE"+i);
			String SERVICE_IRON = request.getParameter("SERVICE_IRON"+i);
			String SERVICE_BATHTUB = request.getParameter("SERVICE_BATHTUB"+i);
			String SERVICE_HAIRDRYER = request.getParameter("SERVICE_HAIRDRYER"+i);
			String SERVICE_KITCHEN = request.getParameter("SERVICE_KITCHEN"+i);
			String SERVICE_SHOWERROOM = request.getParameter("SERVICE_SHOWERROOM"+i);
			
			System.out.println(SPA_WPOOL);
			
			paraMap.put("fk_hotel_idx", fk_hotel_idx );
			paraMap.put("room_name", room_name );
			paraMap.put("ROOM_CHECKINTIME", ROOM_CHECKINTIME );
			paraMap.put("ROOM_CHECKOUTTIME", ROOM_CHECKOUTTIME );
			paraMap.put("ROOM_PERSON", ROOM_PERSON );
			paraMap.put("ROOM_ADDPERSON", ROOM_ADDPERSON );
			paraMap.put("ROOM_ADDPERCHARGE", ROOM_ADDPERCHARGE );
			paraMap.put("BED_SINGLE", BED_SINGLE );
			paraMap.put("BED_DOUBLE", BED_DOUBLE );
			paraMap.put("BED_TWIN", BED_TWIN );
			paraMap.put("BED_ONDOL", BED_ONDOL );
			paraMap.put("SPA_WPOOL", SPA_WPOOL );
			paraMap.put("SPA_SAUNA", SPA_SAUNA );
			paraMap.put("SPA_MASSAGE", SPA_MASSAGE );
			paraMap.put("SPA_HINOKKI", SPA_HINOKKI );
			paraMap.put("SPA_OPENBATH", SPA_OPENBATH );
			paraMap.put("SPA_HALFPOOL", SPA_HALFPOOL );
			paraMap.put("SPA_TV", SPA_TV );
			paraMap.put("THEME_MOOIN", THEME_MOOIN );
			paraMap.put("THEME_PARTY", THEME_PARTY );
			paraMap.put("THEME_MIRROR", THEME_MIRROR );
			paraMap.put("THEME_DOUBLEFLOOR", THEME_DOUBLEFLOOR );
			paraMap.put("THEME_PRINCESS",THEME_PRINCESS  );
			paraMap.put("THEME_TERRAS", THEME_TERRAS );
			paraMap.put("THEME_OCEAN", THEME_OCEAN );
			paraMap.put("THEME_LAKE", THEME_LAKE );
			paraMap.put("THEME_SKY", THEME_SKY );
			paraMap.put("SERVICE_SPA", SERVICE_SPA );
			paraMap.put("SERVICE_MINIBAR", SERVICE_MINIBAR );
			paraMap.put("SERVICE_WIFI", SERVICE_WIFI );
			paraMap.put("SERVICE_TOWEL", SERVICE_TOWEL );
			paraMap.put("SERVICE_TV", SERVICE_TV );
			paraMap.put("SERVICE_AIRCONDITIONER", SERVICE_AIRCONDITIONER );
			paraMap.put("SERVICE_FRIDGE", SERVICE_FRIDGE );
			paraMap.put("SERVICE_IRON", SERVICE_IRON );
			paraMap.put("SERVICE_BATHTUB", SERVICE_BATHTUB );
			paraMap.put("SERVICE_HAIRDRYER", SERVICE_HAIRDRYER );
			paraMap.put("SERVICE_KITCHEN", SERVICE_KITCHEN );
			paraMap.put("SERVICE_SHOWERROOM", SERVICE_SHOWERROOM );
			
			n = service.roomRegister(paraMap);
			
		}
		
		if( n == 1) {
			msg = "객실 등록이 완료되었습니다.";
		}
		else {
			msg = "객실 등록에 실패했습니다.";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", request.getContextPath()+"/sellerModify.bc");
		
		return "msg";
	}
/////////////////////////////////////////////////////////////////////////////	
	// Home 에 뿌려주기
	@ResponseBody
	@RequestMapping(value="/seller/modifyHome.bc", method= {RequestMethod.GET})
	public String modifyHome(HttpServletRequest request) {
		
		String seller_id = request.getParameter("seller_id");
		String seller_pwd = request.getParameter("seller_pwd");
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("seller_id", seller_id );
		paraMap.put("seller_pwd", seller_pwd );
		
		KmtSellerMemberVO loginseller = service.sellerLogin(paraMap);
		
		String jsonStr = "";
		String msg ="";
		String loc ="";
		
		if(loginseller != null) {
			String result = null;
			msg = "";
			loc = "";
						
			jsonStr  = "";
			String emptyroom = request.getParameter("emptyroom");
			String checkin = request.getParameter("checkin");
			String checkout = request.getParameter("checkout");
			String usingroom = request.getParameter("usingroom");
			String inreserv = request.getParameter("inreserv");
			String outreserv = request.getParameter("outreserv");
			String today = request.getParameter("today");

			
			paraMap.put("emptyroom", emptyroom );
			paraMap.put("checkin", checkin );
			paraMap.put("checkout", checkout );
			paraMap.put("usingroom", usingroom );
			paraMap.put("inreserv", inreserv );
			paraMap.put("outreserv", outreserv );
			paraMap.put("today", today );
			
			result = service.modifyHome(paraMap);
			return jsonStr;
		}
		else {
			msg = "로그인을 하셔야 합니다 .";
			loc = request.getContextPath()+"/seller/login.bc";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			return "msg";
		}


	}
//////////////////////////////////////////////////////////////////////////////	
	// 요금 조정
	@ResponseBody
	@RequestMapping(value="/seller/adjustPrice.bc", method= {RequestMethod.POST})
	public String adjustPrice(HttpServletRequest request) {
		
		String jsonStr = "";
		
		String fk_hotel_idx = request.getParameter("fk_hotel_idx");
		String logdate = request.getParameter("logdate");
		
		String roomPriceListCount = request.getParameter("roomPriceListCount");
		
		int n = Integer.parseInt(roomPriceListCount);
		int result = 0;
		
		for( int i = 0 ; i<= n ; i++) {
			
			HashMap<String,String> paraMap = new HashMap<String,String>();
			
			paraMap.put("logdate",logdate);
			
			String fk_room_idx = request.getParameter("room_idx"+i);
			String roomprice_seqno = request.getParameter("roomprice_seqno"+i);
			String roomprice = request.getParameter("roomprice"+i);
			String roomprice_quantity = request.getParameter("roomprice_quantity"+i);
			
			System.out.println("fk_room_idx : "+fk_room_idx);
			System.out.println("roomprice_seqno : "+roomprice_seqno);
			System.out.println("roomprice : "+roomprice);
			System.out.println("roomprice_quantity : "+roomprice_quantity);
			
			paraMap.put("fk_room_idx", fk_room_idx );
			paraMap.put("roomprice_seqno", roomprice_seqno );
			paraMap.put("roomprice", roomprice );
			paraMap.put("roomprice_quantity", roomprice_quantity );
			
			result += service.adjustRoomPrice(paraMap);
		}
		
		JSONObject jsonObj = new JSONObject();
		
		if(result == (n+1)) {
			
			jsonObj.put("msg", "success");
			jsonStr = jsonObj.toString();
			
		}
		else {
			
			jsonObj.put("msg", "fail");
			jsonStr = jsonObj.toString();
			
		}
		
		return jsonStr;
	}
	
	
	
	// 특정 날짜의 방의 가격, 수량 받아오기
	@ResponseBody
	@RequestMapping(value="/seller/getPriceQuant.bc")
	public String getPriceQuant(HttpServletRequest request) {
		
		String jsonStr = "";
		
		String logdate = request.getParameter("logdate");
		String fk_hotel_idx = request.getParameter("fk_hotel_idx");
		
		System.out.println("fk_hotel_idx: "+fk_hotel_idx);
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("logdate",logdate);
		paraMap.put("fk_hotel_idx", fk_hotel_idx);
		
		// 방, 특정 날짜의 가격 불러오기 
		List<HashMap<String,String>> roomPriceList = service.getRoomPriceList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(roomPriceList != null) {
			
			for( HashMap<String,String> map : roomPriceList ) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("room_idx", map.get("room_idx"));
				jsonObj.put("room_name", map.get("room_name"));
				jsonObj.put("fk_hotel_idx", map.get("fk_hotel_idx"));
				jsonObj.put("roomprice_seqno", map.get("roomprice_seqno"));
				jsonObj.put("roomprice", map.get("roomprice"));
				jsonObj.put("roomprice_date", map.get("roomprice_date"));
				jsonObj.put("roomprice_quantity", map.get("roomprice_quantity"));
				
				jsonArr.put(jsonObj);
				
			}
			jsonStr = jsonArr.toString();
		}
		
		return jsonStr;
	}
	
	
	
	
	
	
} // end of class --------------------------------------------
