<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
   <jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">


<style>

.wrap{
position: static;
position: unset !important;
margin-top: 50%;
overflow: unset; 
font-family: 'Noto Sans KR', sans-serif;
}


html {
  height: 100%;
}

body {
  margin:0;
  padding:0;
  font-family: sans-serif;
  
}

.login-box {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 600px;
  padding: 40px;
  transform: translate(-50%, -50%);
  box-sizing: border-box;
}

.login-box h2 {
  margin: 0 0 30px;
  padding: 0;
  color: #000;
  text-align: center;
}

.login-box .user-box {
  position: relative;
  margin-bottom: 25px;
}

.login-box .user-box  input {
  width: 100%;
  height: 20px;
  padding: 10px 0;
  font-size: 16px;
  color: #999;
  margin-bottom: 26px;
  border: none;
  border-bottom: 1px solid #5a5aff;
  outline: none;
  background: transparent;
}
.login-box .user-box label {
  position: absolute;
  top:0;
  left: 0;
/*   padding: 10px 0; */
  font-size: 16px;
  color: #999;
  pointer-events: none;
  transition: .5s;
  
}

.login-box a span {
  position: absolute;
  display: block;
}

 input:-webkit-autofill,
 input:-webkit-autofill:focus {
    transition: background-color 600000s 0s, color 600000s 0s;
  }
  
.login-box .user-box input:focus ~ label,
.login-box .user-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: #5a5aff;
  font-size: 12px;
}
  

.login-box .user-box input:-webkit-autofill:focus ~ label,
.login-box .user-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: #5a5aff;
  font-size: 12px;
}

/* .user-box-with-btn */
	.user-box-with-btn{
	  position: relative;
	  margin-bottom: 25px;
	}
	
	.user-box-with-btn input {
	  width: 50%;
	  height: 20px;
	  padding: 16px 0;
	  font-size: 16px;
	  color: #999;
	  margin-bottom: 26px;
	  border: none;
	  border-bottom: 1px solid #5a5aff;
	  outline: none;
	  background: transparent;
	}
	
	.user-box-with-btn label {
	  position: absolute;
	  top:0;
	  left: 0;
	  padding: 10px 0;
	  font-size: 16px;
	  color: #999;
	  pointer-events: none;
	  transition: .5s;
	}
	
	.user-box-with-btn input:focus ~ label,
	.user-box-with-btn input:valid ~ label {
	  top: -20px;
	  left: 0;
	  color: #5a5aff;
	  font-size: 12px;
	}
	  
	
	.user-box-with-btn input:-webkit-autofill:focus ~ label,
	.user-box-with-btn input:valid ~ label {
	  top: -20px;
	  left: 0;
	  color: #5a5aff;
	  font-size: 12px;
	}


.notice_span {
	font-size: 12px;
    color: lightgray;
    position: absolute;
    bottom: 10px;
    left: 0;
}

.notice_span_email {
	font-size: 12px;
    color: lightgray;
    position: absolute;
    bottom: -30px;
    left: 0;
}

.buttons {
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
.buttons:active {
	  top: 4px; 
	}
	
.buttons.purple {box-shadow:0px 4px 0px #b6b6f3;}
.buttons.purple:active {box-shadow: 0 0 #c8c8ff; background-color: #c8c8ff;}

.btn.purple, .btn-two.purple {background-color: #c8c8ff;}


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

.display_class {
	display: flex;
    justify-content: space-between;
    flex-direction: row;
    align-items: baseline;
}

</style>

<script>
   $(function(){
      fn_idCheck();
      fn_pwCheck();
      fn_pwCheckAgain();
      fn_nicknameCheck();
      fn_nameCheck();
      fn_mobileCheck();
      fn_birthyear();
      fn_birthmonth();
      fn_birthday();
      fn_emailCheck();
      fn_join();
   });
   
   var idPass = false;
   var pwPass = false;
   var rePwPass = false;
   var nicknamePass = false;
   var namePass = false;
   var mobilePass = false;
   var authCodePass = false;
   
   
   
   function fn_idCheck(){
      $('#id').keyup(function(){
         let idValue = $(this).val();
         let regId = /^[0-9a-z][0-9a-z]{3,19}$/;
         
         if(regId.test(idValue) == false){
            $('#msg_id').text('4~20자의 소문자, 숫자를 조합해주세요');
            idPass = false;
            return;
         }
         
         $.ajax({
            type: 'get',
            url: '/users/checkSameId',
            data: 'id=' + idValue,
            dataType: 'json',
            success: function(resData){
               if(resData.isUser || resData.isRetireUser || resData.isSleepUser){
                  console.log(resData);
                  $('#msg_id').text('이미 사용중이거나 탈퇴한 아이디입니다.');
                  idPass = false;
               } else {   
                  $('#msg_id').text('사용 가능한 아이디입니다.');
                  idPass = true;
               }
            }
         });
      });
   }
   
   
   function fn_pwCheck(){
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
   
   
   function fn_nicknameCheck(){
      $('#nickname').keyup(function(){
         let nicknameValue = $(this).val();
         
         $.ajax({
            type: 'get',
            url: '/users/checkSameNickname',
            data: 'nickname=' + nicknameValue,
            dataType: 'json',
            success: function(resData){
               if(resData.isUser){
                  $('#msg_nickname').text('이미 사용중인 닉네임입니다.');
                  nicknamePass = false;
               } else {   
                  $('#msg_nickname').text('사용 가능한 닉네임입니다.');
                  nicknamePass = true;
               }
            }
         });
      });
   }
   
   
   
   function fn_nameCheck(){
      $('#name').keyup(function(){
         let nameValue = $(this).val();
         namePass = (nameValue != '');
      });
   }
   
   
   function fn_mobileCheck(){
      $('#mobile').keyup(function(){
         let mobileValue = $(this).val();
         let regMobile = /^010[0-9]{7,8}$/;
         if(regMobile.test(mobileValue) == false){
            $('#msg_mobile').text('휴대전화를 확인하세요.');
            mobilePass = false;
         } else {
            $('#msg_mobile').text('');
            mobilePass = true;
         }
      });
   }
   
   
   function fn_birthyear(){
      let year = new Date().getFullYear();
      let strYear = '<option class="optionListItem" value="">년도</option>';
      for(let y = year - 100; y <= year + 1; y++){
         strYear += '<option class="optionListItem" value="' + y + '">' + y + '</option>';
      }
      $('#birthyear').append(strYear);
   }
   
   
   function fn_birthmonth(){
      let strMonth = '<option class="optionListItem" value="">월</option>';
      for(let m = 1; m <= 12; m++){
         if(m < 10){
            strMonth += '<option class="optionListItem" value="0' + m + '">' + m + '월</option>';
         } else {
            strMonth += '<option class="optionListItem" value="' + m + '">' + m + '월</option>';
         }
      }
      $('#birthmonth').append(strMonth);
   }
   
   
   function fn_birthday(){
      $('#birthday').append('<option class="optionListItem" value="">일</option>');
         
      $('#birthmonth').change(function(){
         
         $('#birthday').empty();
         $('#birthday').append('<option class="optionListItem" value="">일</option>');
         let endDay = 0;
         let strDay = '';
         switch($(this).val()){
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
               strDay += '<option class="optionListItem" value="0' + d + '">' + d + '일</option>';
            } else {
               strDay += '<option class="optionListItem" value="' + d + '">' + d + '일</option>';
            }
         }
         $('#birthday').append(strDay);
      });
   }
   
      
   function fn_emailCheck(){
      $('#btn_getAuthCode').click(function(){
         
         // 인증코드를 입력할 수 있는 상태로 변경함s
         $('#authCode').prop('readonly', false);
         
         // resolve : 성공하면 수행할 function
         // reject  : 실패하면 수행할 function
         new Promise(function(resolve, reject) {
            // 정규식 
            let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
            
            // 입력한 이메일
            let emailValue = $('#email').val();
            
            // 정규식 검사
            if(regEmail.test(emailValue) == false){
               reject(1);  // catch의 function으로 넘기는 인수 : 1(이메일 형식이 잘못된 경우)
               authCodePass = false;
               return;     // 아래 ajax 코드 진행을 막음
            }
            // 이메일 중복 체크
            $.ajax({
               /* 요청 */
               type: 'get',
               url: '/users/checkSameEmail',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  alert('이메일 중복 체크 성공');
                  // 기존 회원 정보에 등록된 이메일이라면 실패 처리
                  if(resData.isUser){
                     reject(2);   // catch의 function으로 넘기는 인수 : 2(다른 회원이 사용중인 이메일이라서 등록이 불가능한 경우)
                  } else {
                     resolve();   // Promise 객체의 then 메소드에 바인딩되는 함수
                  }
               }
            });  // ajax
            
         }).then(function(){
            console.log('인증번호 검사');
            // 인증번호 보내는 ajax
            $.ajax({
               /* 요청 */
               type: 'get',
               url: '/users/sendAuthCode',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
                  // 발송한 인증코드와 사용자가 입력한 인증코드 비교
                  $('#btn_verifyAuthCode').click(function(){
                     if(resData.authCode == $('#authCode').val()){
                        alert('인증되었습니다.');
                        authCodePass = true;
                     } else {
                        alert('인증에 실패했습니다.');
                        authCodePass = false;
                     }
                  });
               },
               error: function(jqXHR){
                  alert('인증번호 발송이 실패했습니다.');
                  authCodePass = false;
               }
            }); 
            
         }).catch(function(code){  // 인수 1 또는 2를 전달받기 위한 파라미터 code 선언
            switch(code){
            case 1:
               $('#msg_email').text('이메일 형식이 올바르지 않습니다.');
               break;
            case 2:
               $('#msg_email').text('이미 사용중인 이메일입니다.');
               break;
            }
         
            authCodePass = false;
         
            // 입력된 이메일에 문제가 있는 경우 인증코드 입력을 막음
            $('#authCode').prop('readonly', true);
            
         }); 
         
      });  
   }
   
   
   function fn_join(){
      
      $('#frm_join').submit(function(event){
         
         if(idPass == false){
            alert('아이디를 확인하세요.');
            event.preventDefault();
            return;
         } else if(pwPass == false || rePwPass == false){
            alert('비밀번호를 확인하세요.');
            event.preventDefault();
            return;
         } else if(namePass == false){
            alert('이름을 확인하세요.');
            event.preventDefault();
            return;
         } else if(mobilePass == false){
            alert('휴대전화번호를 확인하세요.');
            event.preventDefault();
            return;
         } else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthdate').val() == ''){
            alert('생년월일을 확인하세요.');
            event.preventDefault();
            return;
         } else if(authCodePass == false){
            alert('이메일 인증을 받으세요.');
            event.preventDefault();
            return;
         }
         
      });  
      
   }  
   
</script>

<body translate="no">

<section class="wrap" style="position: relative;"><!-- 기본틀 1 -->
   <section class="content_leyout_section" style="position: relative;"><!-- 기본틀 2 -->
      <div class="login-box">
         <div style="padding-bottom: 16px; font-size: 12px; text-align: right;"> * 표시는 필수 입력사항입니다</div>
         
        <!--  <div style="border-top: 1px solid #5a5aff; height: 10px; padding-bottom: 30px;"></div> -->
         
         <form id="frm_join" action="/users/join" method="post" autocomplete="off">
          <input type="hidden" name="location" value="${location}">
            <input type="hidden" name="marketing" value="${marketing}">
            <!-- 아이디 -->
          <div class="user-box">            
            <input class="input" type="text" name="id" id="id" required="">
              <label for="id">아이디 * </label>
              <span class="notice_span" id="msg_id"></span>    
          </div>          
           <!-- 비번 -->
          <div class="user-box">                      
            <input class="input" type="password" name="pw" id="pw"  required="" autocomplete="new-password">
               <label for="pw">비밀번호 *</label>
               <span class="notice_span" id="msg_pw"></span>        
          </div>                    
            <!-- 비번확인 -->
            <div class="user-box">
               <input class="input" type="password" id="re_pw" required=""  autocomplete="off">
               <label for="re_pw">비밀번호 확인 *</label>
               <span class="notice_span" id="msg_re_pw"></span>
            </div>        
             <!-- 닉네임 -->
            <div class="user-box">
               <input class="input" type="text" name="nickname" id="nickname" required="" >
               <label for="nickname">닉네임 *</label>
               <span class="notice_span" id="msg_nickname"></span>
            </div>
            <div class="user-box">
               <input class="input" type="text" name="name" id="name" required="">
               <label for="name">이름 *</label>
            </div>
            <!-- 휴대폰 -->
            <div class="user-box">
               <input class="input" type="text" name="mobile" id="mobile" required="">
               <label for="mobile">휴대전화 *</label>
               <span class="notice_span" id="msg_mobile"></span>
            </div>
            
            <!-- 성별 -->
            <div  style="color: #999;">
               <span>성별 *</span> <br>
               <div style="height: 30px; padding-top: 20px;">
	               <input  class="male_check"  type="radio" name="gender" id="male" value="M">
						<label class="male_check_in"  for="male">남자 🙎‍♂️</label> &nbsp; &nbsp; &nbsp;
						<input class="female_check" type="radio" name="gender" id="female" value="F">
						<label class="female_check_in" for="female">여자 🙍‍♀️</label>
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
						        }
						    })						
						});							
					</script>
               </div>
            </div>
            
            <div style="border-top: 1px solid #5a5aff; height: 10px; padding-bottom: 30px;"></div>
            
            <!-- 생년월일 -->
            <div class="birth_center" style="color: #999;">
               <label for="birthyear">생년월일 *</label> <br>
               <div class="select_box_div" style="height: 30px; padding-top: 20px;">
	               <select name="birthyear" id="birthyear" class="custom-select"></select>
	               <select name="birthmonth" id="birthmonth" class="custom-select"></select>
	               <select name="birthday" id="birthday" class="custom-select"></select>
               </div>
            </div>
            <div style="border-top: 1px solid #5a5aff; height: 10px; padding-bottom: 30px;"></div>
            
            <!-- 주소 -->
            <div>
               <input style="border:none; border-bottom: 1px solid #5a5aff;" class="input" type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호" readonly>
               <input class="buttons purple" type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
               <div style="padding-top: 30px;">
               <input style="border:none; border-bottom: 1px solid #5a5aff; width: 48%;" class="input" type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly>
               <input style="border:none; border-bottom: 1px solid #5a5aff; width: 48%;" class="input" type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소" readonly><br>
               </div>
               <span id="guide" style="color:#999;display:none"></span>
               <div style="padding-top: 40px;">
               <div class="user-box">
               <input type="text" name="detailAddress" id="detailAddress" required="">
               <label for="mobile">상세주소</label>
               </div>
               </div>
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
                               }
                */
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
            <!-- 이메일 -->
            <div class="display_class">
            <span class="user-box-with-btn">
               <input class="input" type="text" name="email" id="email" required="" style="width: 350px;">
               <label for="email">이메일 *</label>
               <span class="notice_span_email" id="msg_email"></span>
            </span >
            <span style="text-align: right;">
               <input class="buttons purple" type="button" value="인증번호받기" id="btn_getAuthCode" >
            </span>
            </div> 
            <div class="display_class" style="margin-bottom: 10px;">
            <span class="user-box-with-btn">
               <input class="input" type="text" name="authCode" id="authCode" required="" style="width: 350px;">
               <label for="authCode" >인증코드 입력</label>
            </span>
            <span style="text-align: right;">
               <input class="buttons purple"  type="button" value="인증하기" id="btn_verifyAuthCode" >
            </span>   
            </div>
            
            
            <div style="height: 10px; border-top: 1px dotted #c8c8ff;"></div>
           

            <div style="text-align: right;display: flex; justify-content: space-between;">
               <input  class="buttons purple" type="button" value="가입취소" onclick="history.back();">
               <button class="buttons purple" >가입하기</button>
            </div>
         </form>
      </div>
      
      
   </section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body> 
</html>