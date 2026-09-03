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
    <title>Xác nhận OTP</title>
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
        <h2>Xác nhận OTP</h2>
        <p>Kiểm tra mã trong CSDL</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Nhập mã OTP
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form class="needs-validation" novalidate action="<c:url value='/verify-otp'/>" method="post">
                <div class="mb-4">
                    <input type="text" name="otp" class="form-control text-center fs-3" required placeholder="XXXXXX" maxlength="6">
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">Xác nhận</button>
                <div class="text-center">
                    <a href="<c:url value='/login'/>" class="text-decoration-none">Quay lại đăng nhập</a>
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
