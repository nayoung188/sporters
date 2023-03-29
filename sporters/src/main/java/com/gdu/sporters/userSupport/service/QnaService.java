package com.gdu.sporters.userSupport.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.sporters.userSupport.domain.QnaDTO;


public interface QnaService {
	
	public void findAllQnaList(HttpServletRequest request, Model model);
	public void saveQna(HttpServletRequest request, HttpServletResponse response);
	public QnaDTO getQnaByNo(int qnaNo);
	public void checkPwQna(HttpServletRequest request, HttpServletResponse response);
	public void modifyQna(HttpServletRequest request, HttpServletResponse response);
	public void removeQna(HttpServletRequest request, HttpServletResponse response);
}
