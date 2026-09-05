<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - UTE Store</title>
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
                    <div class="rounded-circle bg-success bg-opacity-10 text-success d-inline-flex p-3 mb-3">
                        <i class="bi bi-shield-check fs-2"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Đặt Lại Mật Khẩu</h3>
                    <p class="text-muted small">Nhập mã OTP nhận được và thiết lập mật khẩu mới</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2 px-3 small" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2"></i>
                        <div>${error}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="<c:url value='/reset-password'/>" method="post" class="needs-validation" novalidate id="resetPassForm">
                    <div class="mb-3">
                        <label for="otp" class="form-label fw-semibold text-dark small">Mã OTP (6 chữ số)</label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light"><i class="bi bi-key"></i></span>
                            <input type="text" 
                                   id="otp" 
                                   name="otp" 
                                   class="form-control text-center fw-bold" 
                                   required 
                                   maxlength="6" 
                                   pattern="^\d{6}$" 
                                   placeholder="123456">
                            <div class="invalid-feedback">
                                Vui lòng nhập đúng 6 chữ số mã xác nhận OTP.
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="new_password" class="form-label fw-semibold text-dark small">Mật khẩu mới</label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                            <input type="password" 
                                   id="new_password" 
                                   name="new_password" 
                                   class="form-control" 
                                   placeholder="Tối thiểu 6 ký tự" 
                                   required 
                                   minlength="6">
                            <div class="invalid-feedback">
                                Mật khẩu mới phải có ít nhất 6 ký tự.
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="confirm_password" class="form-label fw-semibold text-dark small">Xác nhận mật khẩu mới</label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" 
                                   id="confirm_password" 
                                   name="confirm_password" 
                                   class="form-control" 
                                   placeholder="Nhập lại mật khẩu mới" 
                                   required 
                                   minlength="6">
                            <div class="invalid-feedback">
                                Mật khẩu xác nhận phải khớp với mật khẩu mới.
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-3">
                        <i class="bi bi-check-circle-fill me-1"></i>Lưu Mật Khẩu Mới
                    </button>

                    <div class="text-center">
                        <a href="<c:url value='/login'/>" class="text-decoration-none small text-muted">
                            <i class="bi bi-arrow-left me-1"></i>Hủy và quay lại đăng nhập
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
                const pass = form.querySelector('#new_password');
                const confirm = form.querySelector('#confirm_password');
                if (pass && confirm && pass.value !== confirm.value) {
                    confirm.setCustomValidity("Mật khẩu không khớp");
                } else if (confirm) {
                    confirm.setCustomValidity("");
                }

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
