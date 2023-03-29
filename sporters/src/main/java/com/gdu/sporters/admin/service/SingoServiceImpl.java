package com.gdu.sporters.admin.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.sporters.admin.domain.SingoCategoryDTO;
import com.gdu.sporters.admin.domain.SingoDTO;
import com.gdu.sporters.admin.mapper.SingoMapper;
import com.gdu.sporters.board.domain.FreeDTO;
import com.gdu.sporters.util.GalleryPageUtil;

@Service
public class SingoServiceImpl implements SingoService {
	
	@Autowired
	private SingoMapper singoMapper;
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	@Override
	public void addCategory(HttpServletRequest request) {
		// 파라미터
		String categoryName = request.getParameter("categoryName");
		
		SingoCategoryDTO category = SingoCategoryDTO.builder()
				.singoCategoryName(categoryName)
				.build();
		
		singoMapper.insertSingoCategory(category);
	}
		
	@Override
	public void deleteCategory(HttpServletRequest request, HttpServletResponse response) {
	int singoCategoryNo = Integer.parseInt(request.getParameter("singoCategoryNo"));
		
		// DB에서 카테고리 삭제
		int result = singoMapper.deleteSingoCategory(singoCategoryNo);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				out.println("<script>");
				out.println("alert('카테고리가 정상적으로 삭제 되었습니다.');");
				out.println("location.href='/admin/singoCategory';");
				
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('카테고리 삭제를 실패했습니다. 다시 시도해 주세요.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<SingoCategoryDTO> getCategoryList() {
		return singoMapper.selectSingoCategoryList();
	}
	
	@Override
	public List<SingoDTO>  getSingoList(HttpServletRequest request, Model model) {
	
//	Map<String, Object> map = new HashMap<String, Object>();
//	map.put("begin", galleryPageUtil.getBegin());
//	map.put("recordPerPage", galleryPageUtil.getRecordPerPage());

//	model.addAttribute("singoList", singoMapper.selectSingoList());
	return singoMapper.selectSingoList();
	}
	
	@Override
	public void singoButton(HttpServletRequest request, HttpServletResponse response) {
		String singoCategory = request.getParameter("singoCategory");
		String singoTitle = request.getParameter("singoTitle");
	
		String content = request.getParameter("singoContent");
		String url = request.getParameter("singoURL");
		
		//////////////////////////////////////////////////////////
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		
		//////////////////////////////////////////////////////////
		/*
			지원공주 숙제 : free 게시판에서 UserNo랑 FreeNo 파라미터로 받아오기
			<input type="hidden" name="userNo" value="글쓴이유저번호">
			<input type="hidden" name="freeNo" value="신고받은 게시물">
			
			링크 url은 받아오는건가? 고건 언니가 잘했을거같음 위에 코드보니 호호호..무튼 저는 자러갑니다.
			jsp만 해주시오
		*/
		
		if ( request.getQueryString() != null )
		url = url + "?" + request.getQueryString();
		SingoDTO singo = SingoDTO.builder()
				.singoCategory(singoCategory)
				.singoTitle(singoTitle)
				.singoLink(url)
				.singoUserReason(content)
				.userNo(userNo)
				.freeNo(freeNo)
				.build();
		int result = singoMapper.insertSingo(singo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if (result > 0) {
				out.println("alert('게시글을 신고했습니다.');");
				out.println("location.href='/free/list';");
			} else {
				out.println("alert('게시글을 신고할 수 없습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void singoUpdate(HttpServletRequest request, HttpServletResponse response) {
		String singoReason = request.getParameter("singoReason");
		SingoDTO singo = SingoDTO.builder()
				.singoReason(singoReason)
				.build();
		int result = singoMapper.adminUpdateSingo(singo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if (result > 0) {
				out.println("alert('게시글을 삭제하세요.');");
				out.println("location.href='/free/list';");
			} else {
				out.println("alert('게시글을 신고할 수 없습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
		

	
	
}
