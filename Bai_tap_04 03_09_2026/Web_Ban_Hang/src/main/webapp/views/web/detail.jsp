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
    <title>Chi tiết: ${p.productName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">


<div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-body p-5">
            <div class="row align-items-center">
                <div class="col-md-5 text-center">
                    <img src="<c:url value='/image?fname=${p.images}'/>" class="img-fluid rounded shadow" style="max-height: 400px; object-fit: contain;">
                </div>
                <div class="col-md-7">
                    <h1 class="display-5 fw-bold text-dark">${p.productName}</h1>
                    <h2 class="text-danger my-4 fw-bold">${p.price} VNĐ</h2>
                    <p class="fs-5 mb-2">Số lượng còn lại trong kho: <span class="badge bg-success fs-6">${p.quantity}</span></p>
                    <p class="fs-5 mb-4">Thuộc danh mục: <span class="fw-bold text-primary">${p.category.categoryname}</span></p>
                    <div class="d-flex gap-3 mt-4">
                        <button class="btn btn-success btn-lg px-4 fw-bold shadow-sm">Thêm vào giỏ hàng</button>
                        <a href="<c:url value='/product'/>" class="btn btn-secondary btn-lg px-4 fw-bold shadow-sm">Quay lại danh sách</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
