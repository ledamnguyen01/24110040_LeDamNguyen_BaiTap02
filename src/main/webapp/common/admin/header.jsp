<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-2 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6 fw-bold text-warning" href="${pageContext.request.contextPath}/admin/category/list">
        <i class="bi bi-shield-shaded"></i> ADMIN PANEL - MVC
    </a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-nav ms-auto flex-row align-items-center">
        <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none text-white-50 small me-3 d-none d-sm-inline-flex align-items-center gap-2">
            <c:choose>
                <c:when test="${sessionScope.account.avatar != null && sessionScope.account.avatar.startsWith('http')}">
                    <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle border border-success" style="width: 26px; height: 26px; object-fit: cover;">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar != null ? sessionScope.account.avatar : 'avata.png'}"
                         alt="Avatar" class="rounded-circle border border-success" style="width: 26px; height: 26px; object-fit: cover;"
                         onerror="this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png'">
                </c:otherwise>
            </c:choose>
            <span>${sessionScope.account.fullName} (Admin)</span>
        </a>
        <a class="btn btn-sm btn-outline-light me-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-box-arrow-up-right"></i> Về Website
        </a>
        <a class="btn btn-sm btn-danger me-3" href="${pageContext.request.contextPath}/logout">
            <i class="bi bi-box-arrow-right"></i> Đăng xuất
        </a>
    </div>
</header>
