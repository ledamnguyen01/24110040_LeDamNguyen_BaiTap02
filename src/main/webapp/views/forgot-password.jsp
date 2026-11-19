<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - Khôi phục tài khoản</title>
</head>
<body>
    <div class="card auth-card shadow-lg mx-auto" style="max-width: 450px; width: 100%;">
        <div class="card-header bg-warning text-dark text-center py-3 rounded-top">
            <h4 class="mb-0 fw-bold"><i class="bi bi-key-fill"></i> QUÊN MẬT KHẨU</h4>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>${alert}</div>
                </div>
            </c:if>

            <p class="text-muted text-center mb-4">
                Nhập địa chỉ email đăng ký tài khoản của bạn để nhận mã OTP đặt lại mật khẩu mới.
            </p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="Ví dụ: nguyendm@gmail.com" value="${email_val}" required autofocus>
                        <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ!</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark">
                    <i class="bi bi-send-fill"></i> GỬI MÃ XÁC NHẬN (OTP)
                </button>
            </form>

            <div class="text-center mt-3 pt-3 border-top">
                <span>Nhớ lại mật khẩu? </span>
                <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Quay lại đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
