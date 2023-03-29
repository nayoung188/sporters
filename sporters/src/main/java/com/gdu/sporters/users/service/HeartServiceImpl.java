package com.gdu.sporters.users.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.sporters.users.domain.HeartDTO;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.users.mapper.HeartMapper;

@Service
public class HeartServiceImpl implements HeartService {
	
	@Autowired
	private HeartMapper heartMapper;

	

	@Override
	public Map<String, Object> isHeartCheck(HttpServletRequest request) {
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int clickUserNo = loginUser.getUserNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		map.put("clickUserNo", clickUserNo);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isHeart", heartMapper.heartCheck(map));
		
		return result;
	}

	
	
	
	@Override
	public Map<String, Object> getHeartCheck(HttpServletRequest request) {
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("count", heartMapper.selectUserHeartCount(map));
		return result;
	}

	/*
	@Override
	public Map<String, Object> getHeartCount(int userNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userNo", userNo);
		result.put("count", heartMapper.selectUserHeartCount(result));
		return result;
	}
	
	@Override
	public Map<String, Object> getHateCount(int userNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userNo", userNo);
		result.put("count", heartMapper.selectUserHateCount(result));
		return result;
	}
	*/
	
	@Override
	public Map<String, Object> getHeartCount(int userNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userNo", userNo);
		result.put("heartcount", heartMapper.clickedUserHeartCount(result));
		return result;
	}
	
	@Override
	public Map<String, Object> getHateCount(int userNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userNo", userNo);
		result.put("hatecount", heartMapper.clickedUserHateCount(result));
		return result;
	}
	
	@Override
	public Map<String, Object> likeNhate(int userNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userNo", userNo);
		int like = heartMapper.clickedUserHeartCount(result);
		int hate = heartMapper.clickedUserHateCount(result);
		result.put("result", (like - hate));
		return result;
	}
	
	
	@Override
	public Map<String, Object> markLike(HttpServletRequest request) {
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int clickUserNo = loginUser.getUserNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		map.put("clickUserNo", clickUserNo);

		int loveResult = heartMapper.clickedUserHeartCount(map);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("loveResult", loveResult);

		HeartDTO heart = heartMapper.selectLoveOrHate(map);
		
		if(heartMapper.selectUserHeartCount(map) == 0) {   // 좋아요/싫어요를  안누를상태
			if(heart != null) { // 싫어요가 있을 경우(0이 아닐경우)
				result.put("cancel", heartMapper.deleteLove(map));
			}
			result.put("isSuccess", heartMapper.insertLove(map) == 1);
		} else {
			result.put("isSuccess", heartMapper.deleteLove(map) == 1);
		}
		
		
		return result;
	}
	
	@Override
	public Map<String, Object> markhate(HttpServletRequest request) {
		
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int clickUserNo = loginUser.getUserNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		map.put("clickUserNo", clickUserNo);

		int hateResult = heartMapper.clickedUserHateCount(map);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("hateResult", hateResult);

		
		HeartDTO heart = heartMapper.selectLoveOrHate(map);
		
		if(heartMapper.selectUserHateCount(map) == 0) {   // 좋아요/싫어요를  안누를상태
			if(heart != null) {
				heartMapper.deleteLove(map);
			}
			result.put("isSuccess", heartMapper.insertHate(map) == 1);
		} else {
			result.put("isSuccess", heartMapper.deleteLove(map) == 1);
		}
		return result;
	}
	
	

	
}
