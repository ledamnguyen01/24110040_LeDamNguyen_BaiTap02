<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-circle-fill"></i> Shopping & Video MVC
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 text-nowrap">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/video">
                            <i class="bi bi-collection-play"></i> Video
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
                                <i class="bi bi-person-badge"></i> Hồ sơ
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/category/list">
                                <i class="bi bi-gear-fill"></i> Quản trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center text-nowrap">
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
                                <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none text-white d-flex align-items-center gap-2">
                                    <c:choose>
                                        <c:when test="${sessionScope.account.avatar != null && sessionScope.account.avatar.startsWith('http')}">
                                            <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle border border-info" style="width: 30px; height: 30px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar != null ? sessionScope.account.avatar : 'avata.png'}"
                                                 alt="Avatar" class="rounded-circle border border-info" style="width: 30px; height: 30px; object-fit: cover;"
                                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png'">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>Xin chào, <strong class="text-info">${sessionScope.account.fullName}</strong></span>
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
</header>
