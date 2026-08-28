<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 27/08/2026
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tất cả sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/views/common/topbar.jsp"></jsp:include>

<div class="container mt-4">
    <h2 class="fw-bold mb-4 border-bottom pb-2">Tất cả sản phẩm</h2>
    
    <div class="row">
        <c:forEach items="${listproduct}" var="p">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="<c:url value='/image?fname=${p.images}'/>" class="card-img-top" style="height:250px; object-fit:cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title">${p.productName}</h5>
                        <p class="text-danger fw-bold fs-5">${p.price} đ</p>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-info text-white w-100 fw-bold">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <div class="d-flex justify-content-center mt-4 align-items-center flex-wrap">
        <ul class="pagination mb-0">
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>">Trang trước</a>
            </li>
            
            <c:choose>
                <c:when test="${totalPages <= 7}">
                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i + 1}</a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Trang đầu -->
                    <li class="page-item ${currentPage == 0 ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=0'/>">1</a>
                    </li>
                    
                    <!-- Dấu ba chấm bên trái -->
                    <c:if test="${currentPage > 2}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:if>
                    
                    <!-- Các trang ở giữa -->
                    <c:set var="startPage" value="${currentPage - 1}" />
                    <c:set var="endPage" value="${currentPage + 1}" />
                    
                    <c:if test="${startPage <= 0}">
                        <c:set var="startPage" value="1" />
                        <c:set var="endPage" value="3" />
                    </c:if>
                    <c:if test="${endPage >= totalPages - 1}">
                        <c:set var="startPage" value="${totalPages - 4}" />
                        <c:set var="endPage" value="${totalPages - 2}" />
                    </c:if>
                    
                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i + 1}</a>
                        </li>
                    </c:forEach>
                    
                    <!-- Dấu ba chấm bên phải -->
                    <c:if test="${currentPage < totalPages - 3}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:if>
                    
                    <!-- Trang cuối -->
                    <li class="page-item ${currentPage == totalPages - 1 ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${totalPages - 1}'/>">${totalPages}</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <li class="page-item ${currentPage == totalPages - 1 || totalPages == 0 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>">Trang sau</a>
            </li>
        </ul>
        
        <!-- Form điền số trang -->
        <form class="d-flex align-items-center ms-4" onsubmit="event.preventDefault(); window.location.href='<c:url value="/product"/>?page=' + (document.getElementById('jumpPage').value - 1);">
            <span class="me-2 fw-semibold text-secondary">Đến trang:</span>
            <input type="number" id="jumpPage" min="1" max="${totalPages}" class="form-control text-center shadow-sm" style="width: 70px;" required>
            <button type="submit" class="btn btn-secondary ms-2 shadow-sm">Đi</button>
        </form>
    </div>
</div>
</body>
</html>
