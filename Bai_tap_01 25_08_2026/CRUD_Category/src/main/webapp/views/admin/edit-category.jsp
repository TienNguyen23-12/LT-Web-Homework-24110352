<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/26/2026
  Time: 5:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-header {
            background-color: #f4f4f4;
            font-weight: 500;
        }
        .preview-img {
            width: 150px;
            height: 150px;
            object-fit: contain;
            background-color: #f8f9fa;
            border-radius: 50%;
            padding: 15px;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('imagePreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
        <div class="card-header">
            Chỉnh sửa danh mục
        </div>
        <div class="card-body p-4">
            <h3 class="mb-4" style="color: #333; font-weight: normal;">Danh mục:</h3>
            <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${category.id}" />
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Tên danh sách:</label>
                    <input type="text" class="form-control" name="name" value="${category.name}" required />
                </div>
                
                <div class="mb-3">
                    <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
                    <img id="imagePreview" src="${imgUrl}" alt="${category.name}" class="preview-img" />
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Ảnh đại diện</label>
                    <input class="form-control" type="file" name="icon" accept="image/*" onchange="previewImage(this);">
                </div>
                
                <button type="submit" class="btn btn-light border px-4">Edit</button>
                <button type="reset" class="btn btn-info text-white px-4" onclick="document.getElementById('imagePreview').src='${imgUrl}';">Reset</button>
                <a href="list" class="btn btn-link text-decoration-none ms-2">Quay lại</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
