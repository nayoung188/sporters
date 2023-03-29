<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}

	.blind {
		display: none;
	}
	/* 헤더 */
		
	.mapage_div { 
		position: relative; 
		margin-top: 5%;
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
	    width: 75%;
	    height: 90%;
	    margin: auto;
	    border: 1px solid #e8e8e8;
	    box-shadow: 5px 5px #c8c8ff;
	    margin-top: 5%;
	}
	
	.div_form {
		margin: auto;
	    width: 75%;
    	text-align: left;
	}
	
	.div_element{
	    margin-bottom: 2%;
	}
	
	
	
</style>
<script>
	
	$(function(){
		fn_isheartCheck();
		fn_goodCheck();
		fn_goodAndHate();
		fn_goodCount();
		fn_hateCount();
		fn_pressGood();
		fn_pressHate();
	});
	
	// 좋아요,싫어요 눌렀는지 확인
		function fn_isheartCheck(){
			$.ajax({
				type: 'get',
				url: '/heart/isHeartCheck',
				data: '&userNo=' + $('#userNo').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isHeart == 0){
						alert('좋아요 싫어요 중 하나만 눌러주세요!');
					}
				}
			});
		}
	
		// 좋아요 눌렀는지 확인
		function fn_goodCheck(){
			$.ajax({
				url: '/heart/getHeartCheck',
				type: 'get',
				data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
				dataType: 'json',
				success: function(resData){
					if (resData.count == 0) {
						$('#heart').text('♥');
						$('#good').removeClass("good_checked");
						
					} else {
						$('#hater').text('♥');
						$('#hate').removeClass("hate_checked");
					}
				}
			});
		}
		
		// 좋아요 개수 카운트
		function fn_goodCount(){
			$.ajax({
				url: '/heart/getHeartCount',
				type: 'get',
				data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
				dataType: 'json',
				success: function(resData){
					$('#good_count').empty();
					$('#good_count').text(resData.heartcount);
				}
			});
		}
		
		// 좋아요 누른 경우
		function fn_pressGood(){
			$('#lnk_good').click(function(){
				// 로그인을 해야 "좋아요"를 누를 수 있다.
				if('${loginUser.userNo}' == ''){
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				}
				// 셀프 좋아요 방지
				if('${loginUser.userNo}' == '${user.userNo}'){
					alert('본인에게는 "좋아요"를 누를 수 없습니다.');
					return;
				}
				// "좋아요" 선택/해제 상태에 따른 하트 변경
				$('#good').toggleClass("good_checked");
				$('#hate').toggleClass('blind');

				// "좋아요" 처리
				$.ajax({
					url: '/heart/markLike',
					type: 'get',
					data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess) {
							fn_goodCount();							
						}
					}
				});
			});
		}
		
		// 싫어요 개수 카운트
		function fn_hateCount(){
			$.ajax({
				url: '/heart/getHateCount',
				type: 'get',
				data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
				dataType: 'json',
				success: function(resData){
					$('#hate_count').empty();
					$('#hate_count').text(resData.hatecount);
				}
			});
		}
		
		
		// 싫어요 누른 경우
		function fn_pressHate(){
			$('#lnk_hate').click(function(){
				// 로그인을 해야 "좋아요"를 누를 수 있다.
				if('${loginUser.userNo}' == ''){
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				}
				// 셀프 좋아요 방지
				if('${loginUser.userNo}' == '${user.userNo}'){
					alert('본인에게는 "싫어요"를 누를 수 없습니다.');
					return;
				}
				// "좋아요" 선택/해제 상태에 따른 하트 변경
				$('#hate').toggleClass("hate_checked");
				$('#good').toggleClass('blind');

				// "싫어요" 처리
				$.ajax({
					url: '/heart/markhate',
					type: 'get',
					data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess) {
							fn_hateCount();							
						}
					}
				});
			});
		}
		
		// 조아요싫어요 개수 카운트
		function fn_goodAndHate(){
			$.ajax({
				url: '/heart/likeNhate',
				type: 'get',
				data: 'clickUserNo=${loginUser.userNo}&userNo=' + $('#userNo').val(),
				dataType: 'json',
				success: function(resData){
					$('#good_hate_count').empty();
					$('#good_hate_count').text(resData.result);
				}
			});
		}
		
	
</script>

<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
		<div class="first_div">
			<div class="mapage_div" style="font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 20px;"> 회원 상세 정보 </div>
				<input type="hidden"  id="userNo" name="userNo" value="${user.userNo}">
				<div class="div_form">
				
					<div style="text-align: center; margin-bottom: 10%;">
						<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAAsTAAALEwEAmpwYAAAETklEQVR4nO2dzW8XRRiAH0GpsVVaNUGxCRHCoYdGDsQ0+gcYY6I0fPQEppcaOXDgoEmhxkNJwGhaLlzQRBJbRezFgxcSPpQjCSEBv20sKQkxKAUKVsEOmWRMTOzS33Zm552d3/sk73nnnWd2ZnZndhYURVEURVEURVHqwQqgDxgHvgdmAdPkMevqwtbJNldHUdgM/JJABZjE42egt0oRy4H3E0jU1CzeA5ZVIURlsGQpB6ropqRbmql5bAolY4XrD6UTMjWPyVADfV8CyZhMYmsIIZ8mkIjJJD4JIeTHBBIxmYR9TvHmZgKJmEzC1qU30kmYzEKFIC9BhSBf8SoE+cpuOiFzwFfAXuBVoAtY5R642oA1wIvA28AJYD6BMmcp5DugH3i0ZNk3ABcSKH82QmaBnZ5vS58ELicgovZCpl2XFIIO4GVgFJhRIeVlXAXWUQ2PAR/pHVJOyCtUz6B2WY3J+JJ4fK5jyOJCno8o5Bk3ldZBvaASviU+sZcXvIlZ2P3Exy4aqZCq151L8LQKKW6RXchwXbushYW0CQn5SYX8X8Y88ICQkJjL1N7EKugd5FAhBVJahYTE3KvsTcwp4VriY7vJP1XIwkJeEBCi0977tMZeASE9kXsBb2IW9i3i86YKKRbyhYCQIyqkWMglASGxt8p6YyLHauKxViA/b0zkp/Ue4vGGCln8e7yY2AfRH/QOKRbyLPHZpUKKhbQLCLHbg3QMKaiEbgEhdlFMhRRUQr+AkCEVUtwiPxMQclaFFAv5B9gYUcZrOu1dvL/+A9hd8eqh/XxhR+S19Fo+GJr/xHqq4yXBvLyRKvjr5DOQZyFkjOqwX2GpkJKV8Jf7XC00TwF/q5CltcjBCoTsEZRR6y7LANdciw7FSuCKCvGTMh5QyKhwA6v9HWJc7AuQx3b34Cmdizcmgfg9QB6/JZBHNkKuBchDhQQUciOAEOnBPKs7ZCZAHtMJ5JGNkKmMTsbzxiQQ5wPkcS6BPLIRcjpAHt8kkEc2QnYGyOOdBPLIQsjXgQ4gbk3kqCZvJAt/BniCcHQmIMUbiULPAcPAQ4TH3imHgLsqpDERH1a8fPsvzwFH3cemeocscD7WcOBX7Y2yxv2KI9bBZt5UWTi7J2oAeAR5HnbnnhxvNiF2afaw0LbRModnHq7o6CZvQp57ftDNdOrCKuBd97Y5GyF20BwBHqe+dLhxJsTmCG98DySzs5lc6A7wHOPNUi98TPB0nyppdZvCayXEHpv3IPmyDPhYSsjtkhc85f55mDvLgZMl6+ZWiAtPlty5XqdZlC+dLudG68f+7c6bMv2l3cTcbAzF3mPWV2Ijgt0Z2Gy0u9yj/TavBfi1gYtN0LxMxPyxZKO/XrXvpJqVAYmjpw4ucZqnAR9QAfabP5VC6QY2UvVpq1vcPilt+dy3DqZcVx+FFncx+9nZxRKzjJzjhquLMVc3to4URVEURVEURVFInXvGCW/YXnbmPAAAAABJRU5ErkJggg==">
					</div>
					<div style="margin-left: 26%;">
					<div class="div_element">
						닉네임 : ${user.nickname}
					</div>
					<div class="div_element">
						호감도 : <span id="good_hate_count"></span>
					</div>
					<div class="div_element">
						<span id="good">
							<a id="lnk_good">
								<span><img src="https://img.icons8.com/material-two-tone/24/null/thumb-up--v1.png"/></span><span id="good_count"></span>  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;            
							</a>
						</span>
						<span id="hate">
							<a id="lnk_hate">
								<span><img src="https://img.icons8.com/material-two-tone/24/null/thumbs-down.png"/></span><span id="hate_count"></span><br>
							</a>
						</span>
						
					</div>
					<div class="div_element">
						가입일 : ${user.joinDate}
					</div>
					</div>
				</div>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>