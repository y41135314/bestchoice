package com.project.yhj.search;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class YhjSearchVO {

	private String latitude ;	// 위도
	private String longitude;	// 경도
	
	private String searchWord;			// 검색어
	private String orderBy;				// 정렬	(1 평점,2 거리,3 낮은가격,4 높은가격)
	
	// 현재예약상태 ( tbl_here_resStatus 의 resStatus_in_year, resStatus_in_month, resStatus_in_day  와  resStatus_out_year, resStatus_out_month, resStatus_out_day )
	// 컬럼들 모아서 alias 로 startday, endday 지정할 것
	private String startday;			// 입실일
	private String endday;				// 퇴실일
	
	// 판매자 소유 객실 정보 테이블 ( tbl_here_roomInfo 의 room_Person ) 
	private String room_Person;				// 인원수
	
	// 판매자 소유 호텔 정보 테이블 ( tbl_here_hotelInfo 의 hotel_Category )
	private String hotel_Category0;		// 일반 ( 0 )
	private String hotel_Category1;		// 특급 ( 1 )
	private String hotel_Category2;		// 특1급 ( 2 )
	
	// 침대유형 ( tbl_here_bed ) 보유하고 있으면 1 없으면 0 
	private String bed_single;			// 싱글 베드
	private String bed_double;			// 더블 베드
	private String bed_twin;			// 트윈 베드
	private String bed_ondol;			// 온돌 베드
	
	// 내부객시설 ( tbl_here_service ) 보유하고 있으면 1 없으면 0 
	private String service_spa   ;    			// 스파
	private String service_minibar  ;			// 미니바
	private String service_wifi  ;  			// 와이파이
	private String service_towel   ;			// 욕실용품
	private String service_tv     ; 			// 티비
	private String service_airconditioner  ;	// 에어컨
	private String service_fridge    ;    		// 냉장고
	private String service_showerroom    ;		// 객실사워실
	private String service_bathtub   ;   		// 욕조
	private String service_hairdryer   ; 		// 드라이기
	private String service_iron    ;   			// 다리미
	private String service_kitchen   ;  		// 전기밥솥
	
	// 이색테마유형  ( tbl_here_theme ) 보유하고 있으면 1 없으면 0 
	private String theme_mooin   ;			// 무인텔
	private String theme_party    ;			// 파티룸
	private String theme_mirror    ;		// 미러룸
	private String theme_doubleFloor ;		// 복층룸
	private String theme_princess  ;		// 공주룸
	private String theme_terras  ;			// 야외 테라스
	private String theme_ocean  ;			// 오션뷰
	private String theme_lake  ;			// 호수뷰
	private String theme_sky   ;			// 스카이뷰

	// 스파유형 ( tbl_here_spa ) 보유하고 있으면 1 없으면 0
	private String spa_wpool   ;			// 월풀
	private String spa_sauna   ;			// 사우나
	private String spa_massage  ;			// 마사지베드
	private String spa_hinokki   ;			// 히노끼탕
	private String spa_openbath  ;			// 노천탕
	private String spa_halfpool  ;			// 반신욕
	private String spa_tv   ;				// 욕실내 TV
	
	
	// getter & setter
	
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getOrderBy() {
		
		if ( orderBy == null) {
			return "1";
		}
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getStartday() {
		
		if(startday== null|| "".equals(startday)) {
			SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd");
			Date time = new Date();
			String time1 = format.format(time);
			
			return time1;
		}
		else {
			return startday;
		}
		
	}
	public void setStartday(String startday) {
		this.startday = startday;
	}
	public String getEndday() {
		
		if(endday== null || "".equals(endday) ) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Calendar cal = Calendar.getInstance(); 
			cal.setTime(new Date()); 
			cal.add(Calendar.DATE, 1); 
			
			String strDate = df.format(cal.getTime()); 
			
			return strDate;
		}
		else {
			return endday;
		}
	}
	public void setEndday(String endday) {
		this.endday = endday;
	}
	
	
	public String getRoom_Person() {
		
		if(room_Person == null) {
			return "2";
		}
		return room_Person;
	}
	public void setRoom_Person(String room_Person) {
		this.room_Person = room_Person;
	}
	
	public String getHotel_Category0() {
		return hotel_Category0;
	}
	public void setHotel_Category0(String hotel_Category0) {
		this.hotel_Category0 = hotel_Category0;
	}
	public String getHotel_Category1() {
		return hotel_Category1;
	}
	public void setHotel_Category1(String hotel_Category1) {
		this.hotel_Category1 = hotel_Category1;
	}
	public String getHotel_Category2() {
		return hotel_Category2;
	}
	public void setHotel_Category2(String hotel_Category2) {
		this.hotel_Category2 = hotel_Category2;
	}
	public String getBed_single() {
		return bed_single;
	}
	public void setBed_single(String bed_single) {
		this.bed_single = bed_single;
	}
	public String getBed_double() {
		return bed_double;
	}
	public void setBed_double(String bed_double) {
		this.bed_double = bed_double;
	}
	public String getBed_twin() {
		return bed_twin;
	}
	public void setBed_twin(String bed_twin) {
		this.bed_twin = bed_twin;
	}
	public String getBed_ondol() {
		return bed_ondol;
	}
	public void setBed_ondol(String bed_ondol) {
		this.bed_ondol = bed_ondol;
	}

	public String getService_spa() {
		return service_spa;
	}
	public void setService_spa(String service_spa) {
		this.service_spa = service_spa;
	}
	public String getService_minibar() {
		return service_minibar;
	}
	public void setService_minibar(String service_minibar) {
		this.service_minibar = service_minibar;
	}
	public String getService_wifi() {
		return service_wifi;
	}
	public void setService_wifi(String service_wifi) {
		this.service_wifi = service_wifi;
	}
	public String getService_towel() {
		return service_towel;
	}
	public void setService_towel(String service_towel) {
		this.service_towel = service_towel;
	}
	public String getService_tv() {
		return service_tv;
	}
	public void setService_tv(String service_tv) {
		this.service_tv = service_tv;
	}
	public String getService_airconditioner() {
		return service_airconditioner;
	}
	public void setService_airconditioner(String service_airconditioner) {
		this.service_airconditioner = service_airconditioner;
	}
	public String getService_fridge() {
		return service_fridge;
	}
	public void setService_fridge(String service_fridge) {
		this.service_fridge = service_fridge;
	}
	public String getService_showerroom() {
		return service_showerroom;
	}
	public void setService_showerroom(String service_showerroom) {
		this.service_showerroom = service_showerroom;
	}
	public String getService_bathtub() {
		return service_bathtub;
	}
	public void setService_bathtub(String service_bathtub) {
		this.service_bathtub = service_bathtub;
	}
	public String getService_hairdryer() {
		return service_hairdryer;
	}
	public void setService_hairdryer(String service_hairdryer) {
		this.service_hairdryer = service_hairdryer;
	}
	public String getService_iron() {
		return service_iron;
	}
	public void setService_iron(String service_iron) {
		this.service_iron = service_iron;
	}
	public String getService_kitchen() {
		return service_kitchen;
	}
	public void setService_kitchen(String service_kitchen) {
		this.service_kitchen = service_kitchen;
	}
	public String getTheme_mooin() {
		return theme_mooin;
	}
	public void setTheme_mooin(String theme_mooin) {
		this.theme_mooin = theme_mooin;
	}
	public String getTheme_party() {
		return theme_party;
	}
	public void setTheme_party(String theme_party) {
		this.theme_party = theme_party;
	}
	public String getTheme_mirror() {
		return theme_mirror;
	}
	public void setTheme_mirror(String theme_mirror) {
		this.theme_mirror = theme_mirror;
	}
	public String getTheme_doubleFloor() {
		return theme_doubleFloor;
	}
	public void setTheme_doubleFloor(String theme_doubleFloor) {
		this.theme_doubleFloor = theme_doubleFloor;
	}
	public String getTheme_princess() {
		return theme_princess;
	}
	public void setTheme_princess(String theme_princess) {
		this.theme_princess = theme_princess;
	}
	public String getTheme_terras() {
		return theme_terras;
	}
	public void setTheme_terras(String theme_terras) {
		this.theme_terras = theme_terras;
	}
	public String getTheme_ocean() {
		return theme_ocean;
	}
	public void setTheme_ocean(String theme_ocean) {
		this.theme_ocean = theme_ocean;
	}
	public String getTheme_lake() {
		return theme_lake;
	}
	public void setTheme_lake(String theme_lake) {
		this.theme_lake = theme_lake;
	}
	public String getTheme_sky() {
		return theme_sky;
	}
	public void setTheme_sky(String theme_sky) {
		this.theme_sky = theme_sky;
	}
	public String getSpa_wpool() {
		return spa_wpool;
	}
	public void setSpa_wpool(String spa_wpool) {
		this.spa_wpool = spa_wpool;
	}
	public String getSpa_sauna() {
		return spa_sauna;
	}
	public void setSpa_sauna(String spa_sauna) {
		this.spa_sauna = spa_sauna;
	}
	public String getSpa_massage() {
		return spa_massage;
	}
	public void setSpa_massage(String spa_massage) {
		this.spa_massage = spa_massage;
	}
	public String getSpa_hinokki() {
		return spa_hinokki;
	}
	public void setSpa_hinokki(String spa_hinokki) {
		this.spa_hinokki = spa_hinokki;
	}
	public String getSpa_openbath() {
		return spa_openbath;
	}
	public void setSpa_openbath(String spa_openbath) {
		this.spa_openbath = spa_openbath;
	}
	public String getSpa_halfpool() {
		return spa_halfpool;
	}
	public void setSpa_halfpool(String spa_halfpool) {
		this.spa_halfpool = spa_halfpool;
	}
	public String getSpa_tv() {
		return spa_tv;
	}
	public void setSpa_tv(String spa_tv) {
		this.spa_tv = spa_tv;
	}
	
	
	/////////////////////////////////////////////////////////////////
	
	
	// view 단에 보낼 list 
	public String getStrList() {
		
		String strList = "";
		
		// 호텔유형
		if(hotel_Category0 !=null && !"".equals(hotel_Category0)) {
			strList += hotel_Category0+",";
		}
		if(hotel_Category1 !=null && !"".equals(hotel_Category1)) {
			strList += hotel_Category1+",";
		}
		if(hotel_Category2 !=null && !"".equals(hotel_Category2)) {
			strList += hotel_Category2+",";
		}
		
		// 침대 유형
		if(bed_single !=null && !"".equals(bed_single)) {
			strList += bed_single+",";
		}
		if(bed_double !=null && !"".equals(bed_double)) {
			strList += bed_double+",";
		}
		if(bed_twin !=null && !"".equals(bed_twin)) {
			strList += bed_twin+",";
		}
		if(bed_ondol !=null && !"".equals(bed_ondol)) {
			strList += bed_ondol+",";
		}
		
		// 내부객시설
		if( service_spa != null && !"".equals(service_spa)) {
			strList += service_spa+",";
		}
		if( service_minibar != null && !"".equals(service_minibar)) {
			strList += service_minibar+",";
		}
		if( service_wifi != null && !"".equals(service_wifi)) {
			strList += service_wifi+",";
		}
		if( service_towel != null && !"".equals(service_towel)) {
			strList += service_towel+",";
		}
		if( service_tv != null && !"".equals(service_tv)) {
			strList += service_tv+",";
		}
		if( service_airconditioner != null && !"".equals(service_airconditioner)) {
			strList += service_airconditioner+",";
		}
		if( service_fridge != null && !"".equals(service_fridge)) {
			strList += service_fridge+",";
		}
		if( service_showerroom != null && !"".equals(service_showerroom)) {
			strList += service_showerroom+",";
		}
		if( service_bathtub != null && !"".equals(service_bathtub)) {
			strList += service_bathtub+",";
		}
		if( service_hairdryer != null && !"".equals(service_hairdryer)) {
			strList += service_hairdryer+",";
		}
		if( service_iron != null && !"".equals(service_iron)) {
			strList += service_iron+",";
		}
		if( service_kitchen != null && !"".equals(service_kitchen)) {
			strList += service_kitchen+",";
		}
		
		// 이색테마유형
		if( theme_mooin != null && !"".equals(theme_mooin)) {
			strList += theme_mooin+",";
		}
		if( theme_party != null && !"".equals(theme_party)) {
			strList += theme_party+",";
		}
		if( theme_mirror != null && !"".equals(theme_mirror)) {
			strList += theme_mirror+",";
		}
		if( theme_doubleFloor != null && !"".equals(theme_doubleFloor)) {
			strList += theme_doubleFloor+",";
		}
		if( theme_princess != null && !"".equals(theme_princess)) {
			strList += theme_princess+",";
		}
		if( theme_terras != null && !"".equals(theme_terras)) {
			strList += theme_terras+",";
		}
		if( theme_ocean != null && !"".equals(theme_ocean)) {
			strList += theme_ocean+",";
		}
		if( theme_lake != null && !"".equals(theme_lake)) {
			strList += theme_lake+",";
		}
		if( theme_sky != null && !"".equals(theme_sky)) {
			strList += theme_sky+",";
		}

		// 스파유형 
		if( spa_wpool != null && !"".equals(spa_wpool)) {
			strList += spa_wpool+",";
		}
		if( spa_sauna != null && !"".equals(spa_sauna)) {
			strList += spa_sauna+",";
		}
		if( spa_massage != null && !"".equals(spa_massage)) {
			strList += spa_massage+",";
		}
		if( spa_hinokki != null && !"".equals(spa_hinokki)) {
			strList += spa_hinokki+",";
		}
		if( spa_openbath != null && !"".equals(spa_openbath)) {
			strList += spa_openbath+",";
		}
		if( spa_halfpool != null && !"".equals(spa_halfpool)) {
			strList += spa_halfpool+",";
		}
		if( spa_tv != null && !"".equals(spa_tv)) {
			strList += spa_tv+",";
		}
				
		if(strList.length() == 0) {
			strList = null;
		}
		else{
			
			strList = strList.substring(0, strList.length()-1);
			// System.out.println(strList);
		}
		
		return strList;	
	}
	
	
	
	// sql문에 넣을 테이블 별로 적용할 리스트들 각자 만들어 놓기 ( null 이 아닌 값만 들어오게 함 )
	
	
	
	// 판매자 소유 호텔 정보 테이블 ( tbl_here_hotelInfo 의 hotel_Category )
	public List<String> getHotelInfoList(){
		
		List<String> result = new ArrayList<String>();
		
		if (hotel_Category0 != null ) {
			result.add("0");
		}
		if (hotel_Category1 != null ) {
			result.add("1");
		}
		if (hotel_Category2 != null ) {
			result.add("2");
		}
		
		if(result.size()==0) {
			result = null;
		}
		
		return result ;
	}
	
	// 침대유형 ( tbl_here_bed ) 보유하고 있으면 1 없으면 0 
	public List<String> getBedList(){
		
		List<String> result = new ArrayList<String>();
		
		if (bed_single != null ) {
			result.add(bed_single);
		}
		if (bed_double != null ) {
			result.add(bed_double);
		}
		if (bed_twin != null ) {
			result.add(bed_twin);
		}
		if (bed_ondol != null ) {
			result.add(bed_ondol);
		}
		
		if(result.size()==0) {
			result = null;
		}
		
		return result ;
	}
	
	// 내부객시설 ( tbl_here_service ) 보유하고 있으면 1 없으면 0 
	public List<String> getServiceList(){
		
		List<String> result = new ArrayList<String>();
		
		if (service_spa != null ) {
			result.add(service_spa);
		}
		if (service_minibar != null ) {
			result.add(service_minibar);
		}
		if (service_wifi != null ) {
			result.add(service_wifi);
		}
		if (service_towel != null ) {
			result.add(service_towel);
		}
		if (service_tv != null ) {
			result.add(service_tv);
		}
		if (service_airconditioner != null ) {
			result.add(service_airconditioner);
		}
		if (service_fridge != null ) {
			result.add(service_fridge);
		}
		if (service_showerroom != null ) {
			result.add(service_showerroom);
		}
		if (service_bathtub != null ) {
			result.add(service_bathtub);
		}
		if (service_hairdryer != null ) {
			result.add(service_hairdryer);
		}
		if (service_iron != null ) {
			result.add(service_iron);
		}
		if (service_kitchen != null ) {
			result.add(service_kitchen);
		}
		
		if(result.size()==0) {
			result = null;
		}
		
		return result ;
	}
	
	// 이색테마유형  ( tbl_here_theme ) 보유하고 있으면 1 없으면 0 
	public List<String> getThemeList(){
		
		List<String> result = new ArrayList<String>();
		
		if (theme_mooin != null ) {
			result.add(theme_mooin);
		}
		if (theme_party != null ) {
			result.add(theme_party);
		}
		if (theme_mirror != null ) {
			result.add(theme_mirror);
		}
		if (theme_doubleFloor != null ) {
			result.add(theme_doubleFloor);
		}
		if (theme_princess != null ) {
			result.add(theme_princess);
		}
		if (theme_terras != null ) {
			result.add(theme_terras);
		}
		if (theme_ocean != null ) {
			result.add(theme_ocean);
		}
		if (theme_lake != null ) {
			result.add(theme_lake);
		}
		if (theme_sky != null ) {
			result.add(theme_sky);
		}
		
		
		if(result.size()==0) {
			result = null;
		}
		
		return result ;
	}
	
	// 스파유형 ( tbl_here_spa ) 보유하고 있으면 1 없으면 0
	public List<String> getSpaList(){
		
		List<String> result = new ArrayList<String>();
		
		if (spa_wpool != null ) {
			result.add(spa_wpool);
		}
		if (spa_sauna != null ) {
			result.add(spa_sauna);
		}
		if (spa_massage != null ) {
			result.add(spa_massage);
		}
		if (spa_hinokki != null ) {
			result.add(spa_hinokki);
		}
		if (spa_openbath != null ) {
			result.add(spa_openbath);
		}
		if (spa_halfpool != null ) {
			result.add(spa_halfpool);
		}
		if (spa_tv != null ) {
			result.add(spa_tv);
		}
		
		if(result.size()==0) {
			result = null;
		}
		
		return result ;
	}
	
	
}
