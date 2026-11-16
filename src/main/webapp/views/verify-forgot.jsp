<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 440px; margin: 40px auto; border: none; border-radius: 12px; }
        .otp-input { letter-spacing: 8px; font-weight: bold; font-size: 24px; text-align: center; }
    </style>
</head>
<body>
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card auth-card shadow-lg">
            <div class="card-header bg-danger text-white text-center py-3 rounded-top">
                <h4 class="mb-0 fw-bold"><i class="bi bi-shield-lock-fill"></i> ĐẶT LẠI MẬT KHẨU</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${alert != null}">
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <div>${alert}</div>
                    </div>
                </c:if>

                <c:if test="${message != null}">
                    <div class="alert alert-info d-flex align-items-center" role="alert">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <div>${message}</div>
                    </div>
                </c:if>

                <p class="text-muted text-center mb-4">
                    Nhập mã <b>OTP</b> đã nhận qua email <b>${email}</b> và nhập mật khẩu mới.
                </p>

                <form action="${pageContext.request.contextPath}/verify-forgot" method="post">
                    <input type="hidden" name="email" value="${email}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold text-center w-100">MÃ XÁC THỰC (OTP):</label>
                        <input type="text" name="otp" class="form-control otp-input form-control-lg" maxlength="6" placeholder="000000" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu mới:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Xác nhận mật khẩu mới:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-check-all"></i></span>
                            <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-danger w-100 py-2 fw-bold">
                        <i class="bi bi-arrow-repeat"></i> CẬP NHẬT MẬT KHẨU MỚI
                    </button>
                </form>

                <div class="text-center mt-3 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Quay lại đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
