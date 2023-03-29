<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="운동후기게시판" name="title" />
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
	    width: 50%;
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
		
		
		
		<div class="first_div"> <!-- 여기부터 각자 내용 넣기 시작 -->
			<div class="my_porters_area">
			<c:if test="${loginUser.id == null}" >						
				<h2>SPORTERS 멤버들의 활동 후기입니다. 우리와 함께해요!</h2>						
			</c:if>	
			
			<c:if test="${loginUser.id != null}" >		
			
				<form id="frm_searchs" method="post">										
						<br>
							
						<h2> 작성 가능한 후기 </h2>
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
								
								<c:if test="${totalCount eq 0}">	
									<div>
										<span>활동하신 내역이 없습니다. 주저말고 모임에 참여해보세요!</span>
									</div>
								</c:if>	
								
								<c:forEach items="${LocalgalleryList}" var="gallery" varStatus="vs">
									<c:if test="${loginUser.userNo eq gallery.userNo}" >	
										<div class="div_items">			
											<span class="span_title"><a id="moveDetail"
												href="/spo_review/increase/hit?localBoardNo=${gallery.localBoardNo}">${gallery.title}</a></span>									
											<span class="span_nickname">${gallery.users.nickname}</span>							
											<span class="span_gender">${gallery.users.gender}</span>	
											<span class="span_view">${gallery.hit}</span>						
											<span class="span_date">${gallery.createDate}</span>
										</div>	
									</c:if>		
								</c:forEach>
								
								
							</div>
							
						</div>
						
					</form>
					
					<div style="border-top: 1px solid black; text-align: center; line-height: 35px;"></div>
					
				
					<div class="div_paging">
						${paging}
					</div>	
				</c:if>			
			</div>
			
			
			<hr><br>
			<div class="spo_review_area">
				<h2>SPORTERS 활동후기</h2>
				<form id="frm_search" method="post">										
					<br>
					
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
							<c:forEach items="${SpoReviewgalleryList}" var="gallery" varStatus="vs">
								<div class="div_items">			
									<span class="span_title"><a id="moveDetail"
										href="/latterSpo_review/increase/hit?spoReviewNo=${gallery.spoReviewNo}">${gallery.title}</a></span>									
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
			</div>
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		
	</section><!-- 기본틀 2 -->	
</section><!-- 기본틀 1 -->
</body>
</html>