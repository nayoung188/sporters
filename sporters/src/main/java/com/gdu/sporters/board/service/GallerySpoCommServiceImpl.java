package com.gdu.sporters.board.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.sporters.board.domain.SpoCommDTO;
import com.gdu.sporters.board.mapper.GallerySpoCommMapper;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.util.GalleryPageUtil;


@Service
public class GallerySpoCommServiceImpl implements GallerySpoCommService{

	@Autowired
	private GallerySpoCommMapper commentMapper;
	
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	@Override
	public Map<String, Object> getSpoCommentCnt(int spoReviewNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt", commentMapper.selectFreeCommentCnt(spoReviewNo));
		return result;
	} 
	
	@Transactional
	@Override
	public Map<String, Object> addSpoComment(SpoCommDTO commContent, HttpServletRequest request) {
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
	public Map<String, Object> getSpoCommentList(HttpServletRequest request) {
		
		int spoReviewNo = Integer.parseInt(request.getParameter("spoReviewNo"));
		System.out.println("spoReviewNo"+spoReviewNo);
		int page = Integer.parseInt(request.getParameter("page"));		
		int commentCnt = commentMapper.selectFreeCommentCnt(spoReviewNo);
		galleryPageUtil.setPageUtil(page, commentCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("spoReviewNo", spoReviewNo);
		
		System.out.println(commentCnt);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("SpocommentList", commentMapper.selectFreeCommentList(map));
		result.put("galleryPageUtil", galleryPageUtil);
		System.out.println(commentMapper.selectFreeCommentList(map));
		return result;
		
	}
	
	@Override
	public Map<String, Object> removeSpoComment(int spoCoNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteFreeComment(spoCoNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addSpoReply(SpoCommDTO reply, HttpServletRequest request) {
		// Session의 User 정보
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		reply.setUserNo(loginUser.getUserNo());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertFreeReply(reply) == 1);
		return result;
	}
	
	
}
