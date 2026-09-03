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
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .page-header { margin-bottom: 20px; }
        .page-header h2 { color: #dc3545; font-weight: 500; }
        .page-header p { color: #6c757d; }
        .card-header { background-color: #f4f4f4; font-weight: 500; }
        .current-image { width: 150px; border-radius: 4px; padding: 5px; border: 1px solid #dee2e6; margin-bottom: 10px; }
    </style>
</head>
<body class="bg-light">


<div class="container mt-4 mb-5">
    <div class="page-header">
        <h2>Sửa sản phẩm</h2>
        <p>Cập nhật thông tin sản phẩm</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Thông tin sản phẩm
        </div>
        <div class="card-body">
            <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="${p.productId}">
                <div class="mb-3">
                    <label class="form-label">Tên sản phẩm</label>
                    <input type="text" name="productName" value="${p.productName}" class="form-control" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Giá</label>
                        <input type="number" name="price" value="${p.price}" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số lượng</label>
                        <input type="number" name="quantity" value="${p.quantity}" class="form-control" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Danh mục</label>
                    <select name="categoryId" class="form-select" required>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.categoryId}" ${c.categoryId == p.category.categoryId ? 'selected' : ''}>${c.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label d-block">Hình ảnh hiện tại</label>
                    <img src="<c:url value='/image?fname=${p.images}'/>" class="current-image">
                </div>
                <div class="mb-4">
                    <label class="form-label">Tải hình ảnh mới (Bỏ trống nếu không đổi)</label>
                    <input type="file" name="images" class="form-control" accept="image/*">
                </div>
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <button type="reset" class="btn btn-warning text-white">Reset</button>
                <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">Hủy</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
