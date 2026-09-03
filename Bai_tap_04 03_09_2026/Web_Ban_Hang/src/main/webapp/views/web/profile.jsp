<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Thông tin cá nhân</title>
</head>
<body>
<div class="row justify-content-center">
        <div class="col-md-8">
            <div class="page-header text-center">
                <h2>Thông tin cá nhân</h2>
                <p>Cập nhật thông tin của bạn</p>
            </div>
            
            <div class="card shadow-sm">
                <div class="card-header">
                    Hồ sơ của bạn
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>
                    
                    <form class="needs-validation" novalidate action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data">
                        <div class="row mb-4">
                            <div class="col-md-4 text-center">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.images}">
                                        <img src="<c:url value='/image?fname=${sessionScope.user.images}'/>" class="img-thumbnail rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://ui-avatars.com/api/?name=${sessionScope.user.fullname}&background=random" class="img-thumbnail rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                                <input type="file" name="images" class="form-control form-control-sm" accept="image/*">
                                <small class="text-muted">Chọn ảnh mới để thay đổi avatar</small>
                            </div>
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="form-label">Email (Không thể thay đổi)</label>
                                    <input type="email" class="form-control bg-light" value="${sessionScope.user.email}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" name="fullname" class="form-control" value="${sessionScope.user.fullname}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" placeholder="Nhập số điện thoại...">
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary px-4">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


</body>
</html>