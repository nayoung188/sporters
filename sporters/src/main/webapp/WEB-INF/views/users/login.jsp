
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>

	#frm_login{
	    margin-left: 60%;
	    margin-top: 17%;
	    width: 100%;
	}

	#login {
		width: 100%;
	    height: 30px;
	    border: none;
	    font-size: 14px;
	    color: white;
	    background-color: c8c8ff;
	}
	
	.div_find {
		text-align: center;
	    padding-top: 15px;
	    font-size: 14px;
	}
	
	.sign_up_a_tag {
		color: #aaa8a8;
	}
		
	.menu a {
	    color: #7878ff;
	    font-family: Lato;
	    font-size: 10pt;
	    padding: 14px 20px;
	    position: relative;
	    display: block;
	    text-decoration: none;
	    text-transform: uppercase;
	    width: 100%;  
	}
	
	.text-center {
		display: flex;
    	justify-content: space-evenly;
	}
	
	
	.SMN_effect-20 a {
	  transition: 0.35s;
	}
	
	.SMN_effect-20 a:hover {
	  color: #8c8cff;
	  transition: 0.35s;
	}
	
	.SMN_effect-20 a:before, .SMN_effect-20 a:after {
	  content: "";
	  width: 100%;
	  border-bottom: 2px solid #c8c8ff;;
	  position: absolute;
	  bottom: 0;
	  left: 0;
	  opacity: 1;
	  transform: scale(1, 1);
	  transform-origin: right center 0;
	}
	
	.SMN_effect-20 a:after {
	  opacity: 0;
	  transform: scale(0, 1);
	  transform-origin: left center 0;
	}
	
	.SMN_effect-20 a:hover:before {
	  opacity: 0;
	  transform: scale(0, 1);
	  transition: opacity 0.2s ease-in-out 0.2s, transform 0.2s ease-in-out 0s;
	}
	
	.SMN_effect-20 a:hover:after {
	  opacity: 1;
	  transform: scale(1, 1);
	  transition: transform 0.2s ease-in-out 0.25s;
	}
	
	.a_span_class {
		display: inline-block;
	}
	
	.btn {
	  position: relative;
	  border: 0;

	  display: inline-block;
	  text-align: center;
	  color: white;
	}
	.btn:active {
	  top: 4px; 
	}
	
	.btn.purple {box-shadow:0px 4px 0px #b6b6f3;}
	.btn.purple:active {box-shadow: 0 0 #BA8CB5; background-color: #BA8CB5;}
	
	.rounded {
	  border-radius: 10px;
	}
	
	.btn.purple, .btn-two.purple {background-color: #cb99c5;}
	
	:root {
	    --primary-color: #c8c8ff;
	    --secondary-color: #8c8cff;
	    --black: #000000;
	    --white: #ffffff;
	    --gray: #efefef;
	    --gray-2: #757575;
    }
    
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap');
    
    * {
	    font-family: 'Poppins', sans-serif;
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	}
	
	html, body {
    height: 100vh;
    overflow: hidden;
	}
	
		
	.container {
	    position: relative;
	    min-height: 100vh;
	    overflow: hidden;
	    font-family: 'Noto Sans KR', sans-serif;
	}
	
	.row {
	    display: flex;
	    flex-wrap: wrap;
	    height: 100vh;
	 
	}
	
	.col {
	    width: 60%;
	    min-width: 60%;
	}
	
	.align-items-center {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    text-align: center;
	    flex-wrap: nowrap;
	}
	
	.form-wrapper {
	    width: 100%;
	    max-width: 28rem;
	}
	
	.form {
	    padding: 1rem;
	    background-color: var(--white);
	    border-radius: 1.5rem;
	    width: 100%;
	    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
	    /*
	    transform: scale(0);
	    transition: .5s ease-in-out;
	    transition-delay: 1s;
	    */
	}
	
	.input-group {
	    position: relative;
	    width: 100%;
	    margin: 1rem 0;
	}
	
	.input-group i {
	    position: absolute;
	    top: 50%;
	    left: 1rem;
	    transform: translateY(-50%);
	    font-size: 1.4rem;
	    color: var(--gray-2);
	}
	
	.input-group input {
	    width: 100%;
	    padding: 1rem 2rem;
	    font-size: 1rem;
	    background-color: var(--gray);
	    border-radius: .5rem;
	    border: 0.125rem solid var(--white);
	    outline: none;
	}
	
	.input-group input:focus {
	    border: 0.125rem solid var(--primary-color);
	}
	
	/*
	.form .button {
	    cursor: pointer;
	    width: 100%;
	    padding: .9rem 0;
	    border-radius: .5rem;
	    border: none;
	    background-color: var(--primary-color);
	    color: var(--white);
	    font-size: 1.2rem;
	    outline: none;
	}
	*/
	.form p {
	    margin: 0.8rem 0;
	    font-size: .7rem;
	    text-align: left;
	}
	
	.flex-col {
	    flex-direction: column;
	}
	
	.pointer {
	    cursor: pointer;
	}
	
	.container.sign-in .form.sign-in,
	.container.sign-in .social-list.sign-in,
	.container.sign-in .social-list.sign-in>div,{
	    transform: scale(1);
	}
	
	.content-row {
	    position: absolute;
	    top: 0;
	    left: 0;
	    pointer-events: none;
	    z-index: 6;
	    width: 100%;
	}
	
	.text {
	    margin: 4rem;
	    color: var(--white);
	}
	
	.text h2 {
	    font-size: 3.5rem;
	    font-weight: 800;
	    margin: 2rem 0;
	    transition: 1s ease-in-out;
	}
	
	.text p {
	    font-weight: 600;
	    transition: 1s ease-in-out;
	    transition-delay: .2s;
	}
	
	.img img {
	    width: 30vw;
	    transition: 1s ease-in-out;
	    transition-delay: .4s;
	}
	
	.text.sign-in h2,
	.text.sign-in p,
	.img.sign-in img {
	    transform: translateX(-250%);
	}
	
	
	.container.sign-in .text.sign-in h2,
	.container.sign-in .text.sign-in p,
	.container.sign-in .img.sign-in img{
	    transform: translateX(0);
	}
	
	.container.sign-in .text.sign-in h2,
	.container.sign-in .text.sign-in p,
	.container.sign-in .img.sign-in img,
	.container.sign-up .text.sign-up h2,
	.container.sign-up .text.sign-up p,
	.container.sign-up .img.sign-up img {
	    transform: translateX(0);
	}
	
	/* BACKGROUND */
	
	.container::before {
	    content: "";
	    position: absolute;
	    top: 0;
	    right: 0;
	    height: 100vh;
	    width: 300vw;
	    transform: translate(35%, 0);
	    background-image: linear-gradient(-45deg, var(--primary-color) 0%, var(--secondary-color) 100%);
	    transition: 1s ease-in-out;
	    z-index: 6;
	    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
	    border-bottom-right-radius: max(50vw, 50vh);
	    border-top-left-radius: max(50vw, 50vh);
	}
	
	.container.sign-in::before {
	    transform: translate(0, 0);
	    right: 50%;
	}
	

/* RESPONSIVE */

@media only screen and (max-width: 425px) {

    .container::before,
    .container.sign-in::before {
        height: 100vh;
        border-bottom-right-radius: 0;
        border-top-left-radius: 0;
        z-index: 0;
        transform: none;
        right: 0;
    }

    .container.sign-in .col.sign-in{
        transform: translateY(0);
    }

    .content-row {
        align-items: flex-start !important;
    }

    .content-row .col {
        transform: translateY(0);
        background-color: unset;
    }

    .col {
        width: 100%;
        position: absolute;
        padding: 2rem;
        background-color: var(--white);
        border-top-left-radius: 2rem;
        border-top-right-radius: 2rem;
        transform: translateY(100%);
        transition: 1s ease-in-out;
    }

    .row {
        align-items: flex-end;
        justify-content: flex-end;
   
    }

    .form{
        box-shadow: none;
        margin: 0;
        padding: 0;
    }

    .text {
        margin: 0;
    }

/*
    .text p {
        display: none;
    }
*/
    .text h2 {
        margin: .5rem;
        font-size: 2rem;
    }
    
    
	
    

</style>
<script>
	$(function(){
		fn_login();
		fn_showRememberId();
		fn_btnLogin();
		fn_ganzi();	
		$('.sign_up_a_tag').hover(function(){
	        $(this).text("지금 바로 가입하세요!")
	    }, function() {
	        $(this).text("계정이 없으신가요?")
	    });
	});

	
	function fn_login(){
		$('#frm_login').submit(function(event){
			if($('#id').val() == '' || $('#pw').val() == ''){
				alert('아이디와 비번을 모두 입력해주세요!');
				event.preventDefault();
				return;
			}
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId',$('#id').val());
			} else {
				$.cookie('rememberId','');
			}
		});
	}
	
	function fn_showRememberId(){
		let rememberId = $.cookie('rememberId');
		if(rememberId == ''){
			$('#id').val('');
			$('#rememberId').prop('checked', false);
		} else {
			$('#id').val(rememberId);
			$('#rememberId').prop('checked', true);
		}
	}
	
	function fn_btnLogin(){
		$('#login').click(function(){
			$('#frm_login').submit();
		});
	}
	
	function fn_ganzi(){
		let container = document.getElementById('container')
		  container.classList.toggle('sign-in')
	}
	

	
</script>
<body>

<div id="container" class="container">
	<c:if test="${loginUser == null}">
		<div class="row">
			<form id="frm_login" action="/users/login" method="post">
				<input type="hidden" name="url" value="${url}">
				<div class="col align-items-center flex-col sign-in">
					<div class="form-wrapper align-items-center">
						<div class="form sign-in">			
							<div class="input-group">
								<i class='bx bxs-user'></i>
								<input type="text" name="id" id="id" placeholder="ID">
							</div>
							
							<div class="input-group">
								<i class='bx bxs-lock-alt'></i>
								<input type="password" name="pw" id="pw" placeholder="PASSWORD">
							</div>
							
							<p style="text-align: right;">
								<b>
									<label for="rememberId">
										<input type="checkbox" id="rememberId">
										아이디 저장
									</label>
									<label for="keepLogin">
										<input type="checkbox" name="keepLogin" value="keep" id="keepLogin">
										로그인 유지
									</label>
								</b>
							</p>
							<div id="btn_login" class="button">
								<input type="button" id="login" value="로그인" class="btn purple rounded">
							</div>
							<div class="back color-3">
								<div class="btn_row btn_columns">
									<div class="menu align-center expanded text-center SMN_effect-20">
										<span class="a_span_class"><a href="/users/findId/form">아이디 찾기</a></span>
										<span class="a_span_class"><a href="/users/findPw/form">비밀번호 찾기</a></span>
									</div>
								</div>
							</div>
							<div style="font-size: 12px; padding-bottom: 17px; padding-top: 15px;">
								<a href="/users/agree/form" class="sign_up_a_tag">계정이 없으신가요?</a>
							</div>
							<div style="text-align: center;">
								<a href="${apiURL}"><img width="48%;" height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
								<a href="javascript:void(0)"><img onclick="kakaoLogin();" width="48%;" height="50" src="https://developers.kakao.com/tool/resource/static/img/button/login/full/ko/kakao_login_medium_narrow.png"/></a>
								<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
								<script>
								Kakao.init('3f14ce0d2a83955ff158089f8735f875'); //javascript키
								console.log(Kakao.isInitialized()); // sdk초기화여부판단
								//카카오로그인
								function kakaoLogin() {
								    Kakao.Auth.login({
								      success: function (response) {
								        Kakao.API.request({
								          url: '/v2/user/me',
								          success: function (response) {
								        	  console.log(response);
								        	  alert('정상적으로 로그인 되었습니다.');
								          },
								          fail: function (error) {
								            console.log(error)
								          },
								        })
								      },
								      fail: function (error) {
								        console.log(error)
								      },
								    })
								  }
								//카카오로그아웃  
								function kakaoLogout() {
								    if (Kakao.Auth.getAccessToken()) {
								      Kakao.API.request({
								        url: '/v1/user/unlink',
								        success: function (response) {
								        	console.log(response)
								        	alert('정상적으로 로그아웃 되었습니다.');
								        },
								        fail: function (error) {
								          console.log(error)
								        },
								      })
								      Kakao.Auth.setAccessToken(undefined)
								    }
								  }  
								</script>		
							</div>				
						</div>
					</div>
				</div>
			</form>
				<div class="row content-row">
			      <!-- SIGN IN CONTENT -->
			      <div class="col align-items-center flex-col">
			        <div class="text sign-in">
			          <h2>
			            SPORTERS
			          </h2>  
			        </div>
		        </div>
	    	</div>
		</div>  <!-- row section -->
	</c:if>
</div>		<!-- connect section -->


</body>
</html>