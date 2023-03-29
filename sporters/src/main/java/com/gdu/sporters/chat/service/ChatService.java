package com.gdu.sporters.chat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.sporters.chat.domain.ChatUserDTO;

public interface ChatService {
	public void chatRoomList(HttpServletRequest request, Model model);
	public void addChatRoom(HttpServletRequest request, HttpServletResponse response);
	public void chatRoomByNo(HttpServletRequest request, Model model);
	public void chatClose(HttpServletRequest request, Model model);
	public void chatCheckPw(HttpServletRequest request, HttpServletResponse response);
	public List<ChatUserDTO> getChatUserList();
	public void removeChatRoom(HttpServletRequest request, HttpServletResponse response);
}
