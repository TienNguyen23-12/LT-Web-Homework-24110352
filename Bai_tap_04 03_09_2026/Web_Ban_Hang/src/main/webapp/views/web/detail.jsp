<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <title>${p.productName} - UTE Store</title>
</head>
<body>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản phẩm</a></li>
            <li class="breadcrumb-item active text-truncate" aria-current="page" style="max-width: 300px;">${p.productName}</li>
        </ol>
    </nav>

    <div class="card shadow-sm border-0 mb-5 overflow-hidden">
        <div class="card-body p-4 p-md-5">
            <div class="row align-items-center g-5">
                <!-- Product Image Gallery -->
                <div class="col-md-5 text-center">
                    <div class="p-3 bg-white rounded-4 border shadow-sm d-inline-block w-100">
                        <c:choose>
                            <c:when test="${p.images != null && p.images.startsWith('http')}">
                                <c:url value="${p.images}" var="detImgUrl"/>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="detImgUrl"/>
                            </c:otherwise>
                        </c:choose>
                        <img src="${detImgUrl}" 
                             alt="${p.productName}" 
                             class="img-fluid rounded" 
                             style="max-height: 380px; width: auto; object-fit: contain;">
                    </div>
                </div>

                <!-- Product Information -->
                <div class="col-md-7">
                    <div class="mb-2">
                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-1 rounded-pill">
                            <i class="bi bi-tag-fill me-1"></i>${p.category.categoryname}
                        </span>
                        <span class="badge bg-secondary bg-opacity-10 text-muted ms-2 px-2 py-1">
                            Mã SP: #${p.productId}
                        </span>
                    </div>

                    <h1 class="fw-bold text-dark mb-3">${p.productName}</h1>

                    <div class="d-flex align-items-baseline mb-4">
                        <h2 class="text-danger fw-bold mb-0 me-3">
                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                        </h2>
                        <span class="text-muted text-decoration-line-through small">
                            <fmt:formatNumber value="${p.price * 1.15}" pattern="#,###"/> VNĐ
                        </span>
                        <span class="badge bg-danger ms-2">-15%</span>
                    </div>

                    <!-- Stock & Specifications -->
                    <div class="p-3 rounded-3 bg-light border mb-4">
                        <div class="row g-2 small">
                            <div class="col-6">
                                <span class="text-muted">Tình trạng kho:</span>
                                <c:choose>
                                    <c:when test="${p.quantity > 0}">
                                        <span class="badge bg-success bg-opacity-10 text-success ms-1">
                                            <i class="bi bi-check2-circle me-1"></i>Còn hàng (${p.quantity} sản phẩm)
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger bg-opacity-10 text-danger ms-1">
                                            <i class="bi bi-x-circle me-1"></i>Tạm hết hàng
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-6">
                                <span class="text-muted">Bảo hành:</span>
                                <span class="fw-semibold text-dark ms-1">12 Tháng Chính Hãng</span>
                            </div>
                            <div class="col-6">
                                <span class="text-muted">Vận chuyển:</span>
                                <span class="fw-semibold text-dark ms-1">Miễn phí nội thành</span>
                            </div>
                            <div class="col-6">
                                <span class="text-muted">Đổi trả:</span>
                                <span class="fw-semibold text-dark ms-1">30 ngày miễn phí</span>
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex gap-3 flex-wrap">
                        <button class="btn btn-primary btn-lg rounded-pill px-4 fw-semibold shadow-sm" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!');">
                            <i class="bi bi-cart-plus-fill me-2"></i>Thêm Vào Giỏ Hàng
                        </button>
                        <a href="<c:url value='/product'/>" class="btn btn-outline-secondary btn-lg rounded-pill px-4">
                            <i class="bi bi-arrow-left me-1"></i>Xem Sản Phẩm Khác
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
