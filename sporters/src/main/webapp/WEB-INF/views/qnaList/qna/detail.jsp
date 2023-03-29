<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="${qna.qnaTitle}" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	.first_div {
		width: 60%;
		margin: auto;
	}
	
	.content_title_area{
        
        display: flex;
        margin-top: 1vw;       
	    flex-wrap: nowrap;
	    justify-content: space-between;
	}
	
	.content_title_area_right div{
	
		display: inline-block;
		vertical-align: text-top;
		padding: 0 0.3vw;
	}
	
	.content_title_area_right span{
		padding: 0 0.3vw;
	}
	
	.gogo_wright a{
		
	
	}
	
	.content_title_area_left {
		font-size: 35px;
		font-weight: bold;
	}
	
	.div_content {
		background-color: rgba(194, 194, 255, 0.08);
		height: 50%;
    	margin-top: 3%;
    	margin-bottom: 3%;
    	border-radius: 4px;
	}
	
	.div_content_text {
		width: 80%;
		text-align: left;
	    margin-left: 2%;
        padding-top: 2%;
	}
	
	.div_btns {
		text-align: right;
		margin-top: 1%;
		margin-bottom: 1%;
	}
	
	.input_reply {
		border: none;
		background: rgba(219, 219, 219, 0.6);
		border-radius: 4px;
		width: 60%;
	}	
	
	.reply_div {
		background-color: rgba(194, 194, 255, 0.08);
		margin-top: 3%;
		margin-left: 3%;
   		width: 95%;
	}
	
</style>
<body>
	<section class="wrap" style="padding-bottom: 25%;"><!-- 기본틀 1 -->
		<section class="content_leyout_section"><!-- 기본틀 2 -->
			<div class="first_div">
				<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
				
				<div class="content_title_area">
				<div class="content_title_area_left">${qna.qnaTitle}</div>
					<div class="content_title_area_right">
						<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO3VO2tVQRSG4UeJB0SCWHkpghgE4wXEQrCwFgsLQdAg+gO0EkRstEsl+AckQRGsLAyBWBi1EwvRaJ14aQQVFK+JGohs+AKHw7klc9L5wWaYvdbMO7NmrRn+axW1FpvS9lwHMI45LKa9h/29ApzEb3zHKK5gDD8wjxOlgF2ZaBo7GmyDeJVd7SyBjAYy1MK+O7u8UQJ5i8kOPvfxugTyJfFvpzF8LoE8x5MOPk/xrARyKSl7vIX9WOwXSyDr8TLhONVgG87/6fgVaWvCtphEmEpb9V9gSylgM27iTyb9iln8Sv8vbmNb3ZgaruNdMnOgHeAQPqbYrqUm6rUnk1V18gmHAxjPAh7hZ9qm2ptVz7QpxCXtw5tcO48DuBzbXXzTROty2B+wXXcaSujqAaexgDvNBpyJ89kuAbW6EDUCqhra2GzQA7zv8s2orQSwJodVZVQn9a0EUKk/KXqhC8jBAEaWA1iuzgdyBOdWA1DpViBLX3VJVu9/T/UQE7iKo9jQyvMfsCVuvY9ZWbgAAAAASUVORK5CYII="></span>
						<span>${qna.qnaId}</span>
					</div>
				</div>
				<div style="text-align: right;">
					<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAABhUlEQVR4nM3TPUjWURgF8F9fhH0MFULQZhRFiw3hUkNCgUtQWwUtQR+QOAYaEi0KKbo0FUQQmUVLBEUUREURRUM0NOagVEsfFtoXxoUjvLwovr01eJb//3LvPc/znHMu8wSbsf5/EB3HG0zg7r+SHcZPdGEk37qxGz9wBI0YxdF6iJZjHz6jFw14ghf5rwlLcSwaTWIKQ1iEG1mfwYJayBrwAJ9wMeI/TJF+fMQpjONWxp8VC3Edb9GEO3F0NU7gO3bm7Ea8xBj2z9ZtXzrYgvN4H+I9cfdQ1fnS9elM8RwdWFyZr9JBKzrxDS3Yhq/oriBaU0XchHN4NL23IgTFiAP4hb0p8iFdn0yH1/DaHFiF3xiMqx25XIoMYBjPEubb2KoG9CYOg9GmZO1prdGYCcNxtYh6Ge/wBfexQx0YQw8uhKgZG3A1ctyriEzlK2pLLs9GnmVlY23GnUq2tlddLDG6kuiMRo5X0XsCj3ETl7CyXFgSRzfNMcU6HIzj7dj1N+95/uAP1/ReFe34fBUAAAAASUVORK5CYII="> 작성일  ${qna.qnaCreateDate}</span>
				</div>

				<div class="div_content">
					<div class="div_content_text">
						${qna.qnaContent}
					</div>
				</div>
				
		<div class="div_btns">
				<div>
					<form id="frm_btn" method="post">
						<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
						<c:if test="${loginUser.id == qna.qnaId}">
							<span><input type="button" value="수정" id="btn_edit_qna"></span>
							<span><input type="button" value="삭제" id="btn_remove_qna"></span>
						</c:if>
						<span><input type="button" value="목록" onclick="location.href='/qna/list'"></span>
					</form>
					<script>
						$('#btn_edit_qna').click(function(){
							$('#frm_btn').attr('action','/qna/edit');
							$('#frm_btn').submit();
						});
						$('#btn_remove_qna').click(function(){
							$('#frm_btn').attr('action','/qna/remove');
							$('#frm_btn').submit();
						});
					</script>
				</div>
			</div>
		
		<div style="border-bottom: 1px solid #c8c8ff; margin-bottom: 2%;"></div>
		
				<div id="reply_area">
					<div style="font-weight: bold; font-size: 35px;"> 답변 </div>
					<div class="reply_div" id="reply_list"></div>
				</div>
				
				<c:if test="${loginUser.id == 'admin'}">
					<div>
						<form id="fmr_add_reply">
							<div>
								<span>
									<input class="input_reply" type="text" name="qnaReplyContent" id="qnaReplyContent">
								</span>
								<span>
									<input type="button" value="답변 작성" id="btn_add_reply">
								</span>
							</div>
							<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
						</form>
					</div>
				</c:if>

		</div>
			
			<script>

				fn_addReply();
				fn_replyList();
				fn_removeReply();
			
				function fn_addReply(){
					$('#btn_add_reply').click(function(){
						if($('#qnaReplyContent').val() == '') {
							alert('답변 내용을 입력해주세요!');
							return;
						}
						$.ajax({
							type: 'post',
							url: '/qna/addReply',
							data: $('#fmr_add_reply').serialize(),
							dataType: 'json',
							success: function(resData){
								if(resData.isAdd){
									alert('답변이 등록되었습니다!');
									$('#qnaReplyContent').val('');
									fn_replyList();
								}
							}
						});
					});
				}
				
				function fn_replyList(){
					$.ajax({
						type: 'get',
						url: '/qna/replyList',
						data: 'qnaNo=${qna.qnaNo}',
						dataType: 'json',
						success: function(resData){
							$('#reply_list').empty();
							$.each(resData.qnaReplyList, function(i, reply){
								var div='';
								if(reply.depth == 0){
									div += '<div>';
								} else {
									div += '<div style="font-weight: bold;">';
								}
								if(reply.state == 1){
									div += '<div>';
									if(reply.depth > 0){
										div += '답변 : ';
									}
									div += reply.qnaReplyContent;
									if(${loginUser.id == 'admin'}){
										div += '<input type="button" value="답변삭제" class="btn_reply_remove" data-qna_reply_no="' + reply.qnaReplyNo + '">';
									}
									div += '</div>';
								} else {
									if(reply.depth == 0){
										div += '<div>삭제된 답변입니다.</div>';
									}
								}
								div += '<div>';
								div += '<form class="frm_reply">';
								div += '<input type="hidden" name="qnaNo" value="' + reply.qnaNo + '">';
								div += '<input type="hidden" name="groupNo" value="' + reply.groupNo + '">';
								div += '</form>';
								div += '</div>';
								
								$('#reply_list').append(div);
							});
						}
					});
				}
				
				function fn_removeReply(){
					$(document).on('click', '.btn_reply_remove', function(){
						if(confirm('답변을 삭제할까요?')){
							$.ajax({
								type: 'post',
								url: '/qna/replyRemove',
								data: 'qnaReplyNo=' + $(this).data('qna_reply_no'),
								dataType: 'json',
								success: function(resData){
									if(resData.isRemove){
										alert('답변이 삭제되었습니다.');
										fn_replyList();
									}
								}
							});
						}
					});
				}
				
				
				
			</script>
			
			
		</section><!-- 기본틀 2 -->
	</section><!-- 기본틀 1 -->


	
	
<script type="text/javascript">
$(function(){
	 var right_side =  $('.content_leyout_section').offset().top;
	var my_right_side = $('.right_side_menu_area').width();
	var right_side_marginLeft = $('.content_leyout_section').width() + my_right_side*2 ;


	 $('.right_side_menu_area').offset({top:right_side});
	 $('.right_side_menu_area').css({marginLeft:right_side_marginLeft  });
	 
	 // content_leyout 현재 높이값을 구함. 
	 var left_side_top =  $('.content_leyout_section').offset().top;
	 var right_side_marginLeft = $('.content_leyout_section').offset().left;

	// 왼쪽 사이드 메뉴의 넓이값을 구함
	var my_left_side =right_side_marginLeft -  $('.left_side_gnd_area').width() - my_right_side;
	var left_side_marginLeft = $('.content_leyout_section').width();


	 $('.left_side_gnd_area').offset({top:left_side_top});	 
	 
	
}); 
</script>
</body>
</html>