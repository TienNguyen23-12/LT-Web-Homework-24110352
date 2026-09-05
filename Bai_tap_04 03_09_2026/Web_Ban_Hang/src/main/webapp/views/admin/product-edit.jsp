<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Cập Nhật Sản Phẩm</title>
</head>
<body>
    <div class="mb-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/products'/>" class="text-decoration-none">QL Sản Phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-dark mb-1">Cập Nhật Thông Tin Sản Phẩm</h3>
        <p class="text-muted small">Chỉnh sửa thông tin, cập nhật giá bán hoặc thay đổi ảnh đại diện cho sản phẩm #${p.productId}</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <i class="bi bi-pencil-square text-primary fs-5 me-2"></i>
                    <span class="fw-bold">Thông tin sản phẩm #${p.productId}</span>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="productEditForm">
                        <input type="hidden" name="productId" value="${p.productId}">

                        <div class="mb-3">
                            <label for="productName" class="form-label fw-semibold">
                                Tên sản phẩm <span class="text-danger">*</span>
                            </label>
                            <input type="text" 
                                   id="productName" 
                                   name="productName" 
                                   value="${p.productName}" 
                                   class="form-control" 
                                   required 
                                   minlength="2" 
                                   maxlength="200">
                            <div class="invalid-feedback">
                                Vui lòng nhập tên sản phẩm hợp lệ (từ 2 đến 200 ký tự).
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label fw-semibold">
                                    Giá bán (VNĐ) <span class="text-danger">*</span>
                                </label>
                                <div class="input-group has-validation">
                                    <input type="number" 
                                           id="price" 
                                           name="price" 
                                           value="${p.price}" 
                                           class="form-control" 
                                           required 
                                           min="1" 
                                           step="1000">
                                    <span class="input-group-text bg-light fw-bold text-muted">đ</span>
                                    <div class="invalid-feedback">
                                        Giá bán phải là số nguyên dương (> 0 đ).
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="quantity" class="form-label fw-semibold">
                                    Số lượng trong kho <span class="text-danger">*</span>
                                </label>
                                <div class="input-group has-validation">
                                    <input type="number" 
                                           id="quantity" 
                                           name="quantity" 
                                           value="${p.quantity}" 
                                           class="form-control" 
                                           required 
                                           min="0">
                                    <span class="input-group-text bg-light text-muted">cái</span>
                                    <div class="invalid-feedback">
                                        Số lượng phải lớn hơn hoặc bằng 0.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="categoryId" class="form-label fw-semibold">
                                Danh mục phân loại <span class="text-danger">*</span>
                            </label>
                            <select id="categoryId" name="categoryId" class="form-select" required>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryId}" ${c.categoryId == p.category.categoryId ? 'selected' : ''}>
                                        ${c.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn danh mục cho sản phẩm.
                            </div>
                        </div>

                        <!-- Current & New Image Section -->
                        <div class="row mb-4">
                            <div class="col-md-4 text-center border-end">
                                <label class="form-label fw-semibold d-block text-muted small">Ảnh hiện tại:</label>
                                <c:choose>
                                    <c:when test="${p.images != null && p.images.startsWith('http')}">
                                        <c:url value="${p.images}" var="currImg"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${p.images}" var="currImg"/>
                                    </c:otherwise>
                                </c:choose>
                                <img src="${currImg}" alt="Current Product Image" class="rounded shadow-sm border p-1" style="max-height: 140px; max-width: 100%; object-fit: contain;">
                            </div>

                            <div class="col-md-8">
                                <label for="productImageEditInput" class="form-label fw-semibold">
                                    Thay đổi ảnh đại diện (Bỏ trống nếu giữ nguyên)
                                </label>
                                <input type="file" 
                                       id="productImageEditInput" 
                                       name="images" 
                                       class="form-control" 
                                       accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" 
                                       onchange="previewEditImage(this)">
                                <div class="form-text text-muted small">
                                    Chỉ tải lên khi muốn thay đổi ảnh hiện tại. Dung lượng tối đa: 5MB (.jpg, .png, .webp).
                                </div>

                                <div id="editImagePreviewBox" class="mt-3 d-none">
                                    <span class="text-success small fw-semibold d-block mb-1"><i class="bi bi-eye me-1"></i>Ảnh mới được chọn:</span>
                                    <img id="editImagePreview" src="#" alt="New Preview" class="rounded shadow-sm border p-1" style="max-height: 120px; object-fit: contain;">
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 pt-3 border-top">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">
                                <i class="bi bi-save me-1"></i>Lưu Thay Đổi
                            </button>
                            <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary ms-auto">
                                <i class="bi bi-x-lg me-1"></i>Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Client-side script for image preview and validation -->
    <script>
        function previewEditImage(input) {
            const previewBox = document.getElementById('editImagePreviewBox');
            const previewImg = document.getElementById('editImagePreview');

            if (input.files && input.files[0]) {
                const file = input.files[0];

                if (file.size > 5242880) {
                    alert("Dung lượng file vượt quá 5MB! Vui lòng chọn file nhỏ hơn.");
                    input.value = "";
                    previewBox.classList.add('d-none');
                    return;
                }

                const allowedExt = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];
                const fileName = file.name.toLowerCase();
                const isValidExt = allowedExt.some(ext => fileName.endsWith(ext));
                if (!isValidExt) {
                    alert("Vui lòng chỉ chọn file hình ảnh (JPG, PNG, WEBP, GIF)!");
                    input.value = "";
                    previewBox.classList.add('d-none');
                    return;
                }

                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImg.src = e.target.result;
                    previewBox.classList.remove('d-none');
                };
                reader.readAsDataURL(file);
            } else {
                previewBox.classList.add('d-none');
            }
        }
    </script>
</body>
