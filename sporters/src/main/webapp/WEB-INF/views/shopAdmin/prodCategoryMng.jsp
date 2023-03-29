<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="Sporters 쇼핑몰 관리자페이지" name="title" />
</jsp:include>
<jsp:include page="../admin/adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
<style>

h2 {
	font-size: 30px;
}

.input_cate {
	width: 320px;
	height: 25px;
	font-size: 20px;
	margin-top: 6px;
}

.tbl_wrap {
	width:1000px;
	border: 2px solid #8c8cff;
	border-radius: 10px;
	margin: 0 auto;
	margin-top: 50px;
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
}

.center_td {
	text-align: center;
}

button{
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
button:hover{
  	background:#fff;
  	color:#8c8cff;
}
button:before,button:after{
  	content:'';
  	position:absolute;
  	top:0;
  	right:0;
  	height:2px;
  	width:0;
  	background: #c8c8ff;
  	transition:400ms ease all;
}
button:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
button:hover:before,button:hover:after{
  	width:100%;
  	transition:800ms ease all;
}

.fa-trash {
	text-align: center!important;
}

#category_head {
	margin: 0 auto;
	position: relative;
}
.cate_add_frm {
	display: inline-block;
    width: 650px;
    position: absolute;
    top: 105px;
    right: -153px;
}
.cate_info {
	font-size: 12px;
    margin-right: 160px;
}
#addCategoryFrm {
	text-align: right;
	margin-right: 180px;
}
#cate_add_title {
	margin-right: 10px;
    font-size: 18px;
}
.cate_list_frm {
	margin-top: 30px;
}
</style>
<body>
<script>
	// shopAdmin css
	$('.shopAdmin').addClass('checked');

	$(window).on('load', function(){
		fn_getCateList();
	});
	
	function fn_getCateList() {
		$.ajax({
			type: 'get',
			url : '/shopAdmin/getCategoryList',
			dataType : 'json',
			success : function(resData) {
				$('#categoryList').empty();
				$.each(resData, function(i, data){
						$('<tr>')
					  	.append($('<td class="center_td">').text(data.prodCategoryNo))
					  	.append($('<td class="center_td">').text(data.prodCategoryName))
					  	.append($('<td class="center_td"><a style="display:block;" href="/shopAdmin/categoryRemove?prodCategoryNo='+data.prodCategoryNo+'"><i class="fa-sharp fa-solid fa-trash"></i></a>'))
					  	.appendTo('#categoryList');
				});
			}
		});
	};
	
	
	$(function(){
	
		$('#addCategoryFrm').submit(function(){
			
			// 만약 빈칸이라면 submit 방지
			if($('#cateName').val() == '') {
				alert('카테고리 이름을 입력해주세요.');
				event.preventDefault();
				return;
			}
			
			$.ajax({
				type: 'post',
				url : '/shopAdmin/categoryAdd',
				data: 'cateName=' + $('#cateName').val(),
				success : function() {
					alert('성공적으로 카테고리가 추가되었습니다.');
				}
			});
			
		});
		
	});
</script>
<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<div class="cate_head">
				<h2>카테고리 관리</h2>
				<span>상품 판매 카테고리를 관리합니다.</span>
				<div class="cate_add_frm">
					<form id="addCategoryFrm" method="get">
						<span id="cate_add_title">카테고리 추가하기</span>
						<label for="cateName" class="label_cate_input"><span class="cate_info">카테고리 이름을 입력하세요.</span></label><br>
						<input type="text" id="cateName" class="input_cate">
						<button>ADD</button>
					</form>
				</div>
			</div>
			
			<hr>
			<div>
				<div class="cate_list_frm">
					<div class="tbl_wrap">
						<table>
							<colgroup>
									<col style="width:15%">
									<col style="width:70%">
									<col style="width:15%">
								</colgroup>
							<thead>
								<tr>
									<th>카테고리 번호</th>
									<th>카테고리 이름</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody id="categoryList">
							
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>