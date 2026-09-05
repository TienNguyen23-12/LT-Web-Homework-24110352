<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <title>Quản Lý Sản Phẩm</title>
</head>
<body>
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">Quản Lý Sản Phẩm</h3>
            <p class="text-muted small mb-0">Quản lý kho hàng, giá cả và danh sách sản phẩm hiển thị trên website</p>
        </div>
        <div>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary rounded-pill shadow-sm px-3">
                <i class="bi bi-plus-lg me-1"></i>Thêm sản phẩm mới
            </a>
        </div>
    </div>

    <!-- Flash message alerts -->
    <c:if test="${param.message == 'add_success'}">
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill fs-5 me-2"></i>
            <div>Thêm sản phẩm mới thành công!</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.message == 'update_success'}">
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill fs-5 me-2"></i>
            <div>Cập nhật thông tin sản phẩm thành công!</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <div class="row align-items-center g-2">
                <!-- Page size selector -->
                <div class="col-md-4 d-flex align-items-center">
                    <span class="text-muted small me-2">Hiển thị</span>
                    <select class="form-select form-select-sm w-auto shadow-none" onchange="window.location.href='<c:url value="/admin/products"/>?size=' + this.value + '&keyword=${keyword}';">
                        <option value="5" ${currentSize == 5 ? 'selected' : ''}>5</option>
                        <option value="10" ${currentSize == 10 ? 'selected' : ''}>10</option>
                        <option value="25" ${currentSize == 25 ? 'selected' : ''}>25</option>
                        <option value="50" ${currentSize == 50 ? 'selected' : ''}>50</option>
                    </select>
                    <span class="text-muted small ms-2">sản phẩm / trang</span>
                </div>

                <!-- Search form with validation -->
                <div class="col-md-8">
                    <form action="<c:url value='/admin/products'/>" method="get" class="d-flex justify-content-md-end">
                        <div class="input-group input-group-sm" style="max-width: 340px;">
                            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên sản phẩm...">
                            <input type="hidden" name="size" value="${currentSize}">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-search"></i>
                            </button>
                            <c:if test="${not empty keyword}">
                                <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary" title="Xóa tìm kiếm">
                                    <i class="bi bi-x"></i>
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-muted small text-uppercase">
                        <tr>
                            <th style="width: 5%;" class="ps-4">STT</th>
                            <th style="width: 12%;">Hình Ảnh</th>
                            <th style="width: 30%;">Tên Sản Phẩm</th>
                            <th style="width: 15%;">Danh Mục</th>
                            <th style="width: 13%;">Giá Bán</th>
                            <th style="width: 10%;">Tồn Kho</th>
                            <th style="width: 15%;" class="text-end pe-4">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listproduct}">
                                <c:forEach items="${listproduct}" var="p" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 text-muted">${currentPage * currentSize + stt.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.images != null && p.images.startsWith('http')}">
                                                    <c:url value="${p.images}" var="pImgUrl"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="/image?fname=${p.images}" var="pImgUrl"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <img src="${pImgUrl}" alt="${p.productName}" class="rounded border p-1 bg-white shadow-sm" style="width: 55px; height: 55px; object-fit: contain;">
                                        </td>
                                        <td>
                                            <div class="fw-bold text-dark text-truncate" style="max-width: 280px;" title="${p.productName}">
                                                ${p.productName}
                                            </div>
                                            <small class="text-muted font-monospace">Mã: #${p.productId}</small>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1">
                                                <i class="bi bi-tag me-1"></i>${p.category.categoryname}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-danger fw-bold fs-6">
                                                <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.quantity > 10}">
                                                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">
                                                        ${p.quantity} cái
                                                    </span>
                                                </c:when>
                                                <c:when test="${p.quantity > 0}">
                                                    <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-2 py-1">
                                                        Còn ít (${p.quantity})
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">
                                                        Hết hàng
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <div class="btn-group btn-group-sm">
                                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-secondary" title="Xem trên web" target="_blank">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-outline-primary" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" 
                                                   class="btn btn-outline-danger" 
                                                   title="Xóa sản phẩm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm \"${p.productName}\"?');">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-box2 fs-1 d-block mb-2 text-secondary"></i>
                                        Không tìm thấy sản phẩm nào phù hợp!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination & Jump Page -->
        <c:if test="${totalPages > 1}">
            <div class="card-footer bg-white py-3">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
                    <div class="text-muted small">
                        Hiển thị trang <strong>${currentPage + 1}</strong> / <strong>${totalPages}</strong>
                    </div>

                    <div class="d-flex align-items-center flex-wrap gap-3">
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/products?page=${currentPage - 1}&size=${currentSize}&keyword=${keyword}'/>">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>

                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                <c:if test="${i == 0 || i == totalPages - 1 || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="<c:url value='/admin/products?page=${i}&size=${currentSize}&keyword=${keyword}'/>">${i + 1}</a>
                                    </li>
                                </c:if>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/products?page=${currentPage + 1}&size=${currentSize}&keyword=${keyword}'/>">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>

                        <!-- Jump page form with validation -->
                        <form class="d-flex align-items-center" onsubmit="event.preventDefault(); var p = document.getElementById('jumpAdminProdPage').value; if(p>=1 && p<=${totalPages}){window.location.href='<c:url value="/admin/products"/>?page=' + (p - 1) + '&size=${currentSize}&keyword=${keyword}';}">
                            <span class="me-2 text-muted small">Đến trang:</span>
                            <input type="number" id="jumpAdminProdPage" min="1" max="${totalPages}" class="form-control form-control-sm text-center" style="width: 60px;" required placeholder="1">
                            <button type="submit" class="btn btn-sm btn-outline-secondary ms-1">Đi</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
