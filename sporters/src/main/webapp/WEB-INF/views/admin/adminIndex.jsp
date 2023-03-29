<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="Sporters 쇼핑몰 관리자페이지" name="title" />
</jsp:include>
<jsp:include page="adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="/resources/boot/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"></script>
    </head>
    <body class="sb-nav-fixed">
    	<div class="body_wrap">
    		<div class="code_wrap">
    			<div class="in_wrap">
		            <div id="layoutSidenav_content">
		                <main>
		                    <div class="container-fluid px-4">
		                        <h1 class="mt-4">Dashboard</h1>
		                        <ol class="breadcrumb mb-4">
		                            <li class="breadcrumb-item active">관리자님 안녕하세요!</li>
		                        </ol>
		                        <div class="row">
		                            <div class="col-xl-3 col-md-6">
		                                <div class="card bg-primary text-white mb-4">
		                                    <div class="card-body"><i class="fa-solid fa-person-swimming" style="width:30px;"></i>회원관리</div>
		                                    <div class="card-footer d-flex align-items-center justify-content-between">
		                                        <a class="small text-white stretched-link" href="/admin/userAdmin">관리페이지로 이동</a>
		                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-xl-3 col-md-6">
		                                <div class="card bg-warning text-white mb-4">
		                                    <div class="card-body"><i class="fa-solid fa-file" style="width:30px;"></i>게시판관리</div>
		                                    <div class="card-footer d-flex align-items-center justify-content-between">
		                                        <a class="small text-white stretched-link" href="/admin/adminFreeList">관리페이지로 이동</a>
		                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-xl-3 col-md-6">
		                                <div class="card bg-success text-white mb-4">
		                                    <div class="card-body"><i class="fa-solid fa-cart-shopping" style="width:30px;"></i>상품관리</div>
		                                    <div class="card-footer d-flex align-items-center justify-content-between">
		                                        <a class="small text-white stretched-link" href="/shopAdmin/prodManage">관리페이지로 이동</a>
		                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-xl-3 col-md-6">
		                                <div class="card bg-danger text-white mb-4">
		                                    <div class="card-body"><i class="fa-solid fa-truck-fast" style="width:30px;"></i>주문관리</div>
		                                    <div class="card-footer d-flex align-items-center justify-content-between">
		                                        <a class="small text-white stretched-link" href="/shopAdmin/orderManage">관리페이지로 이동</a>
		                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="row">
		                            <div class="col-xl-6">
		                                <div class="card mb-4">
		                                    <div class="card-header">
		                                        <i class="fas fa-chart-area me-1"></i>
		                                       	쇼핑몰 매출
		                                    </div>
		                                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
		                                    <div>
		                                    	<c:forEach items="${graghList}" var="list">
			                                    	<input type="hidden" value="${list.priceAll}">
		                                    	</c:forEach>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-xl-6">
		                                <div class="card mb-4">
		                                    <div class="card-header">
		                                        <i class="fas fa-chart-bar me-1"></i>
		                                        사용자 유입 분석
		                                    </div>
		                                    <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </main>
		            </div>
    			</div>
	        </div>
    	</div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/resources/boot/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
        <script src="/resources/boot/assets/demo/chart-area-demo.js"></script>
        <script src="/resources/boot/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"></script>
        <script src="/resources/boot/js/datatables-simple-demo.js"></script>
    </body>
</html>
