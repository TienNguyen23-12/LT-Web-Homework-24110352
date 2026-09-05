<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Hồ Sơ Cá Nhân - ${user.fullname}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-7">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
                </ol>
            </nav>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-badge-fill text-primary fs-4 me-2"></i>
                        <h5 class="mb-0 fw-bold">Thông Tin Tài Khoản</h5>
                    </div>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                            <div>${message}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileForm">
                        <!-- Avatar Section with Live Preview -->
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <c:choose>
                                    <c:when test="${not empty user.images && user.images != 'default.jpg'}">
                                        <img id="avatarPreview" src="<c:url value='/image?fname=${user.images}'/>" 
                                             alt="Avatar" class="rounded-circle shadow border border-3 border-primary" 
                                             style="width: 120px; height: 120px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div id="avatarFallback" class="rounded-circle bg-primary text-white shadow d-inline-flex align-items-center justify-content-center fw-bold fs-1" 
                                             style="width: 120px; height: 120px;">
                                            ${user.fullname != null && user.fullname.length() > 0 ? user.fullname.substring(0,1).toUpperCase() : 'U'}
                                        </div>
                                        <img id="avatarPreview" src="#" alt="Preview" class="rounded-circle shadow border border-3 border-primary d-none" 
                                             style="width: 120px; height: 120px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="mt-2 text-muted small">Ảnh đại diện thành viên</div>
                        </div>

                        <!-- Email (Read-only) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Địa chỉ Email:</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope-fill text-secondary"></i></span>
                                <input type="email" class="form-control bg-light" value="${user.email}" readonly disabled>
                            </div>
                            <div class="form-text small">Email là định danh tài khoản và không thể thay đổi.</div>
                        </div>

                        <!-- Fullname -->
                        <div class="mb-3">
                            <label for="fullname" class="form-label fw-semibold">
                                Họ và Tên <span class="text-danger">*</span>
                            </label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-person-fill text-secondary"></i></span>
                                <input type="text" 
                                       id="fullname" 
                                       name="fullname" 
                                       class="form-control" 
                                       value="${user.fullname}" 
                                       placeholder="Ví dụ: Nguyễn Văn A" 
                                       required 
                                       minlength="2" 
                                       maxlength="100">
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ và tên của bạn (từ 2 đến 100 ký tự).
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-telephone-fill text-secondary"></i></span>
                                <input type="tel" 
                                       id="phone" 
                                       name="phone" 
                                       class="form-control" 
                                       value="${user.phone}" 
                                       placeholder="Ví dụ: 0987654321" 
                                       pattern="^(03|05|07|08|09)\d{8}$">
                                <div class="invalid-feedback">
                                    Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 03, 05, 07, 08 hoặc 09.
                                </div>
                            </div>
                            <div class="form-text small">Định dạng số điện thoại di động Việt Nam gồm 10 chữ số.</div>
                        </div>

                        <!-- Upload Avatar -->
                        <div class="mb-4">
                            <label for="imageFileInput" class="form-label fw-semibold">Tải lên ảnh đại diện mới</label>
                            <input type="file" 
                                   id="imageFileInput" 
                                   name="imageFile" 
                                   class="form-control" 
                                   accept="image/png, image/jpeg, image/jpg, image/webp, image/gif"
                                   onchange="previewAvatar(this)">
                            <div class="form-text small">
                                Định dạng hỗ trợ: JPG, PNG, WEBP, GIF. Kích thước tối đa: 5MB.
                            </div>
                        </div>

                        <div class="d-grid gap-2 pt-2 border-top">
                            <button type="submit" class="btn btn-primary py-2 fw-semibold shadow-sm">
                                <i class="bi bi-check-circle-fill me-1"></i>Lưu Thay Đổi
                            </button>
                            <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại Trang Chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Client-side script for avatar live preview -->
    <script>
        function previewAvatar(input) {
            const previewImg = document.getElementById('avatarPreview');
            const fallback = document.getElementById('avatarFallback');

            if (input.files && input.files[0]) {
                const file = input.files[0];

                if (file.size > 5242880) {
                    alert("Dung lượng ảnh vượt quá 5MB! Vui lòng chọn ảnh nhỏ hơn.");
                    input.value = "";
                    return;
                }

                const allowedExt = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];
                const fileName = file.name.toLowerCase();
                const isValidExt = allowedExt.some(ext => fileName.endsWith(ext));
                if (!isValidExt) {
                    alert("Vui lòng chỉ chọn file hình ảnh (JPG, PNG, WEBP, GIF)!");
                    input.value = "";
                    return;
                }

                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImg.src = e.target.result;
                    previewImg.classList.remove('d-none');
                    if (fallback) fallback.classList.add('d-none');
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>