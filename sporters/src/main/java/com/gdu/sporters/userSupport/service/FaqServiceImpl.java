package com.gdu.sporters.userSupport.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.sporters.userSupport.domain.FaqDTO;
import com.gdu.sporters.userSupport.mapper.FaqMapper;
import com.gdu.sporters.util.QnaPageUtil;

@Service
public class FaqServiceImpl implements FaqService {

	@Autowired
	private FaqMapper faqMapper;
	@Autowired
	private QnaPageUtil pageUtil;
	
	@Override
	public void findAllFaqList(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = faqMapper.selectAllFaqCount();
		
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		List<FaqDTO> faqList = faqMapper.selectAllFaqList(map);
		
				
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("faqList", faqList);
		model.addAttribute("beginNo", totalRecord - (page -1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/faq/list"));
	}
	
	@Transactional
	@Override
	public void saveFaq(HttpServletRequest request, HttpServletResponse response) {
		String faqTitle = request.getParameter("faqTitle");
		String faqContent = request.getParameter("faqContent");
		int depth = Integer.parseInt(request.getParameter("depth"));
		int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		FaqDTO faq = new FaqDTO();
		faq.setFaqTitle(faqTitle);
		faq.setFaqContent(faqContent);
		faq.setDepth(depth);
		faq.setGroupNo(groupNo);
		int result = faqMapper.insertFaq(faq);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if( result > 0) {
				out.println("<script>");
				out.println("alert('작성이 완료되었습니다!');");
				out.println("location.href='/faq/list';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('작성이 실패했습니다!');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}

	}
	
	@Override
	public void modifyFaq(HttpServletRequest request, HttpServletResponse response) {
		String faqTitle = request.getParameter("faqTitle");
		String faqContent = request.getParameter("faqContent");
		int faqNo = Integer.parseInt(request.getParameter("faqNo"));
		
		FaqDTO faq = FaqDTO.builder()
				.faqTitle(faqTitle)
				.faqContent(faqContent)
				.build();
		int result = faqMapper.updateFaq(faq);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0 ) {
				out.println("alert('수정이 완료되었습니다!');");
				out.println("location.href='/faq/detail?faqNo=" + faqNo + "';");
			} else {
				out.println("alert('수정에 실패했습니다!');");
				out.println("history.back();");
			}
			out.println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void removeFaq(HttpServletRequest request, HttpServletResponse response) {
		int faqNo = Integer.parseInt(request.getParameter("faqNo"));
		int result = faqMapper.deleteFaq(faqNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result >0 ) {
				out.println("alert('삭제가 완료되었습니다!');");
				out.println("location.href='/faq/list'");
			} else {
				out.println("alert('삭제를 실패했습니다!');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	

	
	
	
}
