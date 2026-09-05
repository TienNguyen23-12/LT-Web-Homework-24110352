<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="sticky-top shadow-sm">
    <!-- Top info bar -->
    <div class="bg-dark text-white py-1 px-3 d-none d-md-block border-bottom border-secondary border-opacity-25" style="font-size: 0.85rem;">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <span class="me-3"><i class="bi bi-telephone-fill me-1 text-warning"></i> Hotline: 0339490483</span>
                <span><i class="bi bi-geo-alt-fill me-1 text-danger"></i> ĐH Công nghệ Kỹ Thuật TP.HCM (HCM-UTE)</span>
            </div>
            <div>
                <span class="badge bg-primary me-2"><i class="bi bi-lightning-charge-fill me-1"></i>LT Web 2026</span>
                <span class="text-white-50">Miễn phí giao hàng cho đơn từ 500k</span>
            </div>
        </div>
    </div>

    <!-- Main Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center fw-bold fs-4" href="<c:url value='/home'/>">
                <span class="badge rounded-circle p-2 bg-primary me-2 shadow-sm">
                    <i class="bi bi-shop fs-5"></i>
                </span>
                <span class="text-white">UTE<span class="text-primary ms-1">Store</span></span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarMain">
                <!-- Search bar in center -->
                <form class="d-flex mx-auto my-2 my-lg-0 col-12 col-lg-5" action="<c:url value='/product'/>" method="get">
                    <div class="input-group w-100 shadow-sm">
                        <input class="form-control border-0 rounded-start-pill ps-3" type="search" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm sản phẩm, thương hiệu..." aria-label="Search">
                        <button class="btn btn-primary rounded-end-pill px-4" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <!-- Navigation Links & User Menu -->
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item">
                        <a class="nav-link px-3 ${pageContext.request.requestURI.endsWith('/home') ? 'active fw-bold text-white' : ''}" href="<c:url value='/home'/>">
                            <i class="bi bi-house-door me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3 ${pageContext.request.requestURI.endsWith('/product') ? 'active fw-bold text-white' : ''}" href="<c:url value='/product'/>">
                            <i class="bi bi-grid me-1"></i>Sản phẩm
                        </a>
                    </li>

                    <c:if test="${sessionScope.user != null}">
                        <c:if test="${sessionScope.user.email == 'admin@gmail.com'}">
                            <li class="nav-item">
                                <a class="nav-link px-3 text-warning fw-semibold" href="<c:url value='/admin/products'/>">
                                    <i class="bi bi-shield-lock-fill me-1"></i>Quản trị
                                </a>
                            </li>
                        </c:if>

                        <li class="nav-item dropdown ms-lg-2">
                            <a class="nav-link dropdown-toggle d-flex align-items-center py-1 px-2 rounded-pill bg-dark bg-opacity-50 text-white" href="#" role="button" data-bs-toggle="dropdown">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.images && sessionScope.user.images != 'default.jpg'}">
                                        <img src="<c:url value='/image?fname=${sessionScope.user.images}'/>" alt="Avatar" class="rounded-circle me-2 border border-2 border-primary" style="width: 32px; height: 32px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle bg-primary text-white me-2 d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 14px;">
                                            ${sessionScope.user.fullname != null && sessionScope.user.fullname.length() > 0 ? sessionScope.user.fullname.substring(0,1).toUpperCase() : 'U'}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="fw-semibold me-1">${sessionScope.user.fullname}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-2 py-2">
                                <li class="px-3 py-2 border-bottom">
                                    <div class="fw-bold">${sessionScope.user.fullname}</div>
                                    <div class="text-muted small text-truncate" style="max-width: 180px;">${sessionScope.user.email}</div>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="<c:url value='/profile'/>">
                                        <i class="bi bi-person-circle me-2 text-primary"></i>Hồ sơ cá nhân
                                    </a>
                                </li>
                                <c:if test="${sessionScope.user.email == 'admin@gmail.com'}">
                                    <li>
                                        <a class="dropdown-item py-2" href="<c:url value='/admin/products'/>">
                                            <i class="bi bi-speedometer2 me-2 text-warning"></i>Bảng điều khiển Admin
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 text-danger fw-semibold" href="<c:url value='/login'/>">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:if>

                    <c:if test="${sessionScope.user == null}">
                        <li class="nav-item ms-lg-2">
                            <a class="btn btn-outline-light rounded-pill px-3 me-2" href="<c:url value='/login'/>">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary rounded-pill px-3 shadow-sm" href="<c:url value='/register'/>">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>
</header>
