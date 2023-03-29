package com.gdu.sporters.chat.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.sporters.chat.domain.ChatRoomDTO;
import com.gdu.sporters.chat.domain.ChatUserDTO;
import com.gdu.sporters.chat.mapper.ChatMapper;
import com.gdu.sporters.chat.util.ChatListPageUtil;
import com.gdu.sporters.users.domain.UsersDTO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatMapper chatMapper;
	
	@Autowired
	private ChatListPageUtil pageUtil;
	
	@Override
	public void chatRoomList(HttpServletRequest request, Model model) {
		
		// Page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// chatRoom 개수
		int totalChatRoomCnt = chatMapper.selectChatRoomCnt();
		
		// Paging 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, totalChatRoomCnt);
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage()); // begin부터 몇개 로 동작함.
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("chatList", chatMapper.selectChatRoomListByMap(map));
		
		
		// view로 전달할 데이터 Model에 저장
		model.addAttribute("chatRoomCnt", totalChatRoomCnt); // chatRoom List 전체 개수
		model.addAttribute("chatRoomList", chatMapper.selectChatRoomListByMap(map));
		model.addAttribute("beginNo", totalChatRoomCnt - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/chat/chatList"));
		
	}
	
	@Transactional
	@Override
	public void addChatRoom(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
		String roomTitle = request.getParameter("roomTitle");
		int maxUserCnt = Integer.parseInt(request.getParameter("maxUserCnt"));
		Optional<String> opt = Optional.ofNullable(request.getParameter("isPw"));
		int isPw = Integer.parseInt(opt.orElse("0"));
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("roomPw"));
		int roomPw = Integer.parseInt(opt2.orElse("0000"));
		
		// 객체에 담기
		// - 비밀번호를 체크했다면 비밀번호도 입력
		ChatRoomDTO chatRoom = ChatRoomDTO.builder()
				.chatRoomTitle(roomTitle)
				.maxUsersCnt(maxUserCnt)
				.isPw(isPw)
				.roomPw(roomPw)
				.build();
		
		int chatRoomResult = chatMapper.insertChatRoomInPw(chatRoom);

		// 생성한 채팅방 불러오기
		ChatRoomDTO createdChatRoom = chatMapper.selectChatRoomByDTO(chatRoom);
		
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(chatRoomResult > 0) {
				out.println("<script>");
				out.println("location.href='" + "/chat/chatRoom?chatRoomId=" + createdChatRoom.getChatRoomId() + "'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('[오류] 채팅방 생성을 완료하지 못했습니다. 다시 시도해 주세요.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void chatRoomByNo(HttpServletRequest request, Model model) {
		
		// 파라미터
		int chatRoomId = Integer.parseInt(request.getParameter("chatRoomId"));
		
		// session영역에서 user 받아오기
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		
		// 담아갈 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatRoomId", chatRoomId);
		map.put("userNo", loginUser.getUserNo());
		
		// 현재 채팅방에 유저가 있는지 검색
		List<ChatUserDTO> chatUser = chatMapper.selectUserListByChatUserNo(map);
		
		// 유저가 없다면 INSERT
		if(chatUser.size() == 0) {
			chatMapper.insertChatUser(map);
		}
		
		// mapper에 접속한 user 정보 전송
		model.addAttribute("user", chatMapper.selectUserByChat(loginUser.getUserNo())); // 현재유저
		model.addAttribute("userList", chatMapper.selectUserListByChat()); // 채팅방 유저 목록
		model.addAttribute("chatRoom", chatMapper.selectChatRoomByNo(map)); // 채팅방 정보
		model.addAttribute("currUserCnt", chatMapper.selectChatUserCnt(map)); // 현재유저 수
		
	}
	
	@Override
	public void chatClose(HttpServletRequest request, Model model) {
		// 파라미터
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		chatMapper.deleteUserByChat(userNo);
	}
	
	@Override
	public void chatCheckPw(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
		String roomPw = request.getParameter("roomPw");
		String chatRoomId = request.getParameter("chatRoomId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatRoomId", chatRoomId);
		map.put("roomPw", roomPw);
		
		ChatRoomDTO chatRoom = chatMapper.selectMatchChatRoomByPw(map);
		
		// 채팅방 번호와 비밀번호가 맞다면 들어가기
		if(chatRoom != null) {
			try {
				response.sendRedirect("/chat/chatRoom?chatRoomId=" + chatRoom.getChatRoomId());
			} catch(IOException e) {
				e.printStackTrace();
			}
		} else {
			// 비밀번호가 맞지않을때 응답
			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('비밀번호가 일치하지 않습니다.');");
				out.println("event.preventDefult();");
				response.sendRedirect("/chat/chatRoom/lock?chatRoomId=" + chatRoomId);
				out.println("</script>");
				out.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}
	
	@Override
	public List<ChatUserDTO> getChatUserList() {
		return chatMapper.selectUserListByChat();
	}
	
	@Override
	public void removeChatRoom(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
		int chatRoomId = Integer.parseInt(request.getParameter("chatRoomId"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatRoomId", chatRoomId);
		
		int removeResult = chatMapper.deleteChatRoom(map);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(removeResult > 0) {
				out.println("<script>");
				out.println("location.href='/chat/chatList'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('[오류] 채팅방 삭제를 완료하지 못했습니다. 다시 시도해 주세요.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
