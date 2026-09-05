<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Cập Nhật Danh Mục</title>
</head>
<body>
    <div class="mb-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none">QL Danh Mục</a></li>
                <li class="breadcrumb-item active" aria-current="page">Sửa danh mục</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-dark mb-1">Cập Nhật Danh Mục</h3>
        <p class="text-muted small">Chỉnh sửa thông tin phân loại danh mục #${c.categoryId}</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <i class="bi bi-pencil-square text-primary fs-5 me-2"></i>
                    <span class="fw-bold">Thông tin danh mục #${c.categoryId}</span>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/category/update'/>" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="categoryId" value="${c.categoryId}">

                        <div class="mb-3">
                            <label class="form-label text-muted small fw-semibold">Mã danh mục (ID)</label>
                            <input type="text" class="form-control bg-light" value="${c.categoryId}" readonly disabled>
                        </div>

                        <div class="mb-4">
                            <label for="categoryname" class="form-label fw-semibold">
                                Tên danh mục <span class="text-danger">*</span>
                            </label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-tag"></i></span>
                                <input type="text" 
                                       id="categoryname" 
                                       name="categoryname" 
                                       value="${c.categoryname}" 
                                       class="form-control" 
                                       required 
                                       minlength="2" 
                                       maxlength="100">
                                <div class="invalid-feedback">
                                    Tên danh mục không được để trống và phải có từ 2 đến 100 ký tự.
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 pt-2 border-top">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">
                                <i class="bi bi-save me-1"></i>Cập Nhật Danh Mục
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
