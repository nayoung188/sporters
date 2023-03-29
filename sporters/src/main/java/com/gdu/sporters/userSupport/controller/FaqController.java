package com.gdu.sporters.userSupport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gdu.sporters.userSupport.service.FaqService;

@Controller
public class FaqController {
	
	@Autowired
	private FaqService faqService;
	
	@GetMapping("/faq/list")
	public String list(HttpServletRequest request, Model model) {
		faqService.findAllFaqList(request, model);
		return "/qnaList/faq/list";
	}
	@GetMapping("/faq/write")
	public String write() {
		return "/qnaList/faq/write";
	}
	
	@PostMapping("/faq/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		faqService.saveFaq(request, response);
	}

}
