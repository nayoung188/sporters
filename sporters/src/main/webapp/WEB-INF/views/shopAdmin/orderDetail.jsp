<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="쇼핑몰주문상세" name="title" />
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

th {
	height:35px;
	background-color: #8c8cff;
	color: #fff;
}

td {
	height: 50px;
	border-bottom: 1px solid #D2D2FF;
}

.center_td {
	text-align: center;
}

.column_info {
	height:35px;
	background-color: #c8c8ff;
	color: #fff;
	text-align: center;
}

.column_info td {
	height:20px;
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
				<h2>주문상세</h2>
				<span>주문 상세정보를 볼 수 있습니다.</span>
			</div>
			<div class="btn_wrap">
				<form id="frm_btn" method="post">
					<input type="hidden" name="orderNo" value="${order.orderNo}">
					<input type="button" class="button" value="목록" onclick="location.href='/shopAdmin/orderManage'">
				</form>
			</div>
			<div class="table_wrap">
				<table>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<thead>
						<tr>
							<th colspan="2">주문정보</th>
						</tr>
						<tr class="column_info">
							<td>주문번호</td>
							<td>주문일자</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="center_td">${order.orderNo}</td>
							<td class="center_td">${order.orderDate}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="table_wrap">
			<table>
				<thead>
					<tr>
						<th colspan="3">구매상품목록</th>
					</tr>
					<tr class="column_info">
						<td>상품명</td>
						<td>소비자가격</td>
						<td>할인가격</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderInfo}" var="oi">
						<tr>
							<td class="center_td">${oi.product.prodName}</td>
							<td class="center_td">${oi.product.price}</td>
							<td class="center_td">${oi.product.discount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="table_wrap">
			<table>
				<colgroup>
					<col width="30%">
					<col width="30%">
					<col width="40%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="3">유저정보</th>
					</tr>
					<tr class="column_info">
						<td>주문인</td>
						<td>수령인</td>
						<td>수령인 연락처</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center_td">${order.users.name}</td>
						<td class="center_td">${order.name}</td>
						<td class="center_td">${order.mobile}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="table_wrap">
			<table>
				<thead>
					<tr>
						<th colspan="4">배송주소</th>
					</tr>
					<tr class="column_info">
						<td>우편번호</td>
						<td>도로명주소</td>
						<td>지번주소</td>
						<td>상세주소</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center_td">${order.postcode}</td>
						<td class="center_td">${order.roadAddress}</td>
						<td class="center_td">${order.jibunAddress}</td>
						<td class="center_td">${order.detailAddress}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>