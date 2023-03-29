<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="Sporters 신고관리" name="title" />
</jsp:include>
<jsp:include page="adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
<style>

.in_wrap {
	position: relative;
}
.title_wrap {
	position: absolute;
}
.search_wrap {
	position: absolute;
    right: 50px;
    top: 15px;
}
h2 {
	font-size: 30px;
}

#query {
	width: 300px;
    height: 25px;
    border-radius: 12px;
}
#column {
	width: 130px;
    height: 30px;
    border-style: groove;
    border-radius: 12px;
    border-width: initial;
    margin-right: 4px;
    padding-left: 3px;
}

/* table */
.singo_list {
	width:1000px;
	border: 2px solid #8c8cff;
	border-radius: 10px;
	margin: 0 auto;
	margin-top: 50px;
}

/* button */
.button{
  	background:#8c8cff;
  	color:#fff;
  	border:none;
  	position:relative;
  	height:31px;
  	font-size:18px;
  	padding:0 2em;
  	cursor:pointer;
  	transition:800ms ease all;
  	outline:none;
  	vertical-align: bottom;
}
.button:hover{
  	background:#fff;
  	color:#8c8cff;
}
.button:before, .button:after{
  	content:'';
  	position:absolute;
  	top:0;
  	right:0;
  	height:2px;
  	width:0;
  	background: #c8c8ff;
  	transition:400ms ease all;
}
.button:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
.button:hover:before, .button:hover:after{
  	width:100%;
  	transition:800ms ease all;
}

table {
	width:1000px;
	border-collapse: collapse;
}

th {
	height:35px;
	background-color: #8c8cff;
	color: #fff;
}

td {
	height:50px;
	border-bottom: 1px solid #D2D2FF;
	text-align: center;
}

.center_td {
	text-align: center;
}

.go_detail {
	color: #8C8CFF;
}
.go_detail:hover{
	color: #D2D2FF;
}
/* page */
.now_page{
	border: none;
	display:inline-block;
	width: 25px;
	height:25px;
	line-height: 25px;
	background-color: #8C8CFF;
	color : white;
	text-align: center;
	text-decoration: none;
	
}
tfoot td {
	text-align: center;
}

tfoot a {
	color:#8C8CFF;
	width:25px;
	height:25px;
	margin:0 5px;
}

/* button */
button {
	width: 50px;
    height: 25px;
    background-color: #c8c8ff;
    border: none;
    border-radius: 5px;
    margin-left: 3px;
    color: #fff;
}

.menu a{
	cursor:pointer;
	}
#addCategory{
	display: none;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	}
</style>
<script>
$('.admin').addClass('checked');

$(document).ready(function(){
    // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
    $("a").click(function(){
        var submenu = $(this).next("#addCategory");

        // submenu 펼치기
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
        }
    });
});

	$(window).on('load', function(){
		fn_getCategoryList();
	});
	
	function fn_getCategoryList() {
		$.ajax({
			type: 'get',
			url : '/admin/getCategoryList',
			dataType : 'json',
			success : function(resData) {
				$('#categoryList').empty();
				$.each(resData, function(i, data){
						$('<tr>')
					  	.append($('<td>').text(data.singoCategoryNo))
					  	.append($('<td>').text(data.singoCategoryName))
					  	.append($('<td><a style="display:block;" href="/admin/removeCategory?singoCategoryNo='+data.singoCategoryNo+'"><i class="fa-sharp fa-solid fa-trash"></i></a>'))
					  	.appendTo('#categoryList');
				});
			}
		});
	};
	
	
	$(function(){
	
		$('#addCategoryFrm').submit(function(){
			
			// 만약 빈칸이라면 submit 방지
			if($('#categoryName').val() == '') {
				alert('카테고리 이름을 입력해주세요.');
				event.preventDefault();
				return;
			}
			
			$.ajax({
				type: 'post',
				url : '/admin/addCategory',
				data: 'categoryName=' + $('#categoryName').val(),
				success : function() {
					alert('성공적으로 카테고리가 추가되었습니다.');
				}
			});
			
		});
		
		
	});
</script>
<body>
<div class="body_wrap">
	<div class="code_wrap">
	<div class="in_wrap">
<a>▩▩▩카테고리 관리▩▩▩</a>
<section id="addCategory">
<form id="addCategoryFrm" method="get" >
<br>
	<label for="categoryName">카테고리 이름</label>
	<input type="text" id="categoryName">
	<button>Add</button>
</form>
<br>

<table class="tbl">
	<thead>
		<tr>
			<td>카테고리 번호</td>
			<td>카테고리 이름</td>
			<td>삭제</td>
		</tr>
	</thead>
	<tbody id="categoryList">
	
	</tbody>
	<tfoot>
		<tr>
			<td colspan="5" style="text-align: center;">
				${paging}
			</td>
		</tr>
	</tfoot>
</table>
</section>
<br>
<section class="singo_list">
	<table class="tbl">
		<thead>
			<tr>
				<th>신고글번호</th>
				<th>신고카테고리</th>
				<th>원글제목</th>
				<th>신고링크</th>
<!-- 				<th>작성자ID</th> -->
				<th>신고기타</th>
				<th>원글작성일</th>
<!-- 				<th>삭제비고란</th> -->
<!-- 				<th>삭제일</th> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${singoList}" var="singo" varStatus="vs">
				<tr>
					<td>${singo.singoNo}</td>
					<td>${singo.singoCategory}</td>
					<td>${singo.singoTitle}</td>
					<td><a href='${singo.singoLink}'>${singo.singoLink}</a></td>
<%-- 					<td>${singo.id}</td> --%>
					<td>${singo.singoUserReason}</td>
					<td>${singo.singoCreateDate}</td>
<%-- 					<td>${singo.singoReason}</td> --%>
<%-- 					<td>${singo.singoRemoveDate}</td> --%>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" style="text-align: center;">
						${paging}
				</td>
			</tr>
		</tfoot>
	</table>
</section>
	</div>
</div>
</div>
</body>
</html>