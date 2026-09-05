<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Thêm Danh Mục Mới</title>
</head>
<body>
    <div class="mb-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none">QL Danh Mục</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-dark mb-1">Thêm Danh Mục Mới</h3>
        <p class="text-muted small">Tạo danh mục sản phẩm mới để phân loại hàng hóa trên hệ thống</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <i class="bi bi-folder-plus text-primary fs-5 me-2"></i>
                    <span class="fw-bold">Thông tin danh mục</span>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/category/insert'/>" method="post" class="needs-validation" novalidate id="categoryForm">
                        <div class="mb-4">
                            <label for="categoryname" class="form-label fw-semibold">
                                Tên danh mục <span class="text-danger">*</span>
                            </label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-tag"></i></span>
                                <input type="text" 
                                       id="categoryname" 
                                       name="categoryname" 
                                       value="${categoryname}" 
                                       class="form-control" 
                                       placeholder="Ví dụ: Điện thoại, Máy tính bảng, Phụ kiện..." 
                                       required 
                                       minlength="2" 
                                       maxlength="100">
                                <div class="invalid-feedback">
                                    Vui lòng nhập tên danh mục (từ 2 đến 100 ký tự và không được để trống).
                                </div>
                            </div>
                            <div class="form-text text-muted small mt-1">
                                Tên danh mục nên ngắn gọn, rõ ràng để khách hàng dễ dàng tìm kiếm.
                            </div>
                        </div>

                        <div class="d-flex gap-2 pt-2 border-top">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i>Lưu Danh Mục
                            </button>
                            <button type="reset" class="btn btn-light border px-4">
                                <i class="bi bi-arrow-counterclockwise me-1"></i>Làm lại
                            </button>
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary ms-auto">
                                <i class="bi bi-x-lg me-1"></i>Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
