package com.gdu.sporters.shopAdmin.util;

import org.springframework.stereotype.Component;

import lombok.Getter;

@Getter
@Component
public class ShopAdminSearchPageUtil {
	private int page;                // 현재 페이지(파라미터로 받아온다)
	private int totalRecord;         // 전체 레코드 개수(DB에서 구해온다)
	private int recordPerPage = 10;  // 페이지에 표시할 레코드 개수(10개로 되어 있다)
	private int begin;               // 가져올 목록의 시작 번호(계산한다)
	private int end;                 // 가져올 목록의 끝 번호(계산한다)
	
	private int totalPage;           // 전체 페이지 개수(계산한다)
	private int pagePerBlock = 10;   // 블록에 표시할 페이지 개수(10개로 되어 있다)
	private int beginPage;           // 블록의 시작 페이지 번호(계산한다)
	private int endPage;             // 블록의 끝 페이지 번호(계산한다)
	
	
	public void setNaverPageUtil(int page, int totalRecord) {
		
		// page, totalRecord 필드 저장
		this.page = page;
		this.totalRecord = totalRecord;
		
		// begin, end 계산
		begin = (page - 1) * recordPerPage + 1;
		end = begin + recordPerPage - 1;
		if(end > totalRecord) {
			end = totalRecord;
		}

		// totalPage 계산
		totalPage = totalRecord / recordPerPage;
		if(totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		
		// beginPage, endPage 계산
		if (page <= (pagePerBlock / 2) + 1) {
			beginPage = 1;
		} else if (page > totalPage - (pagePerBlock / 2)) {
			beginPage = totalPage - pagePerBlock + 1;
			if(beginPage < 1) {
				beginPage = 1;
			}
		} else {
			beginPage = page - (pagePerBlock / 2);
		}
		endPage = beginPage + pagePerBlock - 1;
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
	}

	public String getNaverPaging(String path) {
		
		StringBuilder sb = new StringBuilder();
		
		if(path.contains("?")) {
			path += "&";
		} else {
			path += "?";
		}
		
		sb.append("<div class=\"paging\">");
		
		// 이전 페이지 (<이전), 1페이지는 표시하지 않는다.
		if(page != 1) {
			sb.append("<a class=\"prev_page\" href=\"" + path + "page=" + (page - 1) + "\">&lt;이전</a>");
		}
		
		// 페이지 번호 (1 2 3 ... 9 10), 현재 페이지는 <a> 태그가 없다.
		for(int p = beginPage; p <= endPage; p++) {
			if(p == page) {
				sb.append("<strong class=\"page\">" + p + "</strong>");
			} else {
				sb.append("<a class=\"page\" href=\"" + path + "page=" + p + "\">" + p + "</a>");
			}
		}
		
		// 다음 페이지 (다음>), 마지막 페이지는 표시하지 않는다.
		if(page != totalPage) {
			sb.append("<a class=\"next_page\" href=\"" + path + "page=" + (page + 1) + "\">다음&gt;</a>");
		}
		
		sb.append("</div>");
		
		return sb.toString();
		
	}
}
