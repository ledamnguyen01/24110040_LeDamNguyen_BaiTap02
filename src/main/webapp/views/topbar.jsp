<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-play-circle-fill"></i> Shopping & Video MVC
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door"></i> Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/video"><i class="bi bi-collection-play"></i> Danh sách Video (6sp/trang)</a>
                </li>
                <c:if test="${sessionScope.account != null}">
                    <li class="nav-item">
                        <a class="nav-link text-info" href="${pageContext.request.contextPath}/video?type=my"><i class="bi bi-person-video"></i> Video của tôi</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/category/list">
                            <i class="bi bi-gear"></i> Quản lý danh mục
                        </a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item text-white me-3">
                            <i class="bi bi-person-circle"></i> Xin chào, <span class="fw-bold text-info">${sessionScope.account.fullName}</span>
                            <span class="badge bg-secondary ms-1">
                                <c:choose>
                                    <c:when test="${sessionScope.account.roleid == 1}">Admin</c:when>
                                    <c:when test="${sessionScope.account.roleid == 2}">Manager</c:when>
                                    <c:otherwise>Khách hàng</c:otherwise>
                                </c:choose>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
