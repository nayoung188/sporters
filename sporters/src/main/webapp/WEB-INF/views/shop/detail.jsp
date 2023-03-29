<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/button_shop.css">
<jsp:include page="../layout/header.jsp">
   <jsp:param value="Spoters쇼핑몰페이지" name="title" />
</jsp:include>
<script>

   $(document).ready(function(){
      
      $('#btn_addCart').click(function(){
         var prodNo = $('#prodNo').val();
         alert(prodNo);
         var prodCnt = $('#prodCnt').val();
         alert(prodCnt);
         var stock = $(this).data('stock');
         alert(stock);
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
                  if(stock > prodCnt){
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
      
   });
   
</script>

<style>

.product_area{
   line-height: 60px;
}


.product_area h1{ font-size: 30px;}
.product_area span{font-size: 20px;}

</style>
<body>
<section class="wrap"><!-- 기본틀 1 -->
   <section class="content_leyout_section"><!-- 기본틀 2 -->
      <div class="product_detail_area" style="display: flex;justify-content: space-evenly;">
         <div><img src="/shopAdmin/prod/display?prodNo=${product.prodNo}" width="400px" class="attach_img" alt="thumbnail_img" title="${product.prodThumbnail.tnFilesystem}"></div>
         <div class="product_area"  style="">
            <input type="hidden" id="prodNo" value="${product.prodNo}">
            <h1>&#91;${product.prodCategory.prodCategoryName}&#93; ${product.prodName}</h1> 
            <div style="margin-left: 30px; font-size: 20px;">${product.prodContent}</div>
            <span>가격 : <fmt:formatNumber pattern="###,###,###" value="${product.price}" /> 원<br /></span>
            <span id="stock">재고 : ${product.stock} 개</span><br>
            <span>
               구매할 수량 : 
               <select name="prodCnt" id="prodCnt">
               <%for(int i=1; i<100; i++){%>
                  <option value="<%=i%>"><%=i%></option>
               <%}%>
               </select>개
            </span><br>
         
            <button  id="btn_addCart" class="btn-hover color-3"data-stock="${product.stock}">장바구니</button>
         </div>
      </div>
      
      <div></div>
   
   </section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->
</body>
</html>