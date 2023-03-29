<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
	* {
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	.first_div {
		width: 60%;
		margin: auto;
	}
	
	.div_form {
		margin: auto;
   		width: 75%;
   		position: relative;
	}
	
	/* 버튼 */
	.div_btns{
	    text-align: right;
        margin-bottom: 10%;
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
	.div_topic {
		display:inline-block;
		border: 1px solid;
		border-radius: 20px;
		color: #8282ff;
	    height: 35px;
	    width: 24%;
	    font-size: 15px;
	    text-align: center;
	    margin-bottom: 10px;
	    line-height: 35px;
	}
	
	.div_input {
		display:inline-block;
		font-size: 15px;
		border-bottom: 1px solid #8282ff;
		height: 24px;
		margin-bottom: 30px;
		padding-bottom: 10px;
    	padding-left: 7px;
    	width: 30vw;
	}
	
	input {
		border: none;
		margin-top: 10px;
	}
	
	.div_box{
		margin-top: 10%;
	}
	
	.msg_class {
	    font-size: 12px;
	    color: lightgray;
	    position: absolute;
	    bottom: 22%;
	}
	
	.msg_result {
		margin-top: 10px;
	}

	
</style>

<script>
	
	$(document).ready(function(){
		fn_findPw();
	});
	
	function fn_findPw(){
		$('#btn_findPw').click(function(){
			new Promise(function(resolve, reject){
				if($('#id').val() == '' || $('#email').val() == ''){
					reject('아이디와 이메일을 입력하세요!');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/users/findPw',
					contentType: 'application/json',
					data: JSON.stringify({
						'id': $('#id').val(),
						'email': $('#email').val() 
					}),
					dataType: 'json',
					success: function(resData){
						if(resData.findUser != null){
							resolve(resData.findUser);
						} else {
							reject('일치하는 회원 정보가 없습니다.');
						}
					}
				});
			}).then(function(findUser){
				$.ajax({
					type: 'post',
					url: '/users/sendTemporaryPassword',
					data: 'userNo=' + findUser.userNo + "&email=" + findUser.email,
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess){
							alert('등록된 이메일로 임시 비밀번호가 발송되었습니다.\n발송된 임시 비밀번호로 로그인 후 비밀번호를 변경하세요.');
							location.href = '/users/login/form';
						}
					}
				});
			}).catch(function(msg){
				alert(msg);
			});
		});
	}
	
	
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			
			<div class="div_form">
			<div class="mapage_div"> 🔍 비밀번호 찾기 </div>
			
			<div class="div_box">
				<label class="div_topic" for="id">
					아이디
				</label>
				<br>
				<input class="div_input" type="text" name="id" id="id">
			</div>
			
			<div>
				<label class="div_topic" for="email">
					이메일
				</label>
				<br>
				<input class="div_input" type="text" name="email" id="email" style="margin-bottom: -3px;">
			</div>
			<div class="div_btns">
				<input class="btn purple" type="button" value="임시 비밀번호 발급받기" id="btn_findPw">
			</div>
			
			<div style="text-align: right; margin-bottom: 10px;">
				<input class="btn purple" type="button" value="로그인" onclick="location.href='/users/login/form'">
				<input class="btn purple" type="button" value="회원가입" onclick="location.href='/users/agree/form'">
				<input class="btn purple" type="button" value="아이디찾기" onclick="location.href='/users/findId/form'">
			</div>
			
			</div>
			
			<div style="border-bottom: 1px dotted #8c8cff; height: 10px;"></div>
			
			<div class="msg_result" id="msg_result"></div>
			
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>