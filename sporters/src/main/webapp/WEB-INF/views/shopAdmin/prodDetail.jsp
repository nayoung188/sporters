<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="쇼핑몰상품관리-상세${product.prodName}" name="title" />
</jsp:include>
<jsp:include page="../admin/adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script>
	$('.shopAdmin').addClass('checked');
</script>
<style>
.in_wrap {
	position: relative;
}
.title_wrap {
	position: absolute;
}
h2 {
	font-size: 30px;
}
.btn_wrap {
	position: absolute;
    right: 50px;
    top: 15px;
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
  	width:80%;
  	transition:800ms ease all;
}
/* pink button */
.pink_button {
  	background:#F09494;
  	color:#fff;
  	border:none;
  	position:relative;
  	display: inline-block;
    height: 30px;
    line-height: 30px;
  	font-size:18px;
  	padding:0 2em;
  	cursor:pointer;
  	transition:800ms ease all;
  	outline:none;
  	vertical-align: bottom;
  	margin-left: 847px;
    margin-bottom: 9px;
}
.pink_button:hover{
  	background:#fff;
  	color:#F09494;
}
.pink_button:before, .pink_button:after{
  	content:'';
  	position:absolute;
  	top:0;
  	right:0;
  	height:2px;
  	width:0;
  	background: #FFC8C8;
  	transition:400ms ease all;
}
.pink_button:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
.pink_button:hover:before, .pink_button:hover:after{
  	width:100%;
  	transition:800ms ease all;
}
/* table */
.table_wrap {
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

td {
	height: 50px;
	border-bottom: 1px solid #D2D2FF;
}

.center_td {
	text-align: center;
}

/* 요소 제목 */
.prod_title {
	font-size: 20px;
	background-color: #c8c8ff;
}
#prodNo {
	border-radius: 8px 0 0 0;
}
/* 요소 내용 */
.prod_elm {
	padding-left: 15px;
}
#prod_content {
	border-bottom: none;
	padding: 30px;
}
</style>
<body>
<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<div id="title_wrap">
				<h2>상품 상세보기</h2>
				<span>상품 정보를 불러올 수 있습니다.</span>
			</div>
			<div class="btn_wrap">
				<form id="frm_btn" method="post">
					<input type="hidden" name="prodNo" value="${product.prodNo}">
					<input type="button" class="button" value="목록" onclick="location.href='/shopAdmin/prodManage'">
					<input type="button" class="button" value="상품수정" id="btn_edit_prod">
				</form>
			</div>
			<hr>
			
			<div class="table_wrap">
				<table>
					<tbody>
						<tr>
							<td class="prod_title center_td" id="prodNo">상품번호</td>
							<td class="prod_elm">${product.prodNo}</td>
						</tr>
						<tr>
							<td class="prod_title center_td">상품명</td>
							<td class="prod_elm">${product.prodName}</td>
						</tr>
						<tr>
							<td class="prod_title center_td">대표사진(썸네일)</td>
							<td class="prod_elm"><img src="/shopAdmin/prod/display?prodNo=${product.prodNo}" width="500px" class="attach_img" alt="thumbnail_img" title="${prod.filesystem}"></td>
						</tr>
						<tr>
							<td class="prod_title center_td">카테고리</td>
							<td class="prod_elm">${product.prodCategory.prodCategoryName}</td>
						</tr>
						<tr>
							<td class="prod_title center_td">가격</td>
							<td class="prod_elm">${product.price}</td>
						</tr>
						<tr>
							<td class="prod_title center_td">할인가격</td>
							<td class="prod_elm">${product.discount}</td>
						</tr>
						<tr>
							<td class="prod_title center_td">재고</td>
							<td class="prod_elm">${product.stock}</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" id="prod_content">
								${product.prodContent}
							</td>
						</tr>
					</tfoot>
				</table>
				<hr>
				<div>
					<input type="button" id="btn_remove_prod" class="pink_button" value="상품삭제">
				</div>
			</div>
		</div>
	</div>
</div>
<script>
		$('#btn_edit_prod').click(function(){
			$('#frm_btn').attr('action', '/shopAdmin/prod/edit');
			$('#frm_btn').submit();
		});
		$('#btn_remove_prod').click(function(){
			if(confirm('상품을 삭제하게 되면 다시 되돌리거나 확인할 수 없습니다. 상품을 삭제하시겠습니까?')){
				$('#frm_btn').attr('action', '/shopAdmin/prod/remove');
				$('#frm_btn').submit();
			}
		});
</script>
</body>
</html>