package com.gdu.sporters.board.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.sporters.board.domain.LocalCommDTO;
import com.gdu.sporters.board.mapper.GalleryLocalCommMapper;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.util.GalleryPageUtil;


@Service
public class GalleryLocalCommServiceImpl implements GalleryLocalCommService{

	@Autowired
	private GalleryLocalCommMapper commentMapper;
	
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	@Override
	public Map<String, Object> getLocalCommentCnt(int localBoardNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt", commentMapper.selectFreeCommentCnt(localBoardNo));
	
		return result;
	} 
	
	@Transactional
	@Override
	public Map<String, Object> addLocalComment(LocalCommDTO commContent, HttpServletRequest request) {
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
	public Map<String, Object> getLocalCommentList(HttpServletRequest request) {
		
		int localBoardNo = Integer.parseInt(request.getParameter("localBoardNo"));
		System.out.println("localBoardNo"+localBoardNo);
		int page = Integer.parseInt(request.getParameter("page"));		
		int commentCnt = commentMapper.selectFreeCommentCnt(localBoardNo);
		galleryPageUtil.setPageUtil(page, commentCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("localBoardNo", localBoardNo);
		
		System.out.println(commentCnt);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("LocalcommentList", commentMapper.selectFreeCommentList(map));
		result.put("galleryPageUtil", galleryPageUtil);
		System.out.println(commentMapper.selectFreeCommentList(map));
		return result;
		
	}
	
	@Override
	public Map<String, Object> removeLocalComment(int localCoNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteFreeComment(localCoNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addLocalReply(LocalCommDTO reply, HttpServletRequest request) {
		// Session의 User 정보
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		reply.setUserNo(loginUser.getUserNo());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertFreeReply(reply) == 1);
		return result;
	}
	
	
}
