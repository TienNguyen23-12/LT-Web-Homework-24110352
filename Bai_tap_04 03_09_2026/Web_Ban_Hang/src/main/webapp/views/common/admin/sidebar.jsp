<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- AdminLTE 4 App Sidebar -->
<aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
    <!-- Sidebar Brand -->
    <div class="sidebar-brand">
        <a href="<c:url value='/admin/products'/>" class="brand-link text-decoration-none d-flex align-items-center">
            <span class="badge rounded-circle p-2 bg-warning text-dark me-2">
                <i class="bi bi-shield-check fs-6"></i>
            </span>
            <span class="brand-text fw-bold text-white">AdminLTE <span class="badge bg-danger ms-1" style="font-size: 0.65rem;">v4</span></span>
        </a>
    </div>

    <!-- Sidebar Wrapper -->
    <div class="sidebar-wrapper">
        <nav class="mt-2">
            <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="menu" data-accordion="false">
                <li class="nav-header text-uppercase text-white-50 px-3 pt-2" style="font-size: 0.75rem; letter-spacing: 1px;">Quản Lý Dữ Liệu</li>
                
                <li class="nav-item">
                    <a href="<c:url value='/admin/categories'/>" class="nav-link ${pageContext.request.requestURI.contains('/category') ? 'active' : ''}">
                        <i class="nav-icon bi bi-folder-fill text-info"></i>
                        <p>Quản Lý Danh Mục</p>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="<c:url value='/admin/products'/>" class="nav-link ${pageContext.request.requestURI.contains('/product') ? 'active' : ''}">
                        <i class="nav-icon bi bi-box-seam-fill text-warning"></i>
                        <p>Quản Lý Sản Phẩm</p>
                    </a>
                </li>

                <li class="nav-header text-uppercase text-white-50 px-3 pt-3" style="font-size: 0.75rem; letter-spacing: 1px;">Thao Tác Nhanh</li>
                <li class="nav-item">
                    <a href="<c:url value='/admin/category/add'/>" class="nav-link">
                        <i class="nav-icon bi bi-plus-circle-fill text-success"></i>
                        <p>Thêm Danh Mục</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/admin/product/add'/>" class="nav-link">
                        <i class="nav-icon bi bi-plus-square-fill text-primary"></i>
                        <p>Thêm Sản Phẩm</p>
                    </a>
                </li>

                <li class="nav-header text-uppercase text-white-50 px-3 pt-3" style="font-size: 0.75rem; letter-spacing: 1px;">Hệ Thống</li>
                <li class="nav-item">
                    <a href="<c:url value='/home'/>" class="nav-link" target="_blank">
                        <i class="nav-icon bi bi-globe text-info"></i>
                        <p>Xem Trang Chủ Store</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/profile'/>" class="nav-link">
                        <i class="nav-icon bi bi-person-circle text-light"></i>
                        <p>Hồ Sơ Của Tôi</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/login'/>" class="nav-link text-danger">
                        <i class="nav-icon bi bi-box-arrow-right text-danger"></i>
                        <p class="fw-bold">Đăng Xuất</p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>
