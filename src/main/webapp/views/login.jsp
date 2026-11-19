<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
</head>
<body>
    <div class="card auth-card shadow-lg mx-auto" style="max-width: 440px; width: 100%;">
        <div class="card-header bg-primary text-white text-center py-3 rounded-top">
            <h4 class="mb-0 fw-bold"><i class="bi bi-shield-lock"></i> ĐĂNG NHẬP</h4>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>${alert}</div>
                </div>
            </c:if>

            <c:if test="${message != null}">
                <div class="alert alert-success d-flex align-items-center" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <div>${message}</div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên đăng nhập / Email: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Nhập tài khoản hoặc email" value="${username_val}" required autofocus>
                        <div class="invalid-feedback">Vui lòng nhập tên đăng nhập hoặc email!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-key"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                        <div class="invalid-feedback">Vui lòng nhập mật khẩu!</div>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input type="checkbox" name="remember" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Ghi nhớ</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small text-danger fw-semibold">
                        <i class="bi bi-question-circle"></i> Quên mật khẩu?
                    </a>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">
                    <i class="bi bi-box-arrow-in-right"></i> ĐĂNG NHẬP
                </button>
            </form>

            <div class="text-center mt-3 pt-3 border-top">
                <span>Chưa có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
