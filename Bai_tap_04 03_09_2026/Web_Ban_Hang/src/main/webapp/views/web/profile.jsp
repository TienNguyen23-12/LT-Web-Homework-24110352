<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thông Tin Cá Nhân</title>
</head>
<body>
<div class="container mt-4 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0 fw-bold">Hồ Sơ Người Dùng</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-4">
                            <c:choose>
                                <c:when test="${not empty user.images}">
                                    <img src="<c:url value='/image?fname=${user.images}'/>" 
                                         alt="Avatar" class="rounded-circle shadow-sm border" 
                                         style="width: 130px; height: 130px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <div class="d-inline-flex justify-content-center align-items-center rounded-circle bg-secondary text-white shadow-sm" 
                                         style="width: 130px; height: 130px; font-size: 48px;">
                                        <i class="bi bi-person">${user.fullname != null && user.fullname.length() > 0 ? user.fullname.substring(0,1).toUpperCase() : 'U'}</i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Email:</label>
                            <input type="email" class="form-control bg-light" value="${user.email}" readonly disabled>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và Tên:</label>
                            <input type="text" name="fullname" class="form-control" value="${user.fullname}" required placeholder="Nhập họ và tên...">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Số điện thoại:</label>
                            <input type="tel" name="phone" class="form-control" value="${user.phone}" placeholder="Nhập số điện thoại...">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Ảnh đại diện mới:</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*">
                            <div class="form-text">Hỗ trợ các định dạng ảnh: JPG, PNG, JPEG, GIF.</div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary py-2 fw-bold">Cập Nhật Thông Tin</button>
                            <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">Quay lại Trang Chủ</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>