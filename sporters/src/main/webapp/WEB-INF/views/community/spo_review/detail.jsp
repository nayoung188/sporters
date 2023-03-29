<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="지역게시판_상세" name="title" />
</jsp:include>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
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
	}
	
	.input_comment {
		border: none;
		background: rgba(219, 219, 219, 0.6);
		border-radius: 4px;
		width: 50%;
	}	
	
</style>
<body>

<section class="wrap" style="padding-bottom: 25%;"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			
			<div class="content_title_area">
				<h1 class="content_title_area_left">${LocalgalleryList.title}</h1>		
					<div class="content_title_area_right">
						<div>
							<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO3VO2tVQRSG4UeJB0SCWHkpghgE4wXEQrCwFgsLQdAg+gO0EkRstEsl+AckQRGsLAyBWBi1EwvRaJ14aQQVFK+JGohs+AKHw7klc9L5wWaYvdbMO7NmrRn+axW1FpvS9lwHMI45LKa9h/29ApzEb3zHKK5gDD8wjxOlgF2ZaBo7GmyDeJVd7SyBjAYy1MK+O7u8UQJ5i8kOPvfxugTyJfFvpzF8LoE8x5MOPk/xrARyKSl7vIX9WOwXSyDr8TLhONVgG87/6fgVaWvCtphEmEpb9V9gSylgM27iTyb9iln8Sv8vbmNb3ZgaruNdMnOgHeAQPqbYrqUm6rUnk1V18gmHAxjPAh7hZ9qm2ptVz7QpxCXtw5tcO48DuBzbXXzTROty2B+wXXcaSujqAaexgDvNBpyJ89kuAbW6EDUCqhra2GzQA7zv8s2orQSwJodVZVQn9a0EUKk/KXqhC8jBAEaWA1iuzgdyBOdWA1DpViBLX3VJVu9/T/UQE7iKo9jQyvMfsCVuvY9ZWbgAAAAASUVORK5CYII="></span>
							<span>${LocalgalleryList.users.nickname}</span>
						</div>
					</div>
			</div>
				<div style="text-align: right;">					
					<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAABhUlEQVR4nM3TPUjWURgF8F9fhH0MFULQZhRFiw3hUkNCgUtQWwUtQR+QOAYaEi0KKbo0FUQQmUVLBEUUREURRUM0NOagVEsfFtoXxoUjvLwovr01eJb//3LvPc/znHMu8wSbsf5/EB3HG0zg7r+SHcZPdGEk37qxGz9wBI0YxdF6iJZjHz6jFw14ghf5rwlLcSwaTWIKQ1iEG1mfwYJayBrwAJ9wMeI/TJF+fMQpjONWxp8VC3Edb9GEO3F0NU7gO3bm7Ea8xBj2z9ZtXzrYgvN4H+I9cfdQ1fnS9elM8RwdWFyZr9JBKzrxDS3Yhq/oriBaU0XchHN4NL23IgTFiAP4hb0p8iFdn0yH1/DaHFiF3xiMqx25XIoMYBjPEubb2KoG9CYOg9GmZO1prdGYCcNxtYh6Ge/wBfexQx0YQw8uhKgZG3A1ctyriEzlK2pLLs9GnmVlY23GnUq2tlddLDG6kuiMRo5X0XsCj3ETl7CyXFgSRzfNMcU6HIzj7dj1N+95/uAP1/ReFe34fBUAAAAASUVORK5CYII="> 작성일 <fmt:formatDate value="${LocalgalleryList.createDate}" pattern="yy/M/d"/></span>
					&nbsp;&nbsp;&nbsp;
					<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA3UlEQVR4nN3Tv0oDMRwH8A/VpeoulHYR8QUEX8A3KHZxdBAX/4y6dfQpxEUdO3SrUNBBER0c+xK+gxwkcMNdk6M3iF8IIbnwIckvx3/MHo6x3QY2wguu8IX9VbAjzLEVxv2AHrSBWQUd4RmbNd/7+Ax91s6WYTEnONMSto5p6thNsCecp7AF7tHJwC5SBZhhAze4q0HX8JjCBngNWEwVGrFLiRzitmL+uoRmY0W6eKupVkQfwm+XnR4+KtCiAN9NsF2chjbGT7jwODfBe2lcvISl2SktzmnDJsf+W/kFReEspVxuLHYAAAAASUVORK5CYII="> 수정일 <fmt:formatDate value="${LocalgalleryList.modifyDate}" pattern="yy/M/d"/></span>	
				</div>
			

			<div class="div_content">
				<div class="div_content_text">
					${LocalgalleryList.content}
				</div>
			</div>
			
			<hr>
			
			<div class="div_btns">
				<form id="frm_btn" method="post">	
					
					<input type="hidden" name="localBoardNo" value="${LocalgalleryList.localBoardNo}">
					<c:if test="${loginUser.id == LocalgalleryList.users.id}" >
						<input type="button" value="후기작성" id="btn_edit_gallery">					
					</c:if>
				</form>
			</div>
		
				
			<script>
			/*
					$(function(){
						consol.log(${gallery.users});
					});
				*/	
				
					$('#btn_edit_gallery').click(function(){
						$('#frm_btn').attr('action', '/spo_review/edit');
						$('#frm_btn').submit();
					});
				
					
					
		
			</script>

 
   
	
			
			
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		
	</section><!-- 기본틀 2 -->
	
</section><!-- 기본틀 1 -->
	
<jsp:include page="../../layout/right_side.jsp">
	<jsp:param value="right_side" name="right_side" />
</jsp:include>

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