<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Thêm Sản Phẩm Mới</title>
</head>
<body>
    <div class="mb-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/products'/>" class="text-decoration-none">QL Sản Phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-dark mb-1">Thêm Sản Phẩm Mới</h3>
        <p class="text-muted small">Nhập đầy đủ thông tin, giá bán, số lượng kho và tải lên hình ảnh sản phẩm</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <i class="bi bi-box-seam-fill text-primary fs-5 me-2"></i>
                    <span class="fw-bold">Thông tin chi tiết sản phẩm</span>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="productAddForm">
                        <div class="mb-3">
                            <label for="productName" class="form-label fw-semibold">
                                Tên sản phẩm <span class="text-danger">*</span>
                            </label>
                            <input type="text" 
                                   id="productName" 
                                   name="productName" 
                                   value="${productName}" 
                                   class="form-control" 
                                   placeholder="Ví dụ: iPhone 15 Pro Max 256GB" 
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
                                           value="${price}" 
                                           class="form-control" 
                                           placeholder="100000" 
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
                                           value="${quantity != null ? quantity : 1}" 
                                           class="form-control" 
                                           placeholder="10" 
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
                                <option value="">-- Chọn danh mục sản phẩm --</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryId}" ${selectedCategoryId == c.categoryId ? 'selected' : ''}>
                                        ${c.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn danh mục cho sản phẩm.
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="productImageInput" class="form-label fw-semibold">
                                Hình ảnh đại diện <span class="text-danger">*</span>
                            </label>
                            <input type="file" 
                                   id="productImageInput" 
                                   name="images" 
                                   class="form-control" 
                                   accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" 
                                   required 
                                   onchange="previewProductImage(this)">
                            <div class="invalid-feedback">
                                Vui lòng chọn một file ảnh hợp lệ (.jpg, .jpeg, .png, .webp, dung lượng dưới 5MB).
                            </div>
                            <div class="form-text text-muted small">
                                Định dạng hỗ trợ: JPG, PNG, WEBP, GIF. Kích thước tối đa: 5MB.
                            </div>

                            <!-- Live Image Preview Area -->
                            <div id="imagePreviewBox" class="mt-3 text-center d-none">
                                <span class="text-muted small d-block mb-1">Xem trước ảnh:</span>
                                <img id="imagePreview" src="#" alt="Preview" class="rounded shadow-sm border p-1" style="max-height: 180px; max-width: 100%; object-fit: contain;">
                            </div>
                        </div>

                        <div class="d-flex gap-2 pt-3 border-top">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">
                                <i class="bi bi-cloud-arrow-up-fill me-1"></i>Lưu Sản Phẩm
                            </button>
                            <button type="reset" class="btn btn-light border px-4" onclick="document.getElementById('imagePreviewBox').classList.add('d-none');">
                                <i class="bi bi-arrow-counterclockwise me-1"></i>Làm lại
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

    <!-- Client-side script for image preview and file size check -->
    <script>
        function previewProductImage(input) {
            const previewBox = document.getElementById('imagePreviewBox');
            const previewImg = document.getElementById('imagePreview');
            
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Validate file size: 5MB = 5242880 bytes
                if (file.size > 5242880) {
                    alert("Dung lượng file quá lớn! Vui lòng chọn file nhỏ hơn 5MB.");
                    input.value = "";
                    previewBox.classList.add('d-none');
                    return;
                }

                // Validate extension
                const allowedExt = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];
                const fileName = file.name.toLowerCase();
                const isValidExt = allowedExt.some(ext => fileName.endsWith(ext));
                if (!isValidExt) {
                    alert("Định dạng file không hỗ trợ! Vui lòng chỉ chọn file ảnh JPG, PNG, WEBP hoặc GIF.");
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
