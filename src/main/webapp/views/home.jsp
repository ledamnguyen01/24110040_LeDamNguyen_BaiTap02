<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Shopping MVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container py-4">
        <div class="p-5 mb-4 bg-white rounded-3 shadow-sm border">
            <div class="container-fluid py-2">
                <h1 class="display-6 fw-bold text-primary">
                    <i class="bi bi-stars"></i> Chào mừng đến với Hệ thống Lập Trình Web MVC!
                </h1>
                <p class="col-md-8 fs-5 text-muted mt-3">
                    Đồ án môn Lập Trình Web (HCMUTE) - ThS. Nguyễn Hữu Trung. Kiến trúc 3 tầng (Model - DAO - Service - Controller) & Quản lý Session/Cookie.
                </p>

                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <div class="alert alert-info mt-4">
                            <h5><i class="bi bi-info-circle"></i> Thông tin phiên đăng nhập hiện tại:</h5>
                            <ul class="mb-0">
                                <li><strong>Họ và tên:</strong> ${sessionScope.account.fullName}</li>
                                <li><strong>Tài khoản (Username):</strong> ${sessionScope.account.userName}</li>
                                <li><strong>Email:</strong> ${sessionScope.account.email}</li>
                                <li><strong>Số điện thoại:</strong> ${sessionScope.account.phone}</li>
                                <li><strong>Vai trò (Role ID):</strong> 
                                    <c:choose>
                                        <c:when test="${sessionScope.account.roleid == 1}">1 (Quản trị viên - Admin)</c:when>
                                        <c:when test="${sessionScope.account.roleid == 2}">2 (Quản lý - Manager)</c:when>
                                        <c:otherwise>5 (Người dùng thông thường)</c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-warning btn-lg fw-bold">
                                    <i class="bi bi-grid-3x3-gap-fill"></i> Đến trang Quản lý Danh mục (CRUD Category)
                                </a>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg me-2">
                                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-success btn-lg">
                                <i class="bi bi-person-plus"></i> Đăng ký tài khoản
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
