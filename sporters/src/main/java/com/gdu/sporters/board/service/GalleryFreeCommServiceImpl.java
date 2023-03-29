package com.gdu.sporters.board.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.sporters.board.domain.FreeCommDTO;
import com.gdu.sporters.board.mapper.GalleryCommMapper;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.util.GalleryPageUtil;


@Service
public class GalleryFreeCommServiceImpl implements GalleryFreeCommService{

	@Autowired
	private GalleryCommMapper commentMapper;
	
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	@Override
	public Map<String, Object> getCommentCnt(int freeNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt", commentMapper.selectFreeCommentCnt(freeNo));
		
		return result;
	} 
	
	@Transactional
	@Override
	public Map<String, Object> addComment(FreeCommDTO commContent, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		
		int userNo = loginUser.getUserNo();
		commContent.setUserNo(userNo);
		
		result.put("isAdd", commentMapper.insertFreeComment(commContent) == 1);
		commentMapper.updateCommGroupOrder(commContent);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {
		
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		System.out.println("freeNo"+freeNo);
		int page = Integer.parseInt(request.getParameter("page"));		
		int commentCnt = commentMapper.selectFreeCommentCnt(freeNo);
		galleryPageUtil.setPageUtil(page, commentCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("freeNo", freeNo);
		
		System.out.println(commentCnt);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentList", commentMapper.selectFreeCommentList(map));
		result.put("galleryPageUtil", galleryPageUtil);
		System.out.println(commentMapper.selectFreeCommentList(map));
		return result;
		
	}
	
	@Override
	public Map<String, Object> removeComment(int freeCoNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteFreeComment(freeCoNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addReply(FreeCommDTO reply, HttpServletRequest request) {
		// Session의 User 정보
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		reply.setUserNo(loginUser.getUserNo());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertFreeReply(reply) == 1);
		return result;
	}
	
	
}
