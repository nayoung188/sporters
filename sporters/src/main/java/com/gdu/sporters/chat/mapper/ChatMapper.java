package com.gdu.sporters.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.chat.domain.ChatRoomDTO;
import com.gdu.sporters.chat.domain.ChatUserDTO;
import com.gdu.sporters.users.domain.UsersDTO;

@Mapper
public interface ChatMapper {
	
	// chat List Cnt
	public int selectChatRoomCnt();
	// chat User Cnt
	public int selectChatUserCnt(Map<String, Object> map);
	
	// chat List
	public List<ChatRoomDTO> selectChatRoomListByMap(Map<String, Object> map);
	
	// chat List By No
	public ChatRoomDTO selectChatRoomByNo(Map<String, Object> map);
	public ChatRoomDTO selectChatRoomByDTO(ChatRoomDTO chatRoom);
	
	// insert chat List
	public int insertChatRoom(ChatRoomDTO chatRoom);
	public int insertChatRoomInPw(ChatRoomDTO chatRoom);
	
	// insert chat User
	public int insertChatUser(Map<String, Object> map);
	
	// delete chat User
	public int deleteUserByChat(int userNo);
	
	// select chat User (자기자신)
	public UsersDTO selectUserByChat(int userNo);
	
	// select chat UserList (리스트)
	public List<ChatUserDTO> selectUserListByChat(); // 리스트 띄우는 용
	public List<ChatUserDTO> selectUserListByChatUserNo(Map<String, Object> map); // 유저검색
	
	// 채팅방 비밀번호 매치
	public ChatRoomDTO selectMatchChatRoomByPw(Map<String, Object> map);
	
	// 채팅방 삭제
	public int deleteChatRoom(Map<String, Object> map);
	
}
