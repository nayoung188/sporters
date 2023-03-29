<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/button_shop.css">
<jsp:include page="../layout/header.jsp">
   <jsp:param value="Spoters쇼핑몰페이지" name="title" />
</jsp:include>
<script>

   $(function(){
      fn_addCart();
      fn_buy();
   });
   
   function fn_addCart(){
      $('.btn_addCart').click(function(){
         var prodNo = $(this).data('prodno');
         var prodCnt =$(this).prev().prev().children().val();
         var stock = $(this).data('stock');
         var data = {
               prodNo: prodNo,
               prodCnt: prodCnt,
               stock: stock
               };
         $.ajax({
            type: 'get',
            url: '/cartList/sameProdNo',
            data: 'prodNo=' + prodNo,
            dataType: 'json',
            success: function(result){
               if(result.prodNo != true){
                  if(stock >= prodCnt){
                     $.ajax({
                        url: '/shop/addCart',
                        type: 'post',
                        data: data,
                        success: function(result){
                           if(result == 1){
                              alert('카트 담기 성공');
                           } else {
                              alert('로그인하세요!');
                           }
                        },
                        error: function(){
                           alert('카트 담기 실패');
                        }
                     });
                  } else {
                     alert('구매량이 재고량보다 많습니다.');
                  }
               } else {
                  alert('이미 장바구니에 담은 상품입니다.');
               }
            },
            error: function(){
               alert('실패지롱');
            }
         });
      }); 
   }
   
   function fn_buy(){
      $('.btn_buy').click(function(){
         var prodCnt = $(this).data('prodno');
         var stock = $('.stock').val();
         var prodName = $('.prodName').val();
         if(prodCnt > stock) {
            alert('구매량이 재고량보다 많습니다.');
            prodcnt == stock;
         } else {
            if(confirm(prodName + ' \'' + prodCnt + '\'개 구매하시겠습니까?')){
               location.href = '/shop/cart';
            }
         }
      });
   }
   
</script>
<style>
   ul {
      padding: 0;
   }
   li {
      list-style:none;
   }
   a {
      text-decoration:none;
   }
   #paging {
      text-align: center;
   }
   #aside {
      float: left;
      width: 180px;
      height: 500px;
   }
   #aside h3 {
      width: 180px;
      font-size:30px;
      margin-bottom:20px;
      text-align: center; 
      font-weight: bold;
   }
   #aside li {
      font-size:16px;
      text-align:center;
   }
   #aside li a {
      color:#000;
      display:block;
      padding:10px 0;
   }
   #aside li a:hover {
      text-decoration:none;
      background:#eee;
   }
   #title {
      font-size: 24px;
      text-align: center;
   }
   .product {
      display: block;
       width: 225px;
       text-align: center;
       text-decoration:none;
       color: black;
       float:left;   
       margin-left: 10px;
       margin-right: 10px;
       margin-bottom: 30px;
       line-height: 30px;
   }
   .btn_buy {
      display: none;
   }
   
   
   .cartList_area{
   margin-top: 60px;
   
   }
   
   .btn-hover {
    width: 170px;
    font-size: 16px;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
    margin: 20px auto;
    height: 30px;
    text-align: center;
    border: none;
    background-size: 300% 100%;
    border-radius: 50px;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}
</style>
<body>
<section class="wrap"><!-- 기본틀 1 -->
   <section class="content_leyout_section"><!-- 기본틀 2 -->
   <div id="aside">
      <br>
      <h3>카테고리</h3>
      <ul>
         <li><a href="/shop/list">전체</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=1">음식</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=2">의류</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=3">기타</a></li>
         <li class="cartList_area"><a href="/shop/cartList">장바구니로 이동</a></li>
         <li><a href="/shop/orderList">주문내역 확인</a></li>
      </ul>
   </div>
   <div>
      <c:forEach items="${list}" var="list">
         <ul>
            <li class="product">
               <img src="/shopAdmin/prod/display?prodNo=${list.prodNo}" width="180px" height="180px" class="attach_img" alt="thumbnail_img" title="${list.prodThumbnail.tnFilesystem}"><br>
               <input type="hidden" class="prodNo" value="${list.prodNo}">
               <a href="/shop/detail?prodNo=${list.prodNo}">${list.prodName}</a><br>
               <input type="hidden" class="prodName" value="${list.prodName}">
               <span>가격 : <fmt:formatNumber pattern="###,###,###" value="${list.price}" /> 원<br /></span>
               <span>재고 : ${list.stock} 개</span><br>
               <input type="hidden" class="stock" value="${list.stock}">
               <span>구매할 수량 : 
               <select name="prodCnt" class="prodCnt">
               <%for(int i=1; i<100; i++){%>
                  <option value="<%=i%>"><%=i%></option>
               <%}%>
               </select>개</span>
               <button class="btn_buy">구매하기</button>               
               <button  id="btn_addCart" class="btn-hover color-3 btn_addCart" data-prodno="${list.prodNo}"  data-stock="${list.stock}">장바구니 담기</button>
            </li>
         </ul>
      </c:forEach>
   </div>
   <div id="paging">
      ${paging}
   </div>
   </section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->
</body>
</html>