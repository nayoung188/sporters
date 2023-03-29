<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>

	.wrap {
		font-family: 'Noto Sans KR', sans-serif;
	}

	/* 버튼 */
	.div_btns{
		padding-top: 26px;
	    padding-bottom: 100px;
	    text-align: right;
	}

	.btn {
	  	position: relative;
		display: inline-block;
		text-align: center;
	    height: 30px;
	    border: none;
	    font-size: 14px;
	    color: white;
	    background-color: #c8c8ff;
	    border-radius: 4px;
    
	}
	.btn:active {
	  top: 4px; 
	}
	
	.btn.purple {box-shadow:0px 4px 0px #b6b6f3;}
	.btn.purple:active {box-shadow: 0 0 #b6b6f3; background-color: #c8c8ff;}
	
	.rounded {
	  border-radius: 10px;
	}
	
	.btn.purple, .btn-two.purple {background-color: #c8c8ff;}
	
	/* 헤더 */
		
	.mapage_div { 
	position: relative; 
	font-size: 32px; 
	font-weight: bold; 
	text-align: center; 
	margin-bottom: 40px;
	}
	
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
	
	
	/* 본문 */
	.first_div {
		width: 70%;
		margin: auto;
	}
	
	.div_form {
		margin: auto;
   		width: 75%;
	}
	
	.div_topic {
		display:inline-block;
		border: 1px solid;
		background-color: #c8c8ff;
		border-radius: 20px;
		color: white;
        height: 35px;
	    width: 38%;
	    font-size: 15px;
	    text-align: center;
	    margin-bottom: 30px;
	    line-height: 35px;
	    margin-top: 20px;
	}
	
	.div_result {
		display:inline-block;
		font-size: 15px;
		border: none;
		border-bottom: 1px solid #8282ff;
		width: 58%;
   		margin-left: 6px;
		height: 0;
		line-height: 35px;
		margin-bottom: 5px;
		padding-bottom: 10px;
    	padding-left: 7px;
	}
	
	.msg_class {
	    font-size: 12px;
	    color: lightgray;
	    position: absolute;
	    margin: auto;
	    margin-left: -30%;
    	margin-top: 63px;
	}
	
	.input_pw {
		height: 30px;
	}


</style>

<script>
	
	$(function(){		
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_pwSubmit();
		fn_cancel();
	});
	
	var pwPass = false;
	var rePwPass = false;
	
	function fn_pwCheck() {
		$('#pw').keyup(function(){
			let pwValue = $(this).val();
			let regPw = /^[0-9a-zA-Z!@#$%^&*]{6,20}$/;
			let validatePw = /[0-9]/.test(pwValue)        // 숫자가 있으면 true, 없으면 false
			               + /[a-z]/.test(pwValue)        // 소문자가 있으면 true, 없으면 false
			               + /[A-Z]/.test(pwValue)        // 대문자가 있으면 true, 없으면 false
			               + /[!@#$%^&*]/.test(pwValue);  // 특수문자8종이 있으면 true, 없으면 false
			if(regPw.test(pwValue) == false || validatePw < 3){
				$('#msg_pw').text('6~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
				pwPass = false;
			} else {
				$('#msg_pw').text('사용 가능한 비밀번호입니다.');
				pwPass = true;
			}
		});
	}
	
	function fn_pwCheckAgain(){
		$('#re_pw').keyup(function(){
			let rePwValue = $(this).val();
			if(rePwValue != '' && rePwValue != $('#pw').val()){
				$('#msg_re_pw').text('비밀번호를 확인하세요.');
				rePwPass = false;
			} else {
				$('#msg_re_pw').text('비밀번호가 일치합니다.');
				rePwPass = true;
			}
		});
	}
	
	function fn_pwSubmit(){
		$('#frm_edit_pw').submit(function(event){
			if(pwPass == false || rePwPass == false){
				alert('비밀번호 입력을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	function fn_cancel(){
		$('#btn_cancel').click(function(){
			history.back();
		});
	}

	
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			<div class="mapage_div"> 비밀번호 변경 </div>
			
			<div class="div_form" id="modify_pw_area">
				<form id="frm_edit_pw" action="/users/modify/pw" method="post">
					<div class="div_in_form">
						<label class="div_topic" for="pw">새로운 비밀번호</label>
						<input class="div_result input_pw" type="password" name="pw" id="pw">
						<span class="msg_class" id="msg_pw"></span>					
					</div>
					<div class="div_in_form">
						<label class="div_topic" for="re_pw">새로운 비밀번호 확인</label>
						<input class="div_result input_pw" type="password" id="re_pw">
						<span class="msg_class" id="msg_re_pw"></span>
					</div>
					<div class="div_btns">
						<button class="btn purple">변경하기</button>
						<input class="btn purple" type="button" value="취소하기" id="btn_cancel">
					</div>
				</form>
			</div>

		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>