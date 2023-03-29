<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../layout/header.jsp">
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
   		padding-bottom: 20px;
   		margin-top: 30%;
	}
	
	.input_pw {
		margin-top: 10px;
	}
	
	.input_pw:focus {
		border: 2px solid #8c8cff;
		border-radius: 4px;
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
    	margin-bottom: 19px;
    	margin-left: 10px;
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

	


</style>

<script>

	$('#frm_submit').submit(function(){
		if($('#qnaPw').val() == ''){
			alert('비밀번호를 입력해 주세요.');
			event.preventDefault();
			$('#qnaPw').focus();
			return; 
		}
	});
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	<div class="first_div">
		<div class="div_form">
			<form id="frm_submit" action="/qna/lock/checkPW" method="post">
				<input type="hidden" name="qnaNo" value="${qnaNo}">
				<input class="input_pw" type="password" maxlength="4" id="qnaPw" name="qnaPw" placeholder="비밀번호를 입력해주세요."  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				<span><button class="btn purple" id="btn_check">확인</button></span>
			</form>
		</div>
	</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>