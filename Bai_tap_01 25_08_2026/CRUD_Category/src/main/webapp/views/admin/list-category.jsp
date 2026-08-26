<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/26/2026
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .page-header {
            margin-bottom: 20px;
        }
        .page-header h2 {
            color: #dc3545;
            font-weight: 500;
        }
        .page-header p {
            color: #6c757d;
        }
        .table-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            background-color: #f8f9fa;
            border-radius: 50%;
            padding: 10px;
        }
        .card-header {
            background-color: #f4f4f4;
            font-weight: 500;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-4 mb-5">
    <div class="page-header">
        <h2>Quản lý danh mục</h2>
        <p>Nơi bạn có thể quản lý danh mục của mình</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Danh sách danh mục
        </div>
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div class="d-flex align-items-center">
                    <select class="form-select form-select-sm w-auto me-2">
                        <option>10</option>
                        <option>25</option>
                        <option>50</option>
                    </select>
                    <span>records per page</span>
                </div>
                <div class="d-flex align-items-center">
                    <span class="me-2">Search:</span>
                    <input type="text" class="form-control form-control-sm w-auto">
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 25%;">Hình ảnh</th>
                            <th style="width: 50%;">Tên danh mục</th>
                            <th style="width: 20%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cateList}" var="cate" varStatus="STT">
                            <tr>
                                <td>${STT.index + 1}</td>
                                <td>
                                    <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                                    <img class="table-image" src="${imgUrl}" alt="${cate.name}" />
                                </td>
                                <td>${cate.name}</td>
                                <td>
                                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="text-decoration-none text-info">Sửa</a> |
                                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="text-decoration-none text-info" onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="mt-3">
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary">Thêm danh mục</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
