<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<footer class="bg-dark text-white pt-4 pb-3 mt-auto border-top border-secondary">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-6 mb-3">
                <h5 class="text-warning fw-bold"><i class="bi bi-play-circle-fill"></i> Shopping & Video MVC</h5>
                <p class="text-white-50 small mb-1">
                    Hệ thống MVC 3 lớp kết hợp Sitemesh Decorator 3, Form Validation (Bootstrap 5) và Upload Cloudinary.
                </p>
                <p class="text-white-50 small">
                    Môn: Lập trình Web - Giảng viên: ThS. Nguyễn Hữu Trung - HCMUTE
                </p>
            </div>
            <div class="col-md-3 mb-3">
                <h6 class="text-uppercase fw-bold text-light mb-2">Liên kết</h6>
                <ul class="list-unstyled small">
                    <li><a href="${pageContext.request.contextPath}/home" class="text-white-50 text-decoration-none">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/video" class="text-white-50 text-decoration-none">Danh sách Video</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="text-white-50 text-decoration-none">Hồ sơ cá nhân</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-3">
                <h6 class="text-uppercase fw-bold text-light mb-2">Thông tin sinh viên</h6>
                <p class="text-white-50 small mb-1"><i class="bi bi-person-fill"></i> Lê Đàm Nguyên</p>
                <p class="text-white-50 small mb-1"><i class="bi bi-card-heading"></i> MSSV: 24110040</p>
                <p class="text-white-50 small"><i class="bi bi-calendar-event"></i> Bài tập 04 (19/11/2026)</p>
            </div>
        </div>
        <hr class="border-secondary my-2">
        <div class="text-center text-white-50 small">
            &copy; 2026 <strong>Lê Đàm Nguyên - 24110040</strong>. All rights reserved. HCMUTE.
        </div>
    </div>
</footer>
