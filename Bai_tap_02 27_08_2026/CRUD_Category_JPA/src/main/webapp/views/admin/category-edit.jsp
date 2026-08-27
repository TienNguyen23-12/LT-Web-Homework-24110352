<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/27/2026
  Time: 10:03 AM
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
            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="categoryid" value="${cate.categoryId}" />
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên danh mục:</label>
                    <input type="text" class="form-control" name="categoryname" value="${cate.categoryname}" required />
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Link URL ảnh (tùy chọn):</label>
                    <input type="text" class="form-control" name="images" value="${cate.images}" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Trạng thái:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="ston" value="1" ${cate.status==1?'checked':'' }>
                        <label class="form-check-label" for="ston">Hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" id="stoff" value="0" ${cate.status!=1?'checked':'' }>
                        <label class="form-check-label" for="stoff">Khóa</label>
                    </div>
                </div>
                
                <div class="mb-3">
                    <c:if test="${cate.images != null && cate.images.length() >= 5 && cate.images.substring(0,5)=='https'}">
                        <c:url value="${cate.images }" var="imgUrl"></c:url>
                    </c:if>
                    <c:if test="${cate.images == null || cate.images.length() < 5 || cate.images.substring(0,5)!='https'}">
                        <c:url value="/image?fname=${cate.images }" var="imgUrl"></c:url>
                    </c:if>
                    <img id="imagePreview" src="${imgUrl}" alt="${cate.categoryname}" class="preview-img" />
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Tải ảnh lên</label>
                    <input class="form-control" type="file" name="images1" accept="image/*" onchange="previewImage(this);">
                </div>
                
                <button type="submit" class="btn btn-light border px-4">Edit</button>
                <button type="reset" class="btn btn-info text-white px-4" onclick="document.getElementById('imagePreview').src='${imgUrl}';">Reset</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-link text-decoration-none ms-2">Quay lại</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
