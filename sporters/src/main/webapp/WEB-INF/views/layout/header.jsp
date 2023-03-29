<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html5>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>${title}</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.min.css">
<script src="/resources/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- 
<link rel="stylesheet" type="text/css" href="/resources/css/left_menus.css">
<script src="/resources/js/left_menus.js"></script>
 -->
 
<script type="text/javascript">
$(function(){
   
   $('#menu').hover(function(){
      
      setTimeout(function() { 
          $('.spoters_logo').css('backgroundColor','rgb(300,300,300,1)');
      }, 400);
       $('.spoters_logo').css('marginLeft','-100px');
      
      /*
        $('.spoters_logo').css('marginLeft','-100px').animate({
           backgroundColor:"rgb(255,255,255,1)"
        }, 200, function() {
           backgroundColor:"rgb(255,255,255,0)"
           
          // Animation complete.
      });
      */
  //      $('.spoters_logo').animate({ backgroundColor: "#ffffff"},200);
       // $('.spoters_logo')
    }, function() {
        $('.spoters_logo').css('marginLeft','0px');
       
        setTimeout(function() { 
           $('.spoters_logo').css('backgroundColor','rgb(300,300,300,0)');
                
      }, 400);
    }    );
 /*
    setTimeout(function() { 
       
       $('#menu').hover(function(){
             
             
          }, function() {
          
             
          });      
      }, 200);
    
    */
    
});

</script>
 
<style type="text/css">
   html,body{
   height:100%;
   position: relative; 
   font-family: 'Noto Sans KR', sans-serif;
   
      /*
         width:1280px;
         margin:0 auto;
      */
   
   }
   .main_header_area{
   position: relative;
   /*
   position: fixed;
   */
      width:100%;
      top: 0;
       left: 0;
   /*    background-color: #EDEBFE;*/
       z-index: 11;
   }
   .main_header_area_fix{
/*   position: fixed;*
      width:1280px;
     margin: 0 auto;
     */
   }
   
   .spoters_logo_area{
       padding: 0px 100px 0 100px;
       
       display: flex;
       
       /* border: 1px solid #000; */
       /* background-color: #fff; */
       
       flex-direction: row;
       align-content: stretch;
       flex-wrap: nowrap;
       justify-content: space-between;
       align-items: baseline;
       
   }
   
   .spoters_logo{
      width:300px; 
      transition: 1000ms all cubic-bezier(0.19, 1, 0.22, 1);
   }
   .spoters_logo_img{
      width:100%;
      transition: 3000ms all cubic-bezier(0.19, 1, 0.22, 1);
   }

   
   /*
      .left_side_gnd_area{
      position: fixed;
      
      left:0px;
      
      
      left:0%;
      top:164px;
      border:1px solid #000;
      width: 240px;
   }
   
   
   */

   .wrap{
      position:relative;
      top:0px;
      margin: 50px auto;
      
       width: 80%;
       overflow: hidden;
   /*    border: 2px solid #000;*/
   }
   
   .wrap .content_leyout_section{
      width:90%;   
      margin: 0 auto;   
   }
   
.div_content{
   height: unset !important;
}

.div_content_text img{

   display: block;      
   }
   
.div_paging{
   display: flex;
    justify-content: center;
    width: 10%;
    margin: 3% auto;
    justify-content: space-around;
    flex-wrap: nowrap;
}
.div_paging a{

/*   margin-left:10px;*/
}


.div_head{
   display: flex;
}
.div_items{
display: flex;
}
</style>
</head>
<!--  
<script type="text/javascript">
$(function(){
//   var header_height = $('.main_header_area').height()  +  50;
//   $('.wrap').css({marginTop: header_height });
});


</script>
-->

<div id="left_side_gnd_area"  class="left_side_gnd_area">
   
   <jsp:include page="../layout/left_side.jsp">
      <jsp:param value="left_side" name="left_side" />
   </jsp:include>
</div>

<header class="main_header_area">
   <div class="main_header_area_fix">
   <nav class="spoters_logo_area">
      <h1 class="spoters_logo"><a href="/"><img class="spoters_logo_img" alt="we are best team!" src="/resources/images/spoters_logo_3.png"></a></h1>
      <div style="font-size: 15px; ">
         <c:if test="${loginUser != null}">
            <div>
               <span style="font-weight: bold;">${loginUser.nickname}</span><span>님 활동적인 하루되세요!💪💪</span>   <br>
            </div>
            <div style="text-align: right;">
               <span><a href="/users/mypage" class="mypage_a">MYPAGE</a> &nbsp;&nbsp;&nbsp; <a href="/users/logout" class="logout_a">LOGOUT</a></span>   
            </div>
         </c:if>   
         
         <c:if test="${loginUser == null}">
            <span><a href="/users/login/form" class="login_a">로그인</a> &nbsp;&nbsp;&nbsp; <a href="/users/agree/form" class="sign_up_a">회원가입</a></span>
         </c:if>
      </div>
      <script>
         
      
      
         $(function(){
            $('.mypage_a').hover(function(){
                 $(this).text("나의 정보")
             }, function() {
                 $(this).text("MYPAGE")
             });
         });
         
         $(function(){
            $('.logout_a').hover(function(){
                 $(this).text("접속 종료")
             }, function() {
                 $(this).text("LOGOUT")
             });
         });
         
         $(function(){
            $('.login_a').hover(function(){
                 $(this).text("SIGN IN")
             }, function() {
                 $(this).text("로그인")
             });
         });
         
         $(function(){
            $('.sign_up_a').hover(function(){
                 $(this).text("SIGN UP")
             }, function() {
                 $(this).text("회원가입")
             });
         });
      </script>
   
   </nav>   
   </div>



<!--
<div id="left_side_gnd_area"  class="left_side_gnd_area">
          
      <ul>
        <li><a href="/users/agree/form">회원가입</a> </li>
       <li><a href="/users/login/form">로그인</a> </li>
       <li><a href="/local/list">지역별게시판</a> </li>
       <li><a href="/spoReview/list">운동후기게시판</a> </li>
       <li><a href="/free/list">자유게시판</a> </li>
       <li><a href="/shop/list">쇼핑몰</a> </li>
       <li><a href="/supp/singo">신고게시판</a> </li>
       <li><a href="/qna/list">고객문의게시판</a> </li>
       <li><a href="/faq/list">자주하는질문</a> </li>
       <li><a href="/admin/adminIndex">관리자게시판</a> </li>
       <li><a href="/admin/shopIndex">쇼핑몰관리자게시판</a> </li>
      </ul>    
  </div>
  -->

</header>