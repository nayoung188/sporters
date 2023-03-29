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
	
	
	/* 라디오 */
	
	[type="radio"] {
	  vertical-align: middle;
	  appearance: none;
	  border: max(2px, 0.1em) solid gray;
	  border-radius: 50%;
	  width: 1.25em;
	  height: 1.25em;
	  transition: border 0.5s ease-in-out;
	}
	[type="radio"]:checked {
	  border: 0.4em solid #5a5aff;
	}
	
	[type="radio"]:focus-visible {
	  outline-offset: max(2px, 0.1em);
	  outline: max(2px, 0.1em) dotted #5a5aff;
	}
	
	[type="radio"]:hover {
	  box-shadow: 0 0 0 max(4px, 0.2em) lightgray;
	  cursor: pointer;
	}
	
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
	
	/* 셀렉트 */
	select {
		  -webkit-appearance: none;
		  -moz-appearance: none;
		  -o-appearance:none;
		  appearance: none;
		  list-style: none;
		  border: 1px solid #8c8cff;
		  border-radius: 4px;
		  width: 70px;
		  padding: -0.2em .5em;
		  background: url(https://img.icons8.com/material-sharp/20/7950F2/expand-arrow--v1.png) center right 3px no-repeat;	
	}
	
	select::-ms-expand{
  		display:none;
	}
	
	
	/* 본문 */
	
	.first_div {
		width: 60%;
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
	    width: 24%;
	    font-size: 15px;
	    text-align: center;
	    margin-bottom: 45px;
	    line-height: 35px;
	}
	
	.div_result {
		display:inline-block;
		font-size: 15px;
	/*	border-bottom: 1px solid #8282ff;*/
		width: 70%;
   		margin-left: 6px;
		height: 24px;
		line-height: 35px;
		margin-bottom: 45px;
		padding-bottom: 10px;
	}
	
	input {
		border: none;
		line-height: 30px;
		transition: .2s;
	}
	
	/*
	.div_result:active,
	.div_result:focus,
	.div_result:hover {
	  outline: none;
	  border-bottom: 1px solid #black;
	}
	*/
	
	.msg_class {
	    font-size: 12px;
	    color: lightgray;
	    position: absolute;
	    margin: auto;
	    margin-left: 27%;
	    margin-top: -40px;
	}
	
	.div_in_form{
		position: relative;
	}
	
	.addr_class {
		border-bottom: 1px solid #8282ff;
		margin-bottom: 2%;
	}
	
	.detail_addr {
		width: 100%;
	}
	/*
	input:focus {
		width: 100%;
		border-bottom: 2px solid #8c8cff;
		padding-right: 10px;
	}

	*/
	
	/* input 박스 호버 이벤트 영역 시작  */

.div_result{
	position:relative;
}

	.menu .div_result_in {
 /*   color: #7878ff;*/
    font-family: Lato;
    font-size: 10pt;
    /*
    padding: 14px 20px;
    */
    position: relative;
    display: block;
    text-decoration: none;
    text-transform: uppercase;
    width: 100%;
}
	
	
	.SMN_effect-20 .div_result_in {
	  transition: 0.35s;
	}
	
	.SMN_effect-20 .div_result_in:hover {
	/*  color: #8c8cff;*/
	  transition: 0.35s;
	}
	
	.SMN_effect-20 .div_result_in:before, .SMN_effect-20 .div_result_in:after {
	  content: "";
	  width: 100%;
	  border-bottom: 1px solid #8282ff; 
	  position: absolute;
	  bottom: 0;
	  left: 0;
	  opacity: 1;
	  transform: scale(1, 1);
	  transform-origin: right center 0;
	}
	
	.SMN_effect-20 .div_result_in:after {
	  opacity: 0;
	  transform: scale(0, 1);
	  transform-origin: left center 0;
	}
	
	.SMN_effect-20 .div_result_in:hover:before {
	  opacity: 0;
	  transform: scale(0, 1);
	  transition: opacity 0.2s ease-in-out 0.2s, transform 0.2s ease-in-out 0s;
	}
	
	.SMN_effect-20 .div_result_in:hover:after {
	  opacity: 1;
	  transform: scale(1, 1);
	  transition: transform 0.2s ease-in-out 0.25s;
	}
	
	
/* input 박스 호버 이벤트 영역 끝  */
	

	
</style>
<script>

	$(function(){
		fn_nameCheck();
		fn_emailCheck();
		fn_mobileCheck();
		fn_birthyear();
		fn_birthmonth();
		fn_birthday();
		fn_modify();
		fn_cancel();
	});
	
	
	var namePass = true;
	var mobilePass = true;
	var emailPass = true;
	
	
	function fn_nameCheck(){
		$('#name').keyup(function(){
			let nameValue = $(this).val();
			namePass = (nameValue != '');
		});
	}
	
	function fn_emailCheck(){
		$('#email').keyup(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			let emailValue = $(this).val();
			if(regEmail.test(emailValue) == false){
				$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
				emailPass = false;
				return;
			}
			$.ajax({
				type: 'get',
				url: '/users/checkSameEmail',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						$('#msg_email').text('이미 사용중인 이메일입니다.');
						emailPass = false;
					} else {
						$('#msg_email').text('');
						emailPass = true;
					}
				}
			});
		});
	}
	
	function fn_mobileCheck(){
		$('#mobile').keyup(function(){
			let mobileValue = $(this).val();
			let regMobile = /^010[0-9]{7,8}$/;
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대번호를 확인하세요.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				mobilePass = true;
			}
		});
	}
	
	function fn_birthyear(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년도</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#birthyear').append(strYear);
		$('#birthyear').val('${loginUser.birthyear}').prop('selected', true);
	}
	
	function fn_birthmonth(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#birthmonth').append(strMonth);
		$('#birthmonth').val('${loginUser.birthmonth}').prop('selected', true);
	}
	
	function fn_birthday(){
		$('#birthday').empty();
		$('#birthday').append('<option value="">일</option>');
		let endDay = 0;
		let strDay = '';
		switch($('#birthmonth').val()){
		case '02':
			endDay = 29; break;
		case '04':
		case '06':
		case '09':
		case '11':
			endDay = 30; break;
		default:
			endDay = 31; break;
		}
		for(let d = 1; d <= endDay; d++){
			if(d < 10){
				strDay += '<option value="0' + d + '">' + d + '일</option>';
			} else {
				strDay += '<option value="' + d + '">' + d + '일</option>';
			}
		}
		$('#birthday').append(strDay);
		$('#birthday').val('${loginUser.birthday}').prop('selected', true);
	}
	
	function fn_modify(){
		$('#frm_edit').submit(function(event){
			if(namePass == false){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return;
			} else if(mobilePass == false){
				alert('휴대전화번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthday').val() == ''){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return;
			} else if(emailPass == false){
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	function fn_cancel(){
		$('#btn_cancel').click(function(){
			location.href = '/users/mypage';
		});
	}
	

	
</script>
<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			<div class="mapage_div" style="font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 40px;"> 정보 수정 </div>
			
			<div style="height: 20px;"></div>
			
			<div class="div_form">
				<form id="frm_edit" action="/users/modify/info" method="post">
					<input type="hidden" name="id" value="${loginUser.id}">
						
						<!-- 
					<div class="">
						<span class="div_topic"><span  class="div_topic_in">아이디</span></span>
						<span class="div_result"><span class="div_result_in">${loginUser.id}</span></span>
					</div>
						 -->
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic"><label for="name">이름 </label></span>
						<span class="div_result"><span class="div_result_in"><input type="text" name="name" id="name" value="${loginUser.name}"></span></span>
					</div>
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic">닉네임</span>
						<span class="div_result"><span class="div_result_in">${loginUser.nickname}</span></span>
					</div>
					
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic"><label for="email">이메일 </label></span>
						<span class="div_result"><span class="div_result_in"><input type="text" name="email" id="email" value="${loginUser.email}"></span></span>
						<div class="msg_class" id="msg_email"></div>
					</div>
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic"><label for="mobile">휴대전화</label></span>
						<span class="div_result"><span class="div_result_in"><input type="text" name="mobile" id="mobile" value="${loginUser.mobile}"></span></span>
						<div class="msg_class" id="msg_mobile"></div>
					</div>
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic">성별 </span>
						<span class="div_result"><span class="div_result_in">
						<input  class="male_check"  type="radio" name="gender" id="male" value="M">
						<label class="male_check_in"  for="male">남자 🙎‍♂️</label> &nbsp; &nbsp; &nbsp;
						<input class="female_check" type="radio" name="gender" id="female" value="F">
						<label class="female_check_in" for="female">여자 🙍‍♀️</label>
						</span></span>
						<script>
							
						$(function(){
							
							setTimeout(function() {
								$(':radio[name="gender"][value="${loginUser.gender}"]').prop('checked', true);
								
								if('${loginUser.gender}' == 'M'   ){  
									 $('.male_check_in').text('남자 🙋‍♂️');
								}
								else if('${loginUser.gender}' == 'F'   ){  
									 $('.female_check_in').text('여자 🙋');
								}
								
								}, 1000);
							
													
							 $('.male_check').click(function() {
							        if ($("input[type=radio][name=gender]:checked").val()) {
							            $('.male_check_in').text('남자 🙋‍♂️');
							            $('.female_check_in').text('여자 ‍🙍‍♀️');
							        }
							        else {
							        }
							    })
							
							    $('.female_check').click(function() {
							        if ($("input[type=radio][name=gender]:checked").val()) {
							            $('.female_check_in').text('여자 🙋');
							            $('.male_check_in').text('남자 🙎‍♂️');
							        }
							        else {
							        }
							    })						
							});							
						</script>
					</div>
					
					<div class="div_in_form menu SMN_effect-20">
						<span class="div_topic"><label for="birthyear">생년월일 </label></span>
						<span class="div_result select_box_div"><span class="div_result_in">
						<select name="birthyear" id="birthyear"></select>
						<select name="birthmonth" id="birthmonth"></select>
						<select name="birthday" id="birthday"></select>
						</span></span>
					</div>
					
					<div class="div_topic" style="margin-bottom: 10px;">주소 </div>
					<div>
						<input class="addr_class" type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호" readonly="readonly" value="${loginUser.postcode}">
						<input class="btn purple" style="margin-left: 10%;" type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
						<input class="addr_class detail_addr" type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소"  readonly="readonly" value="${loginUser.roadAddress}">
						<input class="addr_class detail_addr" type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소"  readonly="readonly" value="${loginUser.jibunAddress}"><br>
						<span id="guide" style="color:#999;display:none"></span>
						<input class="addr_class detail_addr" type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${loginUser.detailAddress}">
						<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script>
						    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
						    function fn_execDaumPostcode() {
						        new daum.Postcode({
						            oncomplete: function(data) {
						                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						
						                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						                var roadAddr = data.roadAddress; // 도로명 주소 변수
						                var extraRoadAddr = ''; // 참고 항목 변수
						
						                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
						                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						                    extraRoadAddr += data.bname;
						                }
						                // 건물명이 있고, 공동주택일 경우 추가한다.
						                if(data.buildingName !== '' && data.apartment === 'Y'){
						                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						                }
						                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						                if(extraRoadAddr !== ''){
						                    extraRoadAddr = ' (' + extraRoadAddr + ')';
						                }
						
						                // 우편번호와 주소 정보를 해당 필드에 넣는다.
						                document.getElementById('postcode').value = data.zonecode;
						                document.getElementById("roadAddress").value = roadAddr;
						                document.getElementById("jibunAddress").value = data.jibunAddress;
						                
						                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						                /* if(roadAddr !== ''){
						                    document.getElementById("extraAddress").value = extraRoadAddr;
						                } else {
						                    document.getElementById("extraAddress").value = '';
						                } */
						
						                var guideTextBox = document.getElementById("guide");
						                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						                if(data.autoRoadAddress) {
						                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
						                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
						                    guideTextBox.style.display = 'block';
						
						                } else if(data.autoJibunAddress) {
						                    var expJibunAddr = data.autoJibunAddress;
						                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
						                    guideTextBox.style.display = 'block';
						                } else {
						                    guideTextBox.innerHTML = '';
						                    guideTextBox.style.display = 'none';
						                }
						            }
						        }).open();
						    }
						</script>
					</div>
					<div style="border-bottom: 1px solid #8c8cff; height: 20px;"></div>
					
					<div class="div_btns">
						<button class="btn purple">수정하기</button>
						<input class="btn purple" type="button" value="취소하기" id="btn_cancel">
					</div>
				</form>
					</div>
					

		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>