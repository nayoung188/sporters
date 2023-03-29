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
	
	/* 본문 */
	
	.first_div {
		width: 60%;
		margin: auto;
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

	.btn.purple, .btn-two.purple {background-color: #c8c8ff;}
	
</style>

<script>

</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			<div style="font-size: 32px; font-weight: bold;">❗❗휴면계정안내❗❗</div>
			
			<div>
			<br>
				안녕하세요 <br>
				${sleepUser.sleepUserId}님은 1년 이상 로그인하지 않아 관련 법령에 의해 휴면계정으로 전환되었습니다. <br><br>
				<ul>
					<li>가입일 ▷ ${sleepUser.joinDate}</li>
					<li>마지막 로그인  ▷ ${sleepUser.lastLoginDate}</li>
					<li>휴면계정전환일 ▷ ${sleepUser.sleepDate}</li>
				</ul>
			</div>
			
			<hr>
			
			<div>
				<div> 휴면해제를 위해 아래 버튼을 클릭해주세요 :)</div>
				<form id="frm_comeback" action="/users/comeback" method="post">
					<div class="div_btns">
						<button class="btn purple">휴면해제하기</button>
						<input class="btn purple" type="button" value="취소" onclick="location.href='/'">
					</div>
				</form>
			
			</div>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>