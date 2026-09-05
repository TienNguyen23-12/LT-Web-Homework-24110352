<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - UTE Store</title>
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5.3.3 CSS -->
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
        .btn-primary {
            background-color: #4f46e5;
            border-color: #4f46e5;
        }
        .btn-primary:hover {
            background-color: #4338ca;
            border-color: #4338ca;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">
            <!-- Brand Logo -->
            <div class="text-center mb-4">
                <a href="<c:url value='/home'/>" class="text-decoration-none d-inline-flex align-items-center">
                    <span class="badge rounded-circle p-3 bg-primary text-white me-2 shadow">
                        <i class="bi bi-shop fs-3"></i>
                    </span>
                    <span class="fs-2 fw-bold text-white">UTE<span class="text-warning ms-1">Store</span></span>
                </a>
                <p class="text-white-50 mt-1 small">Hệ thống phân phối và bán hàng trực tuyến</p>
            </div>

            <div class="card auth-card p-4 p-sm-5">
                <div class="text-center mb-4">
                    <h3 class="fw-bold text-dark mb-1">Đăng Nhập</h3>
                    <p class="text-muted small">Chào mừng bạn quay trở lại với UTE Store</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2 px-3 small" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2"></i>
                        <div>${error}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.message == 'active_success'}">
                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center py-2 px-3 small" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <div>Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.message == 'reset_success'}">
                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center py-2 px-3 small" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <div>Khôi phục mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="<c:url value='/login'/>" method="post" class="needs-validation" novalidate id="loginForm">
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold text-dark small">Địa chỉ Email</label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   value="${email}" 
                                   class="form-control" 
                                   placeholder="example@gmail.com" 
                                   required 
                                   pattern="^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$">
                            <div class="invalid-feedback">
                                Vui lòng nhập định dạng email hợp lệ (ví dụ: name@domain.com).
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <label for="password" class="form-label fw-semibold text-dark small mb-0">Mật khẩu</label>
                            <a href="<c:url value='/forgot-password'/>" class="text-decoration-none small text-danger">Quên mật khẩu?</a>
                        </div>
                        <div class="input-group has-validation mt-1">
                            <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   class="form-control" 
                                   placeholder="••••••••" 
                                   required 
                                   minlength="6">
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassVisibility('password', this)">
                                <i class="bi bi-eye"></i>
                            </button>
                            <div class="invalid-feedback">
                                Vui lòng nhập mật khẩu (tối thiểu 6 ký tự).
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-3">
                        <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
                    </button>

                    <div class="text-center">
                        <span class="text-muted small">Chưa có tài khoản?</span>
                        <a href="<c:url value='/register'/>" class="text-decoration-none fw-semibold ms-1">Đăng ký ngay</a>
                    </div>
                </form>
            </div>
            <div class="text-center mt-3">
                <a href="<c:url value='/home'/>" class="text-white-50 text-decoration-none small">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại trang chủ
                </a>
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

    function togglePassVisibility(inputId, btn) {
        const input = document.getElementById(inputId);
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('bi-eye', 'bi-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('bi-eye-slash', 'bi-eye');
        }
    }
</script>
</body>
</html>
