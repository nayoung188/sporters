<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="지역별게시판" name="title" />
</jsp:include>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	.wrap {
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	.first_div {
		width: 70%;
		margin: auto;
	}
	
	.div_form {
		margin: auto;
   		width: 100%;
		border-radius: 4px;
	}
	
	.div_head{
		 background: #8c8cff; 
		 border-radius: 4px;
		 color: white;
	}
	
	span {
		display: inline-block;
		text-align: center;
		line-height: 30px;
	}
	
		.span_title{
		width: 40%;
	}
	.span_id{
		width: 10%;
	}
	
	.span_nickname {
		width: 15%;
	}
	
	.span_gender {
		width: 5%;
	}
	
	.span_view {
		width: 10%;
	}
	
	.span_date {
		width: 15%;
	}
	
	.div_paging {
		text-align: center;
		margin-top: 3%;
	}
	
	.div_items{
		margin-bottom: 10px;
		margin-top: 10px;
		padding-bottom: 5px;
	}
	
	.div_items:hover{
		/*background-color: #f0f0ff;*/
		background-color: rgba(240, 240, 255, 0.5);
	}
</style>


<body>
<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
	<div class="first_div">
		<c:if test="${loginUser.id == null}" >	
			<div class="no_login"  style="text-align: right;"><a href="#none">글쓰러가기</a></div>
		</c:if>
		<c:if test="${loginUser.id != null}" >	
			<div  style="text-align: right;"><a href="/local/write">글쓰러가기</a>  </div>
		</c:if>
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			
			<form id="frm_search" method="post">										

				<div class="div_form">
					<div>
						<div class="div_head">	
							<span class="span_title">제목</span>													
							<span class="span_nickname">닉네임</span>
							<span class="span_gender">성별</span>	
							<span class="span_view">조회수</span>						
							<span class="span_date">작성일</span>												

						<!--  
							<td>작성 글 수</td>
						-->				
						</div>
					</div>
					<div id="list">						
						<c:forEach items="${LocalgalleryList}" var="gallery" varStatus="vs">
							<div class="div_items">
							<!--  
								<td>${beginNo - vs.index}</td>		
							-->				
								<span  class="span_title"><a id="moveDetail"
									href="/local/increase/hit?localBoardNo=${gallery.localBoardNo}">${gallery.title}</a></span>									
							
								<span class="span_nickname">${gallery.users.nickname}</span>							
								<span class="span_gender">${gallery.users.gender}</span>	
								<span class="span_view">${gallery.hit}</span>						
								<span class="span_date">${gallery.createDate}</span>

							</div>
						</c:forEach>
					</div>
					
				</div>
				
			</form>

			<div style="border-top: 1px solid black; text-align: center; line-height: 35px;"></div>
		
			<div class="div_paging">
				${paging}
			</div>
			
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		</div>
	</section><!-- 기본틀 2 -->
	
</section><!-- 기본틀 1 -->
	
<jsp:include page="../../layout/right_side.jsp">
	<jsp:param value="right_side" name="right_side" />
</jsp:include>

<script type="text/javascript">
$(function(){
	
	$('.no_login').click(function(){
		alert('로그인 후 이용해주세요!');
		
	});
	
	
	
	
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