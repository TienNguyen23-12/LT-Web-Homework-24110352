<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 27/08/2026
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .page-header { margin-bottom: 20px; }
        .page-header h2 { color: #dc3545; font-weight: 500; }
        .page-header p { color: #6c757d; }
        .table-image { width: 100px; height: 100px; object-fit: contain; background-color: #f8f9fa; border-radius: 50%; padding: 10px; }
        .card-header { background-color: #f4f4f4; font-weight: 500; }
    </style>
</head>
<body class="bg-light">
<jsp:include page="/views/common/topbar.jsp"></jsp:include>

<div class="container mt-4 mb-5">
    <div class="page-header">
        <h2>Quản lý sản phẩm</h2>
        <p>Nơi bạn có thể quản lý sản phẩm của mình</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">
            Danh sách sản phẩm
        </div>
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div class="d-flex align-items-center">
                    <select class="form-select form-select-sm w-auto me-2" onchange="window.location.href='<c:url value="/admin/products"/>?size=' + this.value + '&keyword=${keyword}';">
                        <option value="5" ${currentSize == 5 ? 'selected' : ''}>5</option>
                        <option value="10" ${currentSize == 10 ? 'selected' : ''}>10</option>
                        <option value="25" ${currentSize == 25 ? 'selected' : ''}>25</option>
                        <option value="50" ${currentSize == 50 ? 'selected' : ''}>50</option>
                    </select>
                    <span>records per page</span>
                </div>
                <form action="<c:url value='/admin/products'/>" method="get" class="d-flex align-items-center">
                    <span class="me-2">Search:</span>
                    <input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm w-auto me-2">
                    <input type="hidden" name="size" value="${currentSize}">
                    <button type="submit" class="btn btn-sm btn-primary">Tìm</button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 15%;">Hình ảnh</th>
                            <th style="width: 25%;">Tên sản phẩm</th>
                            <th style="width: 15%;">Danh mục</th>
                            <th style="width: 10%;">Giá</th>
                            <th style="width: 10%;">Số lượng</th>
                            <th style="width: 20%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listproduct}" var="p" varStatus="STT">
                            <tr>
                                <td>${STT.index + 1}</td>
                                <td>
                                    <c:if test="${p.images != null && p.images.length() >= 5 && p.images.substring(0,5)=='https'}">
                                        <c:url value="${p.images}" var="imgUrl"></c:url>
                                    </c:if>
                                    <c:if test="${p.images == null || p.images.length() < 5 || p.images.substring(0,5)!='https'}">
                                        <c:url value="/image?fname=${p.images}" var="imgUrl"></c:url>
                                    </c:if>
                                    <img src="${imgUrl}" class="table-image" alt="image">
                                </td>
                                <td class="fw-bold">${p.productName}</td>
                                <td><span class="badge bg-info text-dark">${p.category.categoryname}</span></td>
                                <td class="text-danger fw-bold">${p.price}</td>
                                <td>${p.quantity}</td>
                                <td>
                                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="text-decoration-none text-info">Sửa</a> |
                                    <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="text-decoration-none text-info" onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="mt-4">
                <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary mb-3">Thêm sản phẩm</a>
                
                <div class="d-flex justify-content-center align-items-center flex-wrap">
                    <ul class="pagination mb-0">
                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/products?page=${currentPage - 1}&size=${currentSize}&keyword=${keyword}'/>">Trang trước</a>
                        </li>
                        <c:choose>
                            <c:when test="${totalPages <= 7}">
                                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="<c:url value='/admin/products?page=${i}&size=${currentSize}&keyword=${keyword}'/>">${i + 1}</a>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item ${currentPage == 0 ? 'active' : ''}"><a class="page-link" href="<c:url value='/admin/products?page=0&size=${currentSize}&keyword=${keyword}'/>">1</a></li>
                                <c:if test="${currentPage > 2}"><li class="page-item disabled"><span class="page-link">...</span></li></c:if>
                                <c:set var="startPage" value="${currentPage - 1}" />
                                <c:set var="endPage" value="${currentPage + 1}" />
                                <c:if test="${startPage <= 0}"><c:set var="startPage" value="1" /><c:set var="endPage" value="3" /></c:if>
                                <c:if test="${endPage >= totalPages - 1}"><c:set var="startPage" value="${totalPages - 4}" /><c:set var="endPage" value="${totalPages - 2}" /></c:if>
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="<c:url value='/admin/products?page=${i}&size=${currentSize}&keyword=${keyword}'/>">${i + 1}</a></li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages - 3}"><li class="page-item disabled"><span class="page-link">...</span></li></c:if>
                                <li class="page-item ${currentPage == totalPages - 1 ? 'active' : ''}"><a class="page-link" href="<c:url value='/admin/products?page=${totalPages - 1}&size=${currentSize}&keyword=${keyword}'/>">${totalPages}</a></li>
                            </c:otherwise>
                        </c:choose>
                        <li class="page-item ${currentPage == totalPages - 1 || totalPages == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/products?page=${currentPage + 1}&size=${currentSize}&keyword=${keyword}'/>">Trang sau</a>
                        </li>
                    </ul>
                    
                    <form class="d-flex align-items-center ms-4" onsubmit="event.preventDefault(); window.location.href='<c:url value="/admin/products"/>?page=' + (document.getElementById('jumpAdminPage').value - 1) + '&size=${currentSize}&keyword=${keyword}';">
                        <span class="me-2 fw-semibold text-secondary">Đến trang:</span>
                        <input type="number" id="jumpAdminPage" min="1" max="${totalPages}" class="form-control text-center shadow-sm" style="width: 70px;" required>
                        <button type="submit" class="btn btn-secondary ms-2 shadow-sm">Đi</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
