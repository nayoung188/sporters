<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters쇼핑몰페이지" name="title" />
</jsp:include>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

</script>
<body>
<div>
	<div>
		<table>
			<thead>
				<tr>
					<td>주문번호</td>
					<td>카트번호</td>
					<td>주문자 정보</td>
					<td>수령인</td>
					<td>수령자 번호</td>
					<td>결제가격</td>
					<td>배송상태</td>
					<td>주문날짜</td>
					<td>상세보기</td>
					<td>주문상태</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderList}" var="order">
					<tr>
						<td>${order.cartBundle}</td>
						<td>${order.orderNo}</td>
						<td>${name}</td>
						<td>${order.name}</td>
						<td>${order.mobile}</td>
						<td>${order.priceAll} 원</td>
						<td>${order.orderState}</td>
						<td>${order.orderDate}</td>
						<td><a href="/shop/order/detail?orderNo=${order.orderNo}">상세보기</a></td>
						<td>${order.orderState}</td>
						
					</tr>
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
</body>
</html>