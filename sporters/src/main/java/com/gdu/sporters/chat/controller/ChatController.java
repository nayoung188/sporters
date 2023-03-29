package com.gdu.sporters.chat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.chat.domain.ChatUserDTO;
import com.gdu.sporters.chat.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chat/chatList")
	public String chatList(HttpServletRequest request, Model model) {
		chatService.chatRoomList(request, model);
		return "chat/chatList";
	}
	
	@GetMapping("/chat/write")
	public String chatWrite() {
		return "chat/chatAdd";
	}
	
	@PostMapping("/chat/chatAdd")
	public void requiredChatLogin_chatAdd(HttpServletRequest request, HttpServletResponse response) {
		chatService.addChatRoom(request, response);
	}
	
	@GetMapping("/chat/chatRoom")
	public String requiredChatLogin_chatRoom(HttpServletRequest request, Model model) {
		chatService.chatRoomByNo(request, model);
		return "chat/chatRoom";
	}
	
	@GetMapping("/chat/chatRoom/lock")
	public String requiredChatLogin_lockChatRoom(String chatRoomId, Model model) {
		model.addAttribute("chatRoomId", chatRoomId);
		return "chat/chatRoomLock";
	}
	
	@PostMapping("/chat/chatRoom/lock/comfirm")
	public void requiredChatLogin_lockConfirmChatRoom(HttpServletRequest request, HttpServletResponse response) {
		chatService.chatCheckPw(request, response);
	}
	
	@PostMapping("/chat/close")
	public void chatClose(HttpServletRequest request, Model model) {
		chatService.chatClose(request, model);
	}
	
	@ResponseBody
	@GetMapping(value="/chat/userList", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<ChatUserDTO> chatUserList() {
		return chatService.getChatUserList();
	}
	
	@GetMapping("/chat/deleteChatRoom")
	public void removeChatRoom(HttpServletRequest request, HttpServletResponse response) {
		chatService.removeChatRoom(request, response);
	}
	
	
}
