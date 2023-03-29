<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="쇼핑몰주문관리" name="title" />
</jsp:include>
<jsp:include page="../admin/adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script>
	$('.shopAdmin').addClass('checked');
	
	$('#frm_search').submit(function(event){
		if($('#column').val() == '' || $('#query').val() == ''){
			alert('검색 조건을 확인하세요.');
			event.preventDefault();
			return;
		}
	});
	
</script>
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
.tbl_wrap {
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

/* state */
/* 결제완료 */
.os_1 {
	color: #00BFFF;
	font-weight: 700;
}
/* 상품준비중 */
.os_2 {
	color: #FFB400;
	font-weight: 700;
}
/* 배송중 */
.os_3 {
	color: #F08080;
	font-weight: 700;
}
/* 배송완료 */
.os_4 {
	color: #64CD3C;
	font-weight: 700;
}
/* 주문취소 */
.os_5 {
	color: red;
	font-weight: 700;
}
</style>
<body>
<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<div id="title_wrap">
				<h2>주문목록</h2>
				<span>주문 관리 페이지입니다.</span>
			</div>
			<div class="search_wrap">
				<form id="frm_search" action="/shopAdmin/orderSearch">
					<select name="column" id="column">
						<option value="">===선택===</option>
						<option value="ORDER_NO">주문번호</option>
						<option value="NAME">수령인</option>
						<option value="ORDER_STATE">주문상태</option>
					</select>
					<input type="text" name="query" id="query">
					<input type="submit" class="button" value="검색">
				</form>
			</div>
			<hr>
			<div class="tbl_wrap">
				<table>
					<thead>
						<tr>
							<th>주문번호</th>
							<th>주문인</th>
							<th>수령인</th>
							<th>수령인 번호</th>
							<th>결제가격</th>
							<th>배송상태</th>
							<th>주문날짜</th>
							<th>상세보기</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList}" var="order">
							<c:if test="${order.orderState == '결제완료'}">
								<tr>
									<td class="center_td">${order.orderNo}</td>
									<td class="center_td">${order.users.name}</td>
									<td class="center_td">${order.name}</td>
									<td class="center_td">${order.mobile}</td>
									<td class="center_td">${order.priceAll}</td>
									<td class="center_td os_1">${order.orderState}</td>
									<td class="center_td">${order.orderDate}</td>
									<td class="center_td"><a class="go_detail" href="/shopAdmin/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
									<td class="center_td">
										<form action="/shopAdmin/order/state" method="get">
											<input type="hidden" name="orderNo" value="${order.orderNo}">
											<select name="orderState">
												<option value="">===선택===</option>
												<option value="결제완료">결제완료</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
												<option value="주문취소">주문취소</option>
											</select>
											<button>변경</button>
										</form>
									</td>
								</tr>
							</c:if>
							<c:if test="${order.orderState == '상품준비중'}">
								<tr>
									<td class="center_td">${order.orderNo}</td>
									<td class="center_td">${order.users.name}</td>
									<td class="center_td">${order.name}</td>
									<td class="center_td">${order.mobile}</td>
									<td class="center_td">${order.priceAll}</td>
									<td class="center_td os_2">${order.orderState}</td>
									<td class="center_td">${order.orderDate}</td>
									<td class="center_td"><a class="go_detail" href="/shopAdmin/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
									<td class="center_td">
										<form action="/shopAdmin/order/state" method="get">
											<input type="hidden" name="orderNo" value="${order.orderNo}">
											<select name="orderState">
												<option value="">===선택===</option>
												<option value="결제완료">결제완료</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
												<option value="주문취소">주문취소</option>
											</select>
											<button>변경</button>
										</form>
									</td>
								</tr>
							</c:if>
							<c:if test="${order.orderState == '배송중'}">
								<tr>
									<td class="center_td">${order.orderNo}</td>
									<td class="center_td">${order.users.name}</td>
									<td class="center_td">${order.name}</td>
									<td class="center_td">${order.mobile}</td>
									<td class="center_td">${order.priceAll}</td>
									<td class="center_td os_3">${order.orderState}</td>
									<td class="center_td">${order.orderDate}</td>
									<td class="center_td"><a class="go_detail" href="/shopAdmin/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
									<td class="center_td">
										<form action="/shopAdmin/order/state" method="get">
											<input type="hidden" name="orderNo" value="${order.orderNo}">
											<select name="orderState">
												<option value="">===선택===</option>
												<option value="결제완료">결제완료</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
												<option value="주문취소">주문취소</option>
											</select>
											<button>변경</button>
										</form>
									</td>
								</tr>
							</c:if>
							<c:if test="${order.orderState == '배송완료'}">
								<tr>
									<td class="center_td">${order.orderNo}</td>
									<td class="center_td">${order.users.name}</td>
									<td class="center_td">${order.name}</td>
									<td class="center_td">${order.mobile}</td>
									<td class="center_td">${order.priceAll}</td>
									<td class="center_td os_4">${order.orderState}</td>
									<td class="center_td">${order.orderDate}</td>
									<td class="center_td"><a class="go_detail" href="/shopAdmin/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
									<td class="center_td">
										<form action="/shopAdmin/order/state" method="get">
											<input type="hidden" name="orderNo" value="${order.orderNo}">
											<select name="orderState">
												<option value="">===선택===</option>
												<option value="결제완료">결제완료</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
												<option value="주문취소">주문취소</option>
											</select>
											<button>변경</button>
										</form>
									</td>
								</tr>
							</c:if>
							<c:if test="${order.orderState == '주문취소'}">
								<tr>
									<td class="center_td">${order.orderNo}</td>
									<td class="center_td">${order.users.name}</td>
									<td class="center_td">${order.name}</td>
									<td class="center_td">${order.mobile}</td>
									<td class="center_td">${order.priceAll}</td>
									<td class="center_td os_5">${order.orderState}</td>
									<td class="center_td">${order.orderDate}</td>
									<td class="center_td"><a class="go_detail" href="/shopAdmin/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
									<td class="center_td">
										<form action="/shopAdmin/order/state" method="get">
											<input type="hidden" name="orderNo" value="${order.orderNo}">
											<select name="orderState">
												<option value="">===선택===</option>
												<option value="결제완료">결제완료</option>
												<option value="상품준비중">상품준비중</option>
												<option value="배송중">배송중</option>
												<option value="배송완료">배송완료</option>
												<option value="주문취소">주문취소</option>
											</select>
											<button>변경</button>
										</form>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="9" style="text-align: center;">
								${paging}
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>