package com.gdu.sporters.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.gdu.sporters.chat.handler.MyTextWebSocketHandler;

@EnableWebSocket  // 웹소켓 사용을 허용
@Configuration
public class WebSocketConfig implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new MyTextWebSocketHandler(), "/chatserver")  // WebSocket을 활성화하는 매핑 정보(HandShaking(악수)할 매핑)
			.setAllowedOrigins("*");  // CORS(Cross-Origin Resource Sharing) 설정, 스프링은 same-origin만 허용
	}
	
}