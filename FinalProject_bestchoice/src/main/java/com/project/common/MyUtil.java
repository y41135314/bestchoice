package com.project.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드)를 작성해주는 메소드 생성 *** // 
		public static String replaceParameter(String param) {
			String result = param;
			
			if(param != null) {
				 // 관리자 게시판 
			/*	result = result.replaceAll("<", "&lt;");
				result = result.replaceAll(">", "&gt;");
				// result = result.replaceAll("&", "&amp;");
				result = result.replaceAll("\"", "&quot;");
				*/
				result = result.replaceAll("<script","&lt;script");
			}

			return result;
		}
		
		// 시큐어코드를 수정할 때 다시 평상시처럼 보이도록 하기
		public static String reverseReplaceParam(String param) {
			
			String result = param;
			
			if(param != null) {
				result = result.replaceAll( "&lt;" , "<" );
				result = result.replaceAll( "&gt;" , ">" );
				// result = result.replaceAll( "&amp;" , "&" );
				result = result.replaceAll( "&quot;", "\"" );
			}

			return result;
		}
		
		// 스마트 에디터용 시큐어 코드 메소드
		public static String replaceSmartEditor(String param) {
			
			String result = param;
			if(param != null) {
				result = result.replaceAll( "<script" , "&lt;script" );
			}
			return result;
		}
		
		// 스마트 에디터용 시큐어 코드 해제 메소드
		public static String reverseSmartEditor(String param) {
			
			String result = param;
			if(param != null) {
				result = result.replaceAll( "&lt;script" , "<script" );
			}
			return result;
		}
		
		
		
		// *** ? 다음의 데이터까지 포함한 URL 주소를 알아오는 메소드 생성 *** //
		public static String getCurrentURL(HttpServletRequest request) {
			
			String currentURL = request.getRequestURL().toString();
			// http://localhost:9090/MyMVC/shop/prodView.up
			
			String queryString = request.getQueryString();
			// pnum=3
			
			currentURL += "?"+queryString;
			// http://localhost:9090/MyMVC/shop/prodView.up?pnum=3
			
			String ctxPath = request.getContextPath();
			//   /MyMVC
			
			int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
			//                              21           +     6 
			
			currentURL = currentURL.substring(beginIndex+1);
			//                                    27+1
			// shop/prodView.up?pnum=3
			
			return currentURL;
			//  shop/prodView.up?pnum=3
		}
	
	
	
	
	
	
	
	
}
