<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sporters - 실시간 채팅</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
	<script>
	
	$(function(){
		fn_getUserList();
		fn_keyup_chat_event();
	});
	

	// 채팅창 close할때 유저 DB에서 삭제
	$(window).on('unload', function() {
		$.ajax({
			type : 'POST',
			url : '/chat/close',
			data : $('#frm').serialize()
		});

	});
	
	function fn_keyup_chat_event() {
		$('#message').on('keyup', function() {
			if($(this).val() != '') {
				$(this).next().css('backgroundColor', '#FF9696')
			} else {
				$(this).next().css('backgroundColor', '#FFE6E6')
			}
		});
	}
	
	function fn_getUserList() {
		$.ajax({
			type: 'get',
			url : '/chat/userList',
			dataType : 'json',
			success : function(resData) {
				$('#userList').empty();
				$.each(resData, function(i, data){
					$('<li class="user_list"><i class="fa-solid fa-user"></i> <a class="users" href="/users/userInfo?id=' + data.user.id + '">').text(data.user.nickname)
					 	.appendTo('#userList');
				});
			}
		});
	}
	
	// 유저가 0명일 때 해당 채팅방 삭제
/* 	$('#currUserCnt').on('change', function() {
		if($('#currUserCnt').val() == 0) {
			alert($('#chatRoomId').val());
			location.href='/chat/deleteChatRoom?chatRoomId=' + $('#chatRoomId').val();
		}
	}); */
	
	// 채팅 입력 버튼 활성화
	
</script>
<style>
	* {
		box-sizing: border-box;
	}
	.wrap {
		width: 640px;
		display: inline-block;
	}
	.user_wrap {
        width: 200px;
	    height: 460px;
	    display: inline-block;
	    vertical-align: top;
	    margin-top: 0px;
	    border: 2px solid #c8c8ff;
	    border-radius: 10px;
	    padding: 10px;
        margin-left: 10px;
	}
	
	.mapage_div { position: relative; }

	.mapage_div:before,
	.mapage_div:after {
	  content: '[';
	  display: inline-block;
	  position: relative;
	  top: 1px;
	  height: 5%;
	  font-size: 1.25em;
	  color: #8282ff;
	  transition: all 0.5s ease;
	}
	
	.mapage_div:after { content: ']'; }
	
	.mapage_div:hover:before { 
	  transform: translateX(-5px);
	}
	
	.mapage_div:hover:after { 
	  transform: translateX(5px);
	}
	
	ul {
		list-style: none;
		padding-left: 0px;
	    color: #000;
	    font-size: 15px;
	}
	.user_list_title {
		
	}
	
	.btn {
		width: 60px;
	}
	.talking_content {
		width: 640px;
		height: 377px;
		overflow-y: scroll;
		background-color: #fff;
	}
	.message_area {
		height:80px;
	}
	.message {
		width: 528px;
		height: 80px;
		display: inline-block;
		resize: none;
		background-color: rgb(239, 239, 239);
		outline: none;
		margin-top: 3px;
		border-radius: 3px;
		padding: 5px;
		border:none;
	}
	.message_area > * {
		vertical-align: top;
	}
	#btn_send {
	    height: 80px;
	    width: 105px;
	    margin-top: 3px;
	    background-color: #FFE6E6;
	    border: none;
	    border-radius: 3px;
	    color: #fff;
	}
	.talking_content {
		position: relative;
	    padding: 5px;
	    border-radius: 4px;
	    background-color: rgb(242, 242, 255);
	}
	.talking_content::-webkit-scrollbar {
	    display: none;
	}
	.small_text {
		font-size: 12px;
		text-align: left;
	}
	.my_message, .other_message {
		margin-bottom: 5px;
	}
	.my_message {
		text-align: right;
	}
	.other_message {
		text-align: left;
	}
	.my_message_content, .other_message_content {
		display: inline-block;
		max-width: 48%;
		border-radius: 3px;
		width: 263px;
	}
	.my_message_content {
		text-align: right;
		color:#fff;
		background-color: #8282FF;
	    padding: 8px;
	}
	.other_message_content {
		text-align: left;
		background-color: #C8C8FF;
		padding: 5px;
	}
	/* chat no */
	.chat_no {
	    background-color: #8c8cff;
	    border-radius: 5px;
	    padding: 5px;
	    color: #fff;
	}
	.chat_title {
	    padding: 5px;
	    font-weight: 900;
	    margin-left: 10px;
	}
	.currUserCnt {
	    margin-left: 777px
	}
	
	.chat_content_wrap {
	    margin-top: 22px;
    	margin-left: 12px;
	}
</style>
</head>
<body>
	<form id="frm">
		<input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
		<input type="hidden" id="gender" value="${user.gender}">
		<input type="hidden" id="id" name="nickname" value="${user.nickname}">
	</form>
		<input type="hidden" id="currUserCnt" value="${currUserCnt}">
		<input type="hidden" id="chatRoomId" value="${chatRoom.chatRoomId}">
	<div>
		<span class="chat_no">채팅방 번호 ${chatRoom.chatRoomId}</span><span class="chat_title">${chatRoom.chatRoomTitle}</span>
		<span class="currUserCnt">${currUserCnt} / ${chatRoom.maxUsersCnt}</span>
	</div>
<hr>
	<div class="chat_content_wrap">
		<div class="user_wrap">
			<div id="title_wrap">
				<div class="mapage_div" style="font-size: 15px; font-weight: bold; text-align: center;"> 현재 접속 유저 </div>
			</div>
			<div>
				<ul id="userList">
				</ul>
			</div>
		</div>
		<div class="wrap">
			<div id="talking_content" class="talking_content">
			</div>
			
			<div class="message_area">
				<textarea class="message" id="message" wrap="hard"></textarea>
				<input type="button" value="전송" class="btn" id="btn_send">
			</div>
		</div>
	</div>

	
	<script>

		$(function(){
			fn_send();
			fn_socketOn();
		});
		// socket on
		
		var ws;  // ChatServer
		var sendData = {};  // CharServer로 전송할 데이터는 JSON 형식

		// ChatServer로 메시지 보내는 함수
		function fn_send() {
			if($('#message').val().trim() != '') {
				sendData.id = $('#id').val();  // 작성자
				sendData.gender = $('#gender').val(); // 성별
				sendData.message = $('#message').val();  // 메시지
				sendData.date = new Date().toLocaleTimeString();  // 날짜
				ws.send(JSON.stringify(sendData));  // CharServer로 전송
			}
			$('#message').val('');
		}
	
		$('#after_login').hide();
		
		//채팅창에서 나갔을 때
		function onClose(evt) {
			
			var user = $('#id').val();
			var str = user + " 님이 퇴장하셨습니다.";
			
			$("#msgArea").append(str);
		}
		//채팅창에 들어왔을 때
		function onOpen(evt) {
			
			var user = $('#id').val();
			var str = user + "님이 입장하셨습니다.";
			
			$("#msgArea").append(str);
		}
		
		function fn_socketOn() {
			// ChatServer와 연결
			var url = 'ws://' + location.host + '/chatserver';  // ws://localhost:9090/app16/chatserver 요청하면 ChatServer.java가 동작함
			ws = new WebSocket(url);
			
			// ChatServer에서 메시지가 도착하면 동작
			ws.onmessage = function(message) {
				
				var data = JSON.parse(message.data);
				
				if(data.id == $('#id').val()) {
					text = '<div class="my_message"><div class="my_message_content">';
				} else {
					text = '<div class="other_message"><div class="other_message_content">';
				}
				text += '<div class="small_text">'
				text += '<strong>' + data.id + '</strong>&nbsp;<span>' + data.gender + '</span> ';
				text += '(' + data.date + ')';
				text += '</div>';
				text += '<pre style="white-space: pre-wrap;">' + data.message + '</pre>';
				text += '</div>';
				text += '</div>';
				
				$('#talking_content').append(text);  // 대화내용 추가하기
				$('#talking_content').scrollTop($('#talking_content').prop('scrollHeight'));  // 대화가 쌓이면 스크롤 내려주기
				
			};
			
			ws.onerror = function(error) {
			};
		}
		
		
		
		$('#message').keyup(function(event){
			if(event.keyCode == 13 && !event.shiftKey) {  // keyCode가 13인 키는 Enter이므로 Enter를 눌렀다는 의미, Shift+Enter는 textarea에서 줄 바꿀 때 사용하므로 제외해야 함
				fn_send();
			}
		});
		
		$('#btn_send').click(function(){
			fn_send();
		});
		

	</script>
</body>
</html>