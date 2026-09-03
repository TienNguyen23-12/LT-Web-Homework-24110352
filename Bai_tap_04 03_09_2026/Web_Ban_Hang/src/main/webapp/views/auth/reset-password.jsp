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
    <title>Đặt lại mật khẩu</title>
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
        <h2>Đặt lại mật khẩu</h2>
        <p>Tạo mật khẩu mới cho tài khoản của bạn</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Nhập mật khẩu mới
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form class="needs-validation" novalidate action="<c:url value='/reset-password'/>" method="post">
                <div class="mb-3">
                    <label class="form-label">Mã OTP</label>
                    <input type="text" name="otp" class="form-control text-center" required maxlength="6">
                </div>
                <div class="mb-4">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" name="new_password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">Xác nhận</button>
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
