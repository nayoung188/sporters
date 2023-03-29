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
	    text-align: center;
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
	
	h3 {
	  top: 1px;
	  height: 5%;
	  font-size: 1.25em;
	  text-align: center;
	}
	
	
</style>

<script>
	
	$(function(){
		fn_withdraw();
	});
	
	function fn_withdraw(){
		$('#btn_withdraw').click(function(){
			if($('#pw').val() == ''){
				alert('비밀번호를 입력해 주세요.');
				event.preventDefault();
			} else if ($('#pw').val() == ${loginUser.pw}){
				if(confirm('동일한 아이디로 재가입이 불가능합니다. 회원 탈퇴하시겠습니까?')){
					$('#lnk_withdraw').submit();
				}				
			}
		});
	}
	
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div>
			<h3> 탈퇴한 아이디는 사용할 수 없게 됩니다. <br> 탈퇴를 진행하시겠습니까?</h3>

			<div class="div_btns">
				<input class="btn purple" type="button" id="btn_withdraw" value="탈퇴하기"></input>
				<input class="btn purple" type="button" value="돌아가기" onclick="location.href='/users/mypage'">
			</div>
			<form id="lnk_withdraw" action="/users/withdraw" method="post"></form>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>