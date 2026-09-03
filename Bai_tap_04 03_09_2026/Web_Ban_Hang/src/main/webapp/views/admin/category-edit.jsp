<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 28/08/2026
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Sửa danh mục</title>
</head>
<body>
<div class="container mt-4 mb-5">
    <div class="page-header">
        <h2>Sửa danh mục</h2>
        <p>Cập nhật thông tin danh mục</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Thông tin danh mục
        </div>
        <div class="card-body">
            <form class="needs-validation" novalidate action="<c:url value='/admin/category/update'/>" method="post">
                <input type="hidden" name="categoryId" value="${c.categoryId}">
                <div class="mb-4">
                    <label class="form-label">Tên danh mục</label>
                    <input type="text" name="categoryname" value="${c.categoryname}" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <button type="reset" class="btn btn-warning text-white">Reset</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">Hủy</a>
            </form>
        </div>
    </div>
</div>


</body>
</html>