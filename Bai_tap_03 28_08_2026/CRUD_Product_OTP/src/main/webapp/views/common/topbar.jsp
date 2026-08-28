<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<c:url value='/home'/>">Cửa Hàng ABC</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="<c:url value='/product'/>">Sản phẩm</a></li>
                <c:if test="${sessionScope.user != null && sessionScope.user.email == 'admin@gmail.com'}">
                    <li class="nav-item"><a class="nav-link fw-bold text-warning" href="<c:url value='/admin/products'/>">QL Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link fw-bold text-warning" href="<c:url value='/admin/categories'/>">QL Danh mục</a></li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item"><span class="nav-link text-white me-3">Xin chào, <b>${sessionScope.user.fullname}</b></span></li>
                    <li class="nav-item"><a class="nav-link text-danger fw-bold" href="<c:url value='/login'/>">Đăng xuất</a></li>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <li class="nav-item"><a class="nav-link text-success fw-bold" href="<c:url value='/login'/>">Đăng nhập</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
