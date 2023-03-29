<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
.align {
  display: grid;
  place-items: center;
}

/* helpers/icon.css */

.icon {
  font-size: 2rem;
}

/* layout/base.css */

.align {
  color: #888;
  font-family: sans-serif;
  line-height: 1.5;
  margin: 0;
  min-height: 50vh;
}

/* modules/headline.css */

h3 {
  font-size: 1.1rem;
    margin-top: 1.5em;
    color: #111;
}


/* modules/form.css */

input {
  font: inherit;
  outline: 0;
}

.form_field {
  position: relative;
}

.form_field .icon {
  position: absolute;
  right: 1em;
  top: 50%;
  transform: translateY(-50%)
}

.form_input {
  border-radius: 0.55em;
    border-style: solid;
    border-width: 2px;
    font-size: 1.5rem;
    padding: 0.1em 3em 0.3em 2em;
}

.form_input:valid {
  border-color: #1E82FF;
}

.form_input:valid + .icon::after {
  content: '😃';
}

.form_input:invalid {
  border-color: #c8c8ff;
}

.form_input:invalid + .icon::after {
  content: '😳';
}

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





</style>
<script>
	
	$(function(){
		$('#btn_check_pw').click(function(){
			$.ajax({
				type: 'post',
				url: '/users/check/pw',
				data: 'pw=' + $('#pw').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						location.href = '/users/modify/pw';
					} else {
						alert('비밀번호를 확인하세요.');
					}
				}
			});
		});
	});
	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="align">
		
			<h3>회원의 정보를 안전하게 보호하기 위해서 비밀번호를 확인합니다.</h3>
			
			<div>
				<input style="vertical-align: middle;" class="form_input" type="password" id="pw" required>
				<span style="vertical-align: middle;" class="icon"></span>
			</div>
			
			<div class="div_btns">
				<input class="btn purple" type="button" value="확인" id="btn_check_pw">
				<input class="btn purple" type="button" value="취소" onclick="history.back()">
			</div>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>