package com.gdu.sporters.users.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.sporters.users.service.HeartService;

@RestController // @Controller + @ResponseBody
public class HeartController {

	@Autowired
	private HeartService heartService;
	
	
	@GetMapping(value="/heart/isHeartCheck", produces="application/json")
	public Map<String, Object> isHeartCheck(HttpServletRequest request){
		return heartService.isHeartCheck(request);
	}
	
	@GetMapping(value="/heart/getHeartCheck", produces="application/json")
	public Map<String, Object> getHeartCheck(HttpServletRequest request){
		return heartService.getHeartCheck(request);
	}
	
	// 좋아요 표시
	@GetMapping(value="/heart/markLike", produces="application/json")
	public Map<String, Object> requiredLogin_mark(HttpServletRequest request){
		return heartService.markLike(request);
	}
	
	// 싫어요 표시
	@GetMapping(value="/heart/markhate", produces="application/json")
	public Map<String, Object> requiredLogin_markhate(HttpServletRequest request){
		return heartService.markhate(request);
	}
	
	// 좋아요 갯수
	@GetMapping(value="/heart/getHeartCount", produces="application/json")
	public Map<String, Object> getHeartCount(int userNo){
		return heartService.getHeartCount(userNo);
	}
	
	// 싫어요 갯수
	@GetMapping(value="/heart/getHateCount", produces="application/json")
	public Map<String, Object> getHateCount(int userNo){
		return heartService.getHateCount(userNo);
	}
	
	// 좋ㅇㅏ요 식ㅎ어요
	@ResponseBody
	@GetMapping(value="/heart/likeNhate", produces="application/json")
	public Map<String, Object> likeNhate(int userNo){
		
		return heartService.likeNhate(userNo);
	}

	
}
