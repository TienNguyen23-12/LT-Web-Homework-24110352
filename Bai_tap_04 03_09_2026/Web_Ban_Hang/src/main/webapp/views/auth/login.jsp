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
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .page-header { margin-bottom: 20px; }
        .page-header h2 { color: #dc3545; font-weight: 500; }
        .page-header p { color: #6c757d; }
        .card-header { background-color: #f4f4f4; font-weight: 500; }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 450px;">
    <div class="page-header text-center">
        <h2>Đăng nhập</h2>
        <p>Vui lòng đăng nhập để truy cập hệ thống</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Thông tin đăng nhập
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${param.message == 'active_success'}">
                <div class="alert alert-success">Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.</div>
            </c:if>
            <c:if test="${param.message == 'reset_success'}">
                <div class="alert alert-success">Khôi phục mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới.</div>
            </c:if>
            <c:if test="${not empty param.message && param.message != 'active_success' && param.message != 'reset_success'}">
                <div class="alert alert-info">${param.message}</div>
            </c:if>
            <form class="needs-validation" novalidate action="<c:url value='/login'/>" method="post">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">Đăng nhập</button>
                <div class="d-flex justify-content-between">
                    <a href="<c:url value='/register'/>" class="text-decoration-none">Đăng ký tài khoản</a>
                    <a href="<c:url value='/forgot-password'/>" class="text-decoration-none text-danger">Quên mật khẩu?</a>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
