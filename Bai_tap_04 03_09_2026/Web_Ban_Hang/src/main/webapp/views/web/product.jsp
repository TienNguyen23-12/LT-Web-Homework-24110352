<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<head>
    <title>Danh Sách Sản Phẩm - UTE Store</title>
</head>
<body>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Tất cả sản phẩm</li>
        </ol>
    </nav>

    <!-- Page Header & Search Bar -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h2 class="fw-bold text-dark mb-1">Tất Cả Sản Phẩm</h2>
            <c:if test="${not empty keyword}">
                <p class="text-muted small mb-0">
                    Kết quả tìm kiếm cho: <span class="badge bg-primary fs-6">${keyword}</span>
                    <a href="<c:url value='/product'/>" class="text-danger ms-2 text-decoration-none"><i class="bi bi-x-circle"></i> Bỏ lọc</a>
                </p>
            </c:if>
            <c:if test="${empty keyword}">
                <p class="text-muted small mb-0">Danh sách các sản phẩm công nghệ mới nhất có sẵn tại UTE Store</p>
            </c:if>
        </div>

        <div class="mt-2 mt-md-0">
            <form action="<c:url value='/product'/>" method="get" class="d-flex">
                <div class="input-group input-group-sm" style="max-width: 320px;">
                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Product Grid -->
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty listproduct}">
                <c:forEach items="${listproduct}" var="p">
                    <div class="col-6 col-md-4 col-lg-4">
                        <div class="card h-100 card-product border-0 shadow-sm overflow-hidden position-relative">
                            <!-- Category Badge -->
                            <span class="position-absolute top-0 start-0 m-2 badge bg-dark bg-opacity-75 text-white" style="z-index: 2;">
                                ${p.category.categoryname}
                            </span>

                            <!-- Image -->
                            <div class="text-center p-3 bg-white" style="height: 230px;">
                                <c:choose>
                                    <c:when test="${p.images != null && p.images.startsWith('http')}">
                                        <c:url value="${p.images}" var="prodImgUrl"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${p.images}" var="prodImgUrl"/>
                                    </c:otherwise>
                                </c:choose>
                                <img src="${prodImgUrl}" alt="${p.productName}" class="img-fluid h-100" style="object-fit: contain;">
                            </div>

                            <div class="card-body d-flex flex-column p-4">
                                <h5 class="card-title text-truncate fw-semibold mb-2" title="${p.productName}">
                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none hover-text-primary">
                                        ${p.productName}
                                    </a>
                                </h5>
                                <div class="mt-auto">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-danger fw-bold fs-5">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                        </span>
                                        <span class="badge bg-secondary bg-opacity-10 text-muted small">
                                            Còn: ${p.quantity}
                                        </span>
                                    </div>
                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-primary w-100 rounded-pill fw-semibold shadow-sm">
                                        <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 py-5 text-center text-muted">
                    <i class="bi bi-search fs-1 d-block mb-3 text-secondary"></i>
                    <h4>Không tìm thấy sản phẩm phù hợp</h4>
                    <p class="small">Vui lòng thử tìm kiếm với từ khóa khác hoặc quay lại danh sách ban đầu.</p>
                    <a href="<c:url value='/product'/>" class="btn btn-outline-primary rounded-pill px-4 mt-2">
                        Xem tất cả sản phẩm
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination & Jump Page with Validation -->
    <c:if test="${totalPages > 1}">
        <div class="d-flex flex-wrap justify-content-center align-items-center gap-3 mt-5">
            <ul class="pagination mb-0 shadow-sm">
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}&keyword=${keyword}'/>">
                        <i class="bi bi-chevron-left me-1"></i>Trước
                    </a>
                </li>

                <c:choose>
                    <c:when test="${totalPages <= 7}">
                        <c:forEach begin="0" end="${totalPages - 1}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/product?page=${i}&keyword=${keyword}'/>">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item ${currentPage == 0 ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/product?page=0&keyword=${keyword}'/>">1</a>
                        </li>
                        <c:if test="${currentPage > 2}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>

                        <c:set var="startPage" value="${currentPage - 1}" />
                        <c:set var="endPage" value="${currentPage + 1}" />
                        <c:if test="${startPage <= 0}"><c:set var="startPage" value="1" /><c:set var="endPage" value="3" /></c:if>
                        <c:if test="${endPage >= totalPages - 1}"><c:set var="startPage" value="${totalPages - 4}" /><c:set var="endPage" value="${totalPages - 2}" /></c:if>

                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/product?page=${i}&keyword=${keyword}'/>">${i + 1}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages - 3}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                        <li class="page-item ${currentPage == totalPages - 1 ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/product?page=${totalPages - 1}&keyword=${keyword}'/>">${totalPages}</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}&keyword=${keyword}'/>">
                        Sau<i class="bi bi-chevron-right ms-1"></i>
                    </a>
                </li>
            </ul>

            <!-- Jump page form with validation -->
            <form class="d-flex align-items-center" onsubmit="event.preventDefault(); var p = document.getElementById('jumpWebPage').value; if(p>=1 && p<=${totalPages}){window.location.href='<c:url value="/product"/>?page=' + (p - 1) + '&keyword=${keyword}';}">
                <span class="me-2 text-muted small">Đến trang:</span>
                <input type="number" id="jumpWebPage" min="1" max="${totalPages}" class="form-control form-control-sm text-center shadow-sm" style="width: 65px;" required placeholder="1">
                <button type="submit" class="btn btn-sm btn-outline-secondary ms-1">Đi</button>
            </form>
        </div>
    </c:if>
</body>
