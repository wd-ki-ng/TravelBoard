package com.travel.util;

public class Util {

	public static int str2Int(String str) { 

		String numberOnly = str.replaceAll("[^0-9]", "");
		return Integer.parseInt(numberOnly);
	}

	public static boolean intCheck(String str) {
		boolean result = true;
		for (int i = 0; i < str.length(); i++) {
			if (!Character.isDigit(str.charAt(i))) {
				result = false;
				break;
			}
		}
		return result;
	}

	// ip가져오기
//	public static String getIP(HttpServletRequest request) {
//		String ip = request.getHeader("X-FORWARDED-FOR");
//
//		if (ip == null) {
//			ip = request.getHeader("Proxy-Client-IP");
//		}
//		if (ip == null) {
//			ip = request.getHeader("WL-Proxy-Client-IP");
//		}
//		if (ip == null) {
//			ip = request.getHeader("HTTP_CLIENT_IP");
//		}
//		if (ip == null) {
//			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
//		}
//		if (ip == null) {
//			ip = request.getRemoteAddr();
//		}
//		return ip;
//
//	}

	// 24.01.23 HTML 태그를 특수기호로 변경하기 <:&lt, >:&gt
	public static String removeTag(String str) {
		str = str.replace("<", "&lt");
		str = str.replace(">", "&gt");
		return str;
	}

	//24.01.23 엔터처리
	public static String addBR(String str) {
		return str.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	}

	
	// 24.01.23 아이피 중간을 가리고 ♡로 출력되게 하기 172.30.1.99 -> 172.♡.1.99
//	public static String ipMasking(String ip) {
//		if (ip.indexOf('.') != -1) {
//			StringBuffer sb = new StringBuffer(); // 멀티스레드 환경에서도 동기화 지원
//			sb.append(ip.substring(0, ip.indexOf('.')+1));
//			sb.append("♡");
//			sb.append(ip.substring(ip.indexOf('.',ip.indexOf('.')+1)));
//			return sb.toString();
//		} else {
//			return ip;
//		}
//	}
	}
