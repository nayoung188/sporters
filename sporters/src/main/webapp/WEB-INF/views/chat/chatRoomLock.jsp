<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sporters - 실시간 채팅</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<style>
	#wrap {
		text-align: center;
		margin-top: 280px;
	}
	
	#roomPw {
	    width: 400px;
	    height: 40px;
	    padding-left: 10px;
	    margin-right: 5px;
	    border: none;
	    outline: none;
	    padding-bottom: 0px;
	    border-bottom: 2px solid #C8C8FF;
	    font-size: 30px;
	}
	
	#roomPw::placeholder {
		font-size: 15px;
	}
	
	.in_buttons {
		position: relative;
		display: inline-block;
		text-align: center;
		width:100px;
	    height: 30px;
	    border: none;
	    font-size: 14px;
	    color: white;
	    background-color: #FFB6C1;
	    border-radius: 4px;
	    margin-bottom: 4px;
	}
	
	.in_buttons:active {
		top: 4px; 
	}
		
	.in_buttons.purple {box-shadow:0px 4px 0px #b6b6f3;}
	.in_buttons.purple:active {box-shadow: 0 0 #c8c8ff; background-color: #c8c8ff;}
	
	.in_buttons.purple, .btn-two.purple {background-color: #c8c8ff;}
</style>
</head>
<body>
<script>
	$('#frm_submit').submit(function(){
		if($('#roomPw').val() == ''){
			alert('비밀번호를 입력해 주세요.');
			event.preventDefault();
			$('#roomPw').focus();
			return; 
		}
	});
</script>
<div id="wrap">
	<form id="frm_submit" action="/chat/chatRoom/lock/comfirm" method="post">
		<input type="hidden" name="chatRoomId" value="${chatRoomId}">
		<input type="password" maxlength="4" id="roomPw" name="roomPw" placeholder="비밀번호를 입력해주세요." oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
		<button class="in_buttons purple">입장</button>
	</form>
</div>


</body>
</html>