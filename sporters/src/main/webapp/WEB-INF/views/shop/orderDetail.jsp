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
<div class="body_wrap">
	<div class="code_wrap">
		<table>
			<tbody>
				<tr>
					<td>주문번호 :&nbsp;</td>
					<td>${order.orderNo}</td>
				</tr>
			</tbody>
		</table>
		<table>
			<tbody>
				<tr>
					<td>주문일자 :&nbsp;</td>
					<td>${order.orderDate}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<table>
			<thead>
				<tr>
					<td colspan="3">구매상품목록</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderInfo}" var="oi">
					<tr>
						<td>상품명 : </td>
						<td>${oi.product.prodName}</td>
					</tr>
					<tr>
						<td>상품원가 : </td>
						<td>${oi.product.price}</td>
					</tr>
					<tr>
						<td>할인가 : </td>
						<td>${oi.product.discount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div>
		<table>
			<thead>
				<tr>
					<td colspan="3">유저정보</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>주문인 : ${name}</td>
					<td>수령인 : ${order.name}</td>
					<td>수령인 연락처 : ${order.mobile}</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div>
		<table>
			<thead>
				<tr>
					<td colspan="4">배송주소</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>우편번호 : ${order.postcode}</td>
					<td>도로명주소 : ${order.roadAddress}</td>
					<td>지번주소 : ${order.jibunAddress}</td>
					<td>상세주소 : ${order.detailAddress}</td>
				</tr>
			</tbody>
		</table>
	</div>
	

</div>
</body>
</html>