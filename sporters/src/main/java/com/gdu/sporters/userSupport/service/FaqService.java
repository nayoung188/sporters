package com.gdu.sporters.userSupport.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface FaqService {
	public void findAllFaqList(HttpServletRequest request, Model model);
	public void saveFaq(HttpServletRequest request, HttpServletResponse response);
	public void modifyFaq(HttpServletRequest request, HttpServletResponse response);
	public void removeFaq(HttpServletRequest request, HttpServletResponse response);
}
