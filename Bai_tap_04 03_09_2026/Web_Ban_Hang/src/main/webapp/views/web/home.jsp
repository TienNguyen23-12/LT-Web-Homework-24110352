<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <title>Trang Chủ - UTE Store</title>
</head>
<body>
    <!-- Hero Banner -->
    <div class="p-5 mb-5 rounded-4 text-white shadow-sm position-relative overflow-hidden" 
         style="background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #4f46e5 100%);">
        <div class="row align-items-center position-relative" style="z-index: 1;">
            <div class="col-lg-8">
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-3 shadow-sm">
                    <i class="bi bi-fire me-1"></i>SẢN PHẨM CÔNG NGHỆ 2026
                </span>
                <h1 class="display-5 fw-bold mb-3">Chào Mừng Bạn Đến Với UTE Store</h1>
                <p class="lead text-white-50 mb-4" style="max-width: 600px;">
                    Khám phá hàng loạt thiết bị công nghệ chính hãng, điện thoại, máy tính và phụ kiện cao cấp với mức giá ưu đãi nhất dành riêng cho sinh viên UTE.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="<c:url value='/product'/>" class="btn btn-warning btn-lg rounded-pill px-4 fw-bold shadow">
                        <i class="bi bi-cart3 me-2"></i>Mua Sắm Ngay
                    </a>
                    <c:if test="${sessionScope.user == null}">
                        <a href="<c:url value='/register'/>" class="btn btn-outline-light btn-lg rounded-pill px-4">
                            <i class="bi bi-person-plus me-2"></i>Đăng Ký Thành Viên
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="col-lg-4 d-none d-lg-block text-center">
                <i class="bi bi-laptop-fill" style="font-size: 10rem; color: rgba(255, 255, 255, 0.15);"></i>
            </div>
        </div>
    </div>

    <!-- Features Banner -->
    <div class="row g-4 mb-5">
        <div class="col-md-3 col-sm-6">
            <div class="d-flex align-items-center p-3 bg-white rounded-3 shadow-sm border">
                <div class="rounded-circle bg-primary bg-opacity-10 text-primary p-3 me-3">
                    <i class="bi bi-truck fs-4"></i>
                </div>
                <div>
                    <h6 class="fw-bold mb-1">Giao Hàng Miễn Phí</h6>
                    <small class="text-muted">Đơn từ 500.000 đ</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="d-flex align-items-center p-3 bg-white rounded-3 shadow-sm border">
                <div class="rounded-circle bg-success bg-opacity-10 text-success p-3 me-3">
                    <i class="bi bi-shield-check fs-4"></i>
                </div>
                <div>
                    <h6 class="fw-bold mb-1">Chính Hãng 100%</h6>
                    <small class="text-muted">Bảo hành toàn diện 12T</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="d-flex align-items-center p-3 bg-white rounded-3 shadow-sm border">
                <div class="rounded-circle bg-warning bg-opacity-10 text-warning p-3 me-3">
                    <i class="bi bi-arrow-repeat fs-4"></i>
                </div>
                <div>
                    <h6 class="fw-bold mb-1">Đổi Trả 30 Ngày</h6>
                    <small class="text-muted">Nếu phát sinh lỗi NSX</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="d-flex align-items-center p-3 bg-white rounded-3 shadow-sm border">
                <div class="rounded-circle bg-info bg-opacity-10 text-info p-3 me-3">
                    <i class="bi bi-headset fs-4"></i>
                </div>
                <div>
                    <h6 class="fw-bold mb-1">Hỗ Trợ 24/7</h6>
                    <small class="text-muted">Tư vấn tận tâm</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Section: 10 Newest Products -->
    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-2">
        <div>
            <span class="badge bg-danger text-white px-2 py-1 small fw-semibold text-uppercase">Mới Nhất</span>
            <h2 class="fw-bold text-dark mt-1 mb-0">10 Sản Phẩm Mới Lên Kệ</h2>
        </div>
        <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm rounded-pill px-3">
            Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row g-4">
        <c:forEach items="${top10}" var="p">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="card h-100 card-product border-0 shadow-sm overflow-hidden position-relative">
                    <!-- Category Badge -->
                    <span class="position-absolute top-0 start-0 m-2 badge bg-dark bg-opacity-75 text-white" style="z-index: 2;">
                        ${p.category.categoryname}
                    </span>

                    <!-- Image -->
                    <div class="text-center p-3 bg-white" style="height: 200px;">
                        <c:choose>
                            <c:when test="${p.images != null && p.images.startsWith('http')}">
                                <c:url value="${p.images}" var="homeImgUrl"/>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="homeImgUrl"/>
                            </c:otherwise>
                        </c:choose>
                        <img src="${homeImgUrl}" alt="${p.productName}" class="img-fluid h-100" style="object-fit: contain;">
                    </div>

                    <div class="card-body d-flex flex-column p-3">
                        <h6 class="card-title text-truncate fw-semibold mb-2" title="${p.productName}">
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none hover-text-primary">
                                ${p.productName}
                            </a>
                        </h6>
                        <div class="mt-auto">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-danger fw-bold fs-5">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                </span>
                                <span class="badge bg-secondary bg-opacity-10 text-muted small">
                                    Kho: ${p.quantity}
                                </span>
                            </div>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary w-100 rounded-pill fw-semibold btn-sm">
                                <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
