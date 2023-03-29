<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
	.wrap {
		font-family: 'Noto Sans KR', sans-serif;
	}

	/* 버튼 */
	
	.div_btns{
		padding-top: 15px;
	    padding-bottom: 15px;
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
	
	/* 헤더 */
		
	.mapage_div { 
	  position: relative; 
	  font-size: 32px; 
	  font-weight: bold; 
	  text-align: center; 
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
	}
	
	.line_height {
		 line-height: 30px;
	} 
	
	.div_no {
		width: 8%;
	}
	
	.div_title {
		width: 55%;
	}
	
	.div_writer {
		width: 15%;
	}
	
	.div_date {
		width: 18%;
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
			<div class="mapage_div"> QnA </div>
			
			<div class="div_btns">
				<input class="btn purple" type="button" value="질문하기" onclick="location.href='/qna/write'">
			</div>
			
			<div class="div_form">
				<div>			
					<div class="div_head">
						<span class="div_no line_height">번호</span>
						<span class="div_title line_height">제목</span>
						<span class="div_writer line_height">작성자</span>
						<span class="div_date line_height">작성일</span>
					</div>
					<div>
						<c:forEach items="${qna}" var="qna" varStatus="vs">
							<div class="div_items">
								<span class="div_no hover">${beginNo - vs.index}</span>
								<c:if test="${qna.isPw == 1}">
									<span class="div_title hover"><i class="fa-solid fa-lock"></i><a href="/qna/lock?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a></span>
								</c:if>
								<c:if test="${qna.isPw == 0}">
									<span class="div_title hover"><a href="/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a></span>
								</c:if>
								<span class="div_writer hover">${qna.qnaId}</span>
								<span class="div_date hover">${qna.qnaCreateDate}</span>
							</div>
						</c:forEach>
					</div>
					
					<div style="border-top: 1px solid black; text-align: center; line-height: 35px;">
						<span>
							${paging}
						</span>
					</div>						
				</div>
			</div>
		</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->

</body>
</html>