<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-white sidebar collapse shadow-sm border-end py-3">
    <div class="position-sticky pt-2">
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-2 mb-2 text-muted text-uppercase small fw-bold">
            <span>Quản lý hệ thống</span>
        </h6>
        <ul class="nav flex-column mb-3">
            <li class="nav-item">
                <a class="nav-link text-dark py-2 px-3 fw-semibold rounded hover-bg" href="${pageContext.request.contextPath}/admin/category/list">
                    <i class="bi bi-folder2-open text-primary me-2"></i> Danh mục (Category)
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark py-2 px-3 rounded hover-bg" href="${pageContext.request.contextPath}/admin/category/add">
                    <i class="bi bi-folder-plus text-success me-2"></i> Thêm danh mục mới
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark py-2 px-3 rounded hover-bg" href="${pageContext.request.contextPath}/video">
                    <i class="bi bi-collection-play text-danger me-2"></i> Quản lý Video
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark py-2 px-3 rounded hover-bg" href="${pageContext.request.contextPath}/video/add">
                    <i class="bi bi-cloud-plus text-info me-2"></i> Thêm Video mới
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark py-2 px-3 rounded hover-bg" href="${pageContext.request.contextPath}/profile">
                    <i class="bi bi-person-badge text-warning me-2"></i> Hồ sơ cá nhân (Profile)
                </a>
            </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-3 mb-2 text-muted text-uppercase small fw-bold">
            <span>Liên kết nhanh</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-secondary py-1 px-3" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-house me-2"></i> Về Trang chủ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger py-1 px-3" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                </a>
            </li>
        </ul>
    </div>
</nav>
