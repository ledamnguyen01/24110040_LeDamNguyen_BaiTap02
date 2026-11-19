<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực kích hoạt tài khoản OTP</title>
</head>
<body>
    <div class="card auth-card shadow-lg mx-auto" style="max-width: 450px; width: 100%;">
        <div class="card-header bg-success text-white text-center py-3 rounded-top">
            <h4 class="mb-0 fw-bold"><i class="bi bi-shield-check"></i> KÍCH HOẠT TÀI KHOẢN</h4>
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
                Nhập mã <b>OTP gồm 6 chữ số</b> đã được gửi đến email <b>${email}</b>.
            </p>

            <form action="${pageContext.request.contextPath}/verify-register" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="email" value="${email}">

                <div class="mb-4">
                    <label class="form-label fw-semibold text-center w-100">MÃ XÁC THỰC (OTP): <span class="text-danger">*</span></label>
                    <div class="has-validation">
                        <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold" 
                               style="letter-spacing: 8px; font-size: 24px;" maxlength="6" pattern="[0-9]{6}" placeholder="000000" required autofocus>
                        <div class="invalid-feedback text-center">Vui lòng nhập đúng 6 chữ số mã OTP!</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2 fw-bold">
                    <i class="bi bi-check2-circle"></i> XÁC NHẬN & KÍCH HOẠT
                </button>
            </form>

            <div class="text-center mt-3 pt-3 border-top">
                <span>Đã kích hoạt xong? </span>
                <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
