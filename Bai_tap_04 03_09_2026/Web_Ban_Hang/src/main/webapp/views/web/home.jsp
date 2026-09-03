<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 27/08/2026
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
<div class="container mt-4">
    <h2 class="fw-bold mb-4 border-bottom pb-2">10 Sản Phẩm Mới Nhất</h2>
    <div class="row">
        <c:forEach items="${top10}" var="p">
            <div class="col-md-3 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="<c:url value='/image?fname=${p.images}'/>" class="card-img-top" style="height:200px; object-fit:cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-truncate" title="${p.productName}">${p.productName}</h5>
                        <p class="card-text text-danger fw-bold fs-5">${p.price} đ</p>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-info w-100 fw-semibold">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>