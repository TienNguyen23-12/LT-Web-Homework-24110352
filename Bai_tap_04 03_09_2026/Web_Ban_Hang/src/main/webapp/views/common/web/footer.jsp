<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="text-white mt-auto pt-5 border-top border-secondary border-opacity-25" style="background: linear-gradient(180deg, #0f172a 0%, #020617 100%);">
    <div class="container pb-4">
        <div class="row g-4">
            <!-- Col 1: Brand & About -->
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center mb-3">
                    <span class="badge rounded-circle p-2 bg-primary me-2">
                        <i class="bi bi-shop fs-5"></i>
                    </span>
                    <span class="fs-4 fw-bold text-white">UTE<span class="text-primary ms-1">Store</span></span>
                </div>
                <p class="text-secondary small leading-relaxed">
                    Hệ thống bán lẻ thiết bị công nghệ & phụ kiện uy tín hàng đầu. Dự án đồ án môn học Lập Trình Web - Trường Đại học Sư Phạm Kỹ Thuật TP.HCM (HCMUTE).
                </p>
                <div class="d-flex gap-2 mt-3">
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-white"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-white"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-white"><i class="bi bi-github"></i></a>
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-white"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>

            <!-- Col 2: Quick Links -->
            <div class="col-lg-2 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase" style="letter-spacing: 0.5px;">Liên kết nhanh</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="<c:url value='/home'/>" class="text-secondary text-decoration-none hover-text-primary"><i class="bi bi-chevron-right me-1"></i>Trang chủ</a></li>
                    <li class="mb-2"><a href="<c:url value='/product'/>" class="text-secondary text-decoration-none hover-text-primary"><i class="bi bi-chevron-right me-1"></i>Danh sách sản phẩm</a></li>
                    <li class="mb-2"><a href="<c:url value='/profile'/>" class="text-secondary text-decoration-none hover-text-primary"><i class="bi bi-chevron-right me-1"></i>Hồ sơ người dùng</a></li>
                    <li class="mb-2"><a href="<c:url value='/login'/>" class="text-secondary text-decoration-none hover-text-primary"><i class="bi bi-chevron-right me-1"></i>Tài khoản</a></li>
                </ul>
            </div>

            <!-- Col 3: Customer Support -->
            <div class="col-lg-3 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase" style="letter-spacing: 0.5px;">Chăm sóc khách hàng</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="#" class="text-secondary text-decoration-none"><i class="bi bi-shield-check me-2 text-success"></i>Chính sách bảo hành 12 tháng</a></li>
                    <li class="mb-2"><a href="#" class="text-secondary text-decoration-none"><i class="bi bi-truck me-2 text-info"></i>Giao hàng hỏa tốc trong 2h</a></li>
                    <li class="mb-2"><a href="#" class="text-secondary text-decoration-none"><i class="bi bi-arrow-repeat me-2 text-warning"></i>Đổi trả miễn phí 30 ngày</a></li>
                    <li class="mb-2"><a href="#" class="text-secondary text-decoration-none"><i class="bi bi-credit-card me-2 text-primary"></i>Hỗ trợ thanh toán linh hoạt</a></li>
                </ul>
            </div>

            <!-- Col 4: Contact info -->
            <div class="col-lg-3 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase" style="letter-spacing: 0.5px;">Thông tin liên hệ</h6>
                <ul class="list-unstyled small text-secondary">
                    <li class="mb-2 d-flex"><i class="bi bi-geo-alt-fill text-danger me-2"></i>Số 1 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM</li>
                    <li class="mb-2 d-flex"><i class="bi bi-telephone-fill text-warning me-2"></i>(028) 3896 8641 - 0987 654 321</li>
                    <li class="mb-2 d-flex"><i class="bi bi-envelope-fill text-info me-2"></i>support@utestore.edu.vn</li>
                    <li class="mb-2 d-flex"><i class="bi bi-clock-fill text-primary me-2"></i>T2 - T7: 08:00 - 21:00</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="border-top border-secondary border-opacity-25 py-3">
        <div class="container d-flex flex-wrap justify-content-between align-items-center text-secondary small">
            <div>
                © 2026 <strong>UTE Store</strong>. Thiết kế bài tập Lập Trình Web - Sitemesh Decorator 3 & Form Validation.
            </div>
            <div class="d-flex gap-3">
                <span class="badge bg-secondary bg-opacity-25 text-white-50">Phiên bản 1.0.0</span>
                <span>Powered by Jakarta EE 10 & Bootstrap 5.3</span>
            </div>
        </div>
    </div>
</footer>
