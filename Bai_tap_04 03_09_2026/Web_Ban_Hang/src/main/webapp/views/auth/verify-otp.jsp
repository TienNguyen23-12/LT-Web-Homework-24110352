<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận OTP - UTE Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #312e81 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .auth-card {
            border: 1px solid rgba(255, 255, 255, 0.15);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            border-radius: 1.25rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
        }
        .otp-input {
            letter-spacing: 12px;
            font-size: 1.8rem;
            font-weight: 700;
            text-align: center;
        }
        .btn-primary {
            background-color: #4f46e5;
            border-color: #4f46e5;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">
            <div class="card auth-card p-4 p-sm-5">
                <div class="text-center mb-4">
                    <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-inline-flex p-3 mb-3">
                        <i class="bi bi-shield-lock-fill fs-2"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Xác Nhận OTP</h3>
                    <p class="text-muted small">Vui lòng nhập mã 6 số được gửi tới email của bạn</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2 px-3 small" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2"></i>
                        <div>${error}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="<c:url value='/verify-otp'/>" method="post" class="needs-validation" novalidate>
                    <div class="mb-4">
                        <label for="otp" class="form-label fw-semibold text-dark small text-center d-block">Mã 6 chữ số</label>
                        <input type="text" 
                               id="otp" 
                               name="otp" 
                               class="form-control otp-input shadow-none" 
                               required 
                               maxlength="6" 
                               pattern="^\d{6}$" 
                               placeholder="------" 
                               autocomplete="off">
                        <div class="invalid-feedback text-center">
                            Mã xác nhận phải gồm đúng 6 chữ số (0-9).
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-3">
                        <i class="bi bi-check-lg me-1"></i>Xác Nhận Kích Hoạt
                    </button>

                    <div class="text-center">
                        <a href="<c:url value='/login'/>" class="text-decoration-none small text-muted">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
</body>
</html>
