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
				<h1 class="content_title_area_left">${SpoReviewgalleryList.title}</h1>
					<div class="content_title_area_right">
						<div>
							<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO3VO2tVQRSG4UeJB0SCWHkpghgE4wXEQrCwFgsLQdAg+gO0EkRstEsl+AckQRGsLAyBWBi1EwvRaJ14aQQVFK+JGohs+AKHw7klc9L5wWaYvdbMO7NmrRn+axW1FpvS9lwHMI45LKa9h/29ApzEb3zHKK5gDD8wjxOlgF2ZaBo7GmyDeJVd7SyBjAYy1MK+O7u8UQJ5i8kOPvfxugTyJfFvpzF8LoE8x5MOPk/xrARyKSl7vIX9WOwXSyDr8TLhONVgG87/6fgVaWvCtphEmEpb9V9gSylgM27iTyb9iln8Sv8vbmNb3ZgaruNdMnOgHeAQPqbYrqUm6rUnk1V18gmHAxjPAh7hZ9qm2ptVz7QpxCXtw5tcO48DuBzbXXzTROty2B+wXXcaSujqAaexgDvNBpyJ89kuAbW6EDUCqhra2GzQA7zv8s2orQSwJodVZVQn9a0EUKk/KXqhC8jBAEaWA1iuzgdyBOdWA1DpViBLX3VJVu9/T/UQE7iKo9jQyvMfsCVuvY9ZWbgAAAAASUVORK5CYII="></span>
							<span>${SpoReviewgalleryList.users.nickname}</span>
						</div>
					</div>
				</div>
			</div>
				<div style="text-align: right;">	
					<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAABhUlEQVR4nM3TPUjWURgF8F9fhH0MFULQZhRFiw3hUkNCgUtQWwUtQR+QOAYaEi0KKbo0FUQQmUVLBEUUREURRUM0NOagVEsfFtoXxoUjvLwovr01eJb//3LvPc/znHMu8wSbsf5/EB3HG0zg7r+SHcZPdGEk37qxGz9wBI0YxdF6iJZjHz6jFw14ghf5rwlLcSwaTWIKQ1iEG1mfwYJayBrwAJ9wMeI/TJF+fMQpjONWxp8VC3Edb9GEO3F0NU7gO3bm7Ea8xBj2z9ZtXzrYgvN4H+I9cfdQ1fnS9elM8RwdWFyZr9JBKzrxDS3Yhq/oriBaU0XchHN4NL23IgTFiAP4hb0p8iFdn0yH1/DaHFiF3xiMqx25XIoMYBjPEubb2KoG9CYOg9GmZO1prdGYCcNxtYh6Ge/wBfexQx0YQw8uhKgZG3A1ctyriEzlK2pLLs9GnmVlY23GnUq2tlddLDG6kuiMRo5X0XsCj3ETl7CyXFgSRzfNMcU6HIzj7dj1N+95/uAP1/ReFe34fBUAAAAASUVORK5CYII="> 작성일 <fmt:formatDate value="${SpoReviewgalleryList.createDate}" pattern="yy/M/d"/></span>
					&nbsp;&nbsp;&nbsp;
					<span><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA3UlEQVR4nN3Tv0oDMRwH8A/VpeoulHYR8QUEX8A3KHZxdBAX/4y6dfQpxEUdO3SrUNBBER0c+xK+gxwkcMNdk6M3iF8IIbnwIckvx3/MHo6x3QY2wguu8IX9VbAjzLEVxv2AHrSBWQUd4RmbNd/7+Ax91s6WYTEnONMSto5p6thNsCecp7AF7tHJwC5SBZhhAze4q0HX8JjCBngNWEwVGrFLiRzitmL+uoRmY0W6eKupVkQfwm+XnR4+KtCiAN9NsF2chjbGT7jwODfBe2lcvISl2SktzmnDJsf+W/kFReEspVxuLHYAAAAASUVORK5CYII="> 수정일 <fmt:formatDate value="${SpoReviewgalleryList.modifyDate}" pattern="yy/M/d"/></span>
				</div>
			


			<div class="div_btns">
				<form id="frm_btn" method="post">				

			<hr>
	
			<div>
				${SpoReviewgalleryList.content}
			</div>
			<p>${SpoReviewgalleryList.users.id}
			
			
				<span>작성자  ${SpoReviewgalleryList.users.nickname}</span>
			</p>
			<div>
				<form id="frm_btn" method="post">	
					

					<input type="hidden" name="spoReviewNo" value="${SpoReviewgalleryList.spoReviewNo}">
					<c:if test="${loginUser.id == SpoReviewgalleryList.users.nickname}" >
						<span><input type="button" value="수정" id="btn_edit_gallery"></span>
						<span><input type="button" value="삭제" id="btn_remove_gallery"></span>
						<span><input type="button" value="목록" onclick="location.href='/free/list'"></span>				
					</c:if>
				</form>
			</div>
	
		   

			<div class="div_content">
				<div class="div_content_text">
					<span>${SpoReviewgalleryList.content}</span>
				</div>
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
					$('#btn_remove_gallery').click(function(){
						if(confirm('게시글을 삭제하시겠습니까?')){
							$('#frm_btn').attr('action', '/spo_review/remove');
							$('#frm_btn').submit();
						}
					});
					
					
					
		
			</script>

   <!-- 댓글영역 -->
   
	<span id="btn_comment_list">
		<span>댓글</span>
		<span id="comment_count"></span>
		<span>개</span>
	</span>
	
	
	<hr>
	
	<div id="comment_area" class="blind">
		<div id="comment_list"></div>
		<div id="paging"></div>
	</div>
   
   <!-- name="content", name="freeNo" 을 form 안에 넣은 이유 ? serialize()로 보내기 위해서 -->
   <!-- serialize()하면 form안에 있는 모든 name을 넘겨준다 -->
	<c:if test="${loginUser.id != null}">
	<div>
		<form id="frm_add_comment">
			<div class="add_comment">
				<div class="add_comment_input">
					<span>${loginUser.nickname}</span>
					<input type="text" name="commContent" id="comment" class="input_comment">
				</div>
				<div class="add_comment_btn">
					<input type="button" value="작성완료" id="btn_add_comment">
				</div>
			</div>
			<input type="hidden" name="spoReviewNo" value="${SpoReviewgalleryList.spoReviewNo}">
		</form>
	</div>
	</c:if>		
		<c:if test="${loginUser.id == null}">
		<div>
			<div class="unlogin_comment">
				<span></span>
				<input type="text" name="commContent" id="content" placeholder="댓글을 작성하려면 로그인 해 주세요" readonly="readonly">
			</div>
		</div>
	</c:if>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	   <script>
	   
		// 함수 호출
		fn_commentCount();
		// fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
		fn_addReply();
	      
	      // 함수 정의
	      function fn_commentCount(){
	         $.ajax({
	            type: 'get',
	            url: '/gallerySpoComm/getCount', 
	            data: 'spoReviewNo=${SpoReviewgalleryList.spoReviewNo}',   // 글번호 달아줌
	            dataType: 'json',
	            success: function(resData){  // resData = {"commentCount": 개수}
	               $('#comment_count').text(resData.commentCnt);
	            }
	         });
	      }
	      
	      function fn_switchCommentList() {
	         $('#btn_comment_list').click(function() {
	            $('#comment_area').toggleClass('blind');   // 토글을 줬다가 뺐다가
	         });
	      }
	      
		function fn_addComment(){
			$('#btn_add_comment').click(function(){
			//	alert('test');
				if($('#comment').val() == ''){
					alert('댓글 내용을 입력하세요');
               		return; // ajax 실행 막음
            	}
				$.ajax({
					type: 'post',
					url: '/gallerySpoComm/add',
					data: $('#frm_add_comment').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#comment').val('');
							fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
							fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
						}
					}
				});
			});
		}
	      
	      function fn_commentList(){
	         $.ajax({
	            type: 'get',
	            url: '/gallerySpoComm/list',
	            data: 'spoReviewNo=${SpoReviewgalleryList.spoReviewNo}&page=' + $('#page').val(),   // 현재 page도 넘겨줘야 함
	            dataType: 'json',
	            success: function(resData){
	               /*
	                  resData = {
	                     "commentList": [
	                        {댓글하나},
	                        {댓글하나},
	                        ...
	                     ],
	                     "pageUtil": {
	                        page: x,
	                        ...
	                     }
	                  }
	               */
	               // 화면에 댓글 목록 뿌리기
	               $('#comment_list').empty();   // 목록 초기화 필수
	               $.each(resData.SpocommentList, function(i, comment){
	                  // 댓글 depth: 0 이면 들어갈 필요 없고, 대댓 depth: 1 이면 한칸 들어가야 함, 1단이면 그룹오더 필요x
						var div = '';
						if(comment.depth == 0){
							div += '<div>';
						} else {
							div += '<div style="margin-left: 40px;">';
						}
	                  if(comment.state == 1) {   // state:1 정상, state:-1은 삭제라서 보여주면 x
	                     div += '<div>'
	                     div += '<span>작성자 : </span>'+   '<span>'+ comment.users.nickname + '</span>' + '<span>&nbsp;▶&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+ comment.commContent + '</span>' ;
	                   //  div += comment.commContent;   // 정상일 때 내용 보여줌
	                     // 작성자, 로그인 유저만 댓글 삭제, 대댓글 가능
	                     if(${loginUser.id == 'admin'}) {
								div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.spoCoNo + '">';
							} else if ('${loginUser.id}' == comment.users.id){
								div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.spoCoNo + '">';
							}
	                     /*
							if(comment.commDepth == 0) {
							}if ('${loginUser.id}' == comment.users.id){
								div += '<input type="button" value="답글" class="btn_reply_area">';
							}
							*/
							div += '</div>';
						} else {
							if(comment.commDepth == 0) {
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div>삭제된 답글입니다.</div>';
							}
						}
	                  // 날짜 형식 지정하는 자바스크립트 (moment-with-locales.js)
						div += '<div>';
						// moment.locale('ko-KR');
						// div += '<span style="font-size: 12px; color: silver;">' + moment(comment.commDate).format('YYYY. MM. DD hh:mm') + '</span>';
						div += '</div>';
						div += '<div style="margin-left: 40px;" class="reply_area blind">';
						div += '<form class="frm_reply">';
						div += '<input type="hidden" name="spoCoNo" value="' + comment.spoCoNo + '">';
						div += '<input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
						div += '<input type="hidden" name="spoReviewNo" value="' + comment.spoReviewNo + '">';
						div += '<input class="input_comment" type="text" name="commContent" placeholder="답글을 작성하려면 로그인을 해주세요">';
						// 로그인한 사용자만 볼 수 있도록 if 처리
						div += '<input type="button" value="답글작성완료" class="btn_reply_add">';
						div += '</form>';
						div += '</div>';
					//	div += '</div>';
						$('#comment_list').append(div);
						$('#comment_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
					});
	               // 페이징
	               $('#paging').empty(); // 초기화
					var pageUtil = resData.galleryPageUtil;
					var paging = '';
	               
	               // 이전 블록
						if(pageUtil.beginPage != 1) {
							paging += '<span class="enable_link" data-page="'+ (pageUtil.beginPage - 1) +'">◀</span>';
	                  // 태그를 클릭하면 몇 페이지로 가는 링크인지 넣자
	               }
						// 페이지번호
						for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
							if(p == $('#page').val()){
								paging += '<strong>' + p + '</strong>';
							} else {
								paging += '<span class="enable_link" data-page="'+ p +'">' + p + '</span>';
							}
						}
	               // 다음 블록
	              if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="enable_link" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
					}
					$('#paging').append(paging); // 페이지 뿌림
	            }
	         }); 
	      } // fn_commentList()
	      
			function fn_changePage(){
	         // $(만들어져있었던 부모).on('click', '.enable_link', (function() {  //  $('.enable_link').click(function() 만든 아이는 직접 볼 수 없다. 만들어져 있는 애만 직접 볼 수 있다.
	         $(document).on('click', '.enable_link', function() {
	            $('#page').val( $(this).data('page') );   // page value값이 fn_commentList() 할 때마다 넘어감 => $('#page').val 값을 바꿔서 다시 요청
	            fn_commentList();   // 목록을 다시 가져와라
	         });
	      }
	         
	      function fn_removeComment() {
	         $(document).on('click', '.btn_comment_remove', function(){
	               if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')) {
	                  $.ajax({
	                     type: 'post',
	                     url: '/gallerySpoComm/remove',
	                     data: 'spoCoNo=' + $(this).data('comment_no'), // 코멘트 번호에 삭제버튼 넣어놨음
	                     dataType: 'json',
	                     success: function(resData) {   // resData = {"isRemove" : true}
	                        if(resData.isRemove) {
	                           alert('댓글이 삭제되었습니다.');
	                           fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
	                           fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
							}
							}
						});
					}
				});
			}
	
	    
	      function fn_addReply(){
				$(document).on('click', '.btn_reply_add', function(){
					$(this).parent().next().next().toggleClass('blind');
				
					if($(this).prev().val() == ''){
						alert('답글 내용을 입력하세요.');
						return;
					}
					console.log("아:"+ $(this).closest('.frm_reply').serialize());
					$.ajax({
						type: 'post', 
						url: '/gallerySpoComm/reply/add',
						data: $(this).closest('.frm_reply').serialize(),  // 이건 안 됩니다 $('.frm_reply').serialize(),
						dataType: 'json',
						success: function(resData){  // resData = {"isAdd", true}
							if(resData.isAdd){
								alert('답글이 등록되었습니다.');
								fn_commentList();
								fn_commentCount();
							}
						}
					});
				});
			}
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