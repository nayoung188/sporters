package com.gdu.sporters.chat.handler;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyTextWebSocketHandler extends TextWebSocketHandler {
	// 현재 채팅 서버에 접속한 클라이언트(WebSocketSession Session) 목록 - HttpSession 아님 주의
	private final Set<WebSocketSession> clientList = ConcurrentHashMap.newKeySet();
	
	// init-method
	public void init() throws Exception{
						
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {  // 클라이언트가 접속할 때 동작, '/chatserver'로 접속하면 가장 먼저 실행됨
		clientList.add(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {  // 클라이언트가 브라우저를 종료하거나 URL을 변경하거나 새로고침하면 자동으로 동작함
		clientList.remove(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {  // 클라이언트가 메시지를 보내면 clientList에 있는 모든 Session(접속된 모든 클라이언트)에 메시지가 전달됨
		String payload = message.getPayload();
		for(WebSocketSession ws : clientList) {
			ws.sendMessage(new TextMessage(payload));
		}
	}
}
