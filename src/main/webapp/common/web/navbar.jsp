<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-play-circle-fill"></i> Shopping & Video MVC
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarWebMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarWebMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/video">
                        <i class="bi bi-collection-play"></i> Video (6sp/trang)
                    </a>
                </li>
                <c:if test="${sessionScope.account != null}">
                    <li class="nav-item">
                        <a class="nav-link text-info" href="${pageContext.request.contextPath}/video?type=my">
                            <i class="bi bi-person-video"></i> Video của tôi
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-success" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-badge"></i> Hồ sơ (Profile)
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/category/list">
                            <i class="bi bi-gear-fill"></i> Quản trị Admin
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-warning btn-sm fw-bold" href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus"></i> Đăng ký
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item text-white me-3">
                            <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none text-white">
                                <i class="bi bi-person-circle text-info"></i> Xin chào, 
                                <strong class="text-info">${sessionScope.account.fullName}</strong>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-danger btn-sm fw-bold" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
