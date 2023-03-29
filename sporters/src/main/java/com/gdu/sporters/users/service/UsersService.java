package com.gdu.sporters.users.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.sporters.users.domain.SleepUsersDTO;
import com.gdu.sporters.users.domain.UsersDTO;

public interface UsersService {
	
	public Map<String, Object> isSameId(String id);
	public Map<String, Object> isSameEmail(String email);
	public Map<String, Object> isSameNickname(String nickname);
	public Map<String, Object> sendAuthCode(String email);
	public void join (HttpServletRequest request, HttpServletResponse response);
	public void login(HttpServletRequest request, HttpServletResponse response);
	public void keepLogin(HttpServletRequest request, HttpServletResponse response);
	public void logout(HttpServletRequest request, HttpServletResponse response);
	public UsersDTO getUsersBySessionId(Map<String, Object> map);
	public SleepUsersDTO getSleepUsersById(String id);
	public void sleepUserHandle();
	public void comebackUser(HttpServletRequest request, HttpServletResponse response);
	public void userInformation(HttpServletRequest request, Model model);
	
	// 정보수정
	public Map<String, Object> confirmPassword(HttpServletRequest request);
	public void modifyInfo(HttpServletRequest request, HttpServletResponse response);
	public void modifyPw(HttpServletRequest request, HttpServletResponse response);
	
	// 탈퇴
	public void withdraw(HttpServletRequest request, HttpServletResponse response);
	
	// 네이버 아이디 로그인
	public String getNaverLoginApiURL(HttpServletRequest request);
	public String getNaverLoginToken(HttpServletRequest request);
	public UsersDTO getNaverLoginProfile(String access_token);
	public UsersDTO getNaverUserById(String id);
	public void naverLogin(HttpServletRequest request, UsersDTO naverUser);
	public void naverJoin(HttpServletRequest request, HttpServletResponse response);

	public Map<String, Object> findUser(Map<String, Object> map);
	public Map<String, Object> sendTemporaryPassword(UsersDTO user);
}
