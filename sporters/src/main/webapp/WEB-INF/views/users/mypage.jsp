<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>

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

	.btn.purple, .btn-two.purple {background-color: #c8c8ff;}
	
	/* 헤더 */
		
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
	
	
	/* 본문 */
	
	.first_div {
		width: 60%;
		margin: auto;
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	.div_form {
		margin: auto;
   		width: 75%;
	}
	
	.div_topic {
		display:inline-block;
		border: 1px solid;
		border-radius: 20px;
		color: #8282ff;
	    height: 35px;
	    width: 24%;
	    font-size: 15px;
	    text-align: center;
	    margin-bottom: 30px;
	    line-height: 35px;
	}
	
	.div_result {
		display:inline-block;
		font-size: 15px;
		border-bottom: 1px solid #8282ff;
		width: 70%;
   		margin-left: 10px;
		height: 24px;
		line-height: 35px;
		margin-bottom: 30px;
		padding-bottom: 10px;
    	padding-left: 7px;
	}
	
</style>

<script>
	$(function(){
		fn_goodAndHate();
	});
	
	function fn_goodAndHate(){
		$.ajax({
			url: '/heart/likeNhate',
			type: 'get',
			data: 'userNo=' + $('#userNo').val(),
			dataType: 'json',
			success: function(resData){
				
				console.log(resData.result);
				$('#good_hate_count').empty();
				$('#good_hate_count').text(resData.result);
				console.log(resData.result);
			}
		});
	}
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			<div class="mapage_div" style="font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 40px;"> MY PAGE </div>
				
				<div style="height: 20px;"></div>
				
				<div class="div_form">
					<input type="hidden" value="${loginUser.userNo}" id="userNo">
					<form id="frm_info" action="/users/info" method="post">
						<div>
							<span class="div_topic">아이디</span>
							<span class="div_result">${loginUser.id}</span>
						</div>
						<div>
							<span class="div_topic">닉네임</span>
							<span class="div_result">${loginUser.nickname}</span>
						</div>
						<div>
							<span class="div_topic">이름</span>
							<span class="div_result">${loginUser.name}</span>
						</div>
						<div>
							<span class="div_topic">이메일 주소</span>
							<span class="div_result">${loginUser.email}</span>
						</div>
						<div>
							<span class="div_topic">호감도</span>
							<span class="div_result" id="good_hate_count"></span>
						</div>
						<div>
							<span class="div_topic">가입일</span>
							<span class="div_result">${loginUser.joinDate}</span>
						</div>
					</form>
				</div>
				
				<div style="border-bottom: 1px solid lightgray; height: 20px;"></div>
				
				<div class="div_btns" style="text-align: right;">
					<input class="btn purple" type="button" value="회원정보 변경" onclick="location.href='/users/check/form_info'">
					<input class="btn purple" type="button" value="비밀번호 변경" onclick="location.href='/users/check/form_pw'">
					<input class="btn purple" type="button" value="탈퇴" onclick="location.href='/users/check/form_withdraw'">
				</div>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>