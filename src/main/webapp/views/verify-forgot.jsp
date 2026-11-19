<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu mới</title>
</head>
<body>
    <div class="card auth-card shadow-lg mx-auto" style="max-width: 450px; width: 100%;">
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

            <form action="${pageContext.request.contextPath}/verify-forgot" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="email" value="${email}">

                <div class="mb-3">
                    <label class="form-label fw-semibold text-center w-100">MÃ XÁC THỰC (OTP): <span class="text-danger">*</span></label>
                    <div class="has-validation">
                        <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold" 
                               style="letter-spacing: 8px; font-size: 24px;" maxlength="6" pattern="[0-9]{6}" placeholder="000000" required autofocus>
                        <div class="invalid-feedback text-center">Vui lòng nhập đúng 6 chữ số mã OTP!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu mới: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="newPassword" id="fpNewPassword" class="form-control" placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" required minlength="6">
                        <div class="invalid-feedback">Mật khẩu mới phải từ 6 ký tự trở lên!</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu mới: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-check-circle-fill"></i></span>
                        <input type="password" name="confirmPassword" id="fpConfirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required minlength="6" data-match="fpNewPassword">
                        <div class="invalid-feedback">Mật khẩu xác nhận phải trùng khớp và từ 6 ký tự trở lên!</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-danger w-100 py-2 fw-bold">
                    <i class="bi bi-check-circle"></i> ĐỔI MẬT KHẨU
                </button>
            </form>

            <div class="text-center mt-3 pt-3 border-top">
                <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Quay lại đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
