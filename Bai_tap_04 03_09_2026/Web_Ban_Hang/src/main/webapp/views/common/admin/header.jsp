<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- AdminLTE 4 App Header / Navbar -->
<nav class="app-header navbar navbar-expand bg-body shadow-sm">
    <div class="container-fluid">
        <!-- Start navbar links -->
        <ul class="navbar-nav align-items-center">
            <li class="nav-item">
                <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
                    <i class="bi bi-list fs-4"></i>
                </a>
            </li>
            <li class="nav-item d-none d-md-block">
                <a href="<c:url value='/admin/products'/>" class="nav-link fw-semibold">
                    <i class="bi bi-speedometer2 me-1 text-primary"></i>Bảng Điều Khiển
                </a>
            </li>
            <li class="nav-item d-none d-md-block">
                <a href="<c:url value='/home'/>" class="nav-link text-primary fw-semibold" target="_blank">
                    <i class="bi bi-box-arrow-up-right me-1"></i>Xem Cửa Hàng
                </a>
            </li>
        </ul>

        <!-- End navbar links -->
        <ul class="navbar-nav ms-auto align-items-center">
            <!-- User Dropdown Menu -->
            <li class="nav-item dropdown user-menu">
                <a href="#" class="nav-link dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                    <div class="rounded-circle bg-primary text-white me-2 d-flex align-items-center justify-content-center fw-bold shadow-sm" style="width: 34px; height: 34px;">
                        A
                    </div>
                    <span class="d-none d-md-inline fw-semibold">${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Admin'}</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end shadow border-0 mt-2">
                    <!-- User Header -->
                    <li class="user-header text-bg-primary text-center p-4">
                        <div class="rounded-circle bg-white text-primary mx-auto mb-2 d-flex align-items-center justify-content-center fw-bold fs-3 shadow" style="width: 65px; height: 65px;">
                            A
                        </div>
                        <p class="mb-0 fw-bold fs-6">
                            ${sessionScope.user.fullname != null ? sessionScope.user.fullname : 'Quản Trị Viên'}
                        </p>
                        <small class="text-white-50">${sessionScope.user.email}</small>
                    </li>
                    <!-- User Footer -->
                    <li class="user-footer d-flex justify-content-between p-3 bg-body-tertiary">
                        <a href="<c:url value='/profile'/>" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-person me-1"></i>Hồ sơ
                        </a>
                        <a href="<c:url value='/login'/>" class="btn btn-danger btn-sm">
                            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
