<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản mới</title>
</head>
<body>
    <div class="card auth-card shadow-lg mx-auto" style="max-width: 500px; width: 100%;">
        <div class="card-header bg-success text-white text-center py-3 rounded-top">
            <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus"></i> ĐĂNG KÝ TÀI KHOẢN</h4>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>${alert}</div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên đăng nhập (Username): <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Từ 3-30 ký tự, không dấu" 
                               value="${username_val}" required minlength="3" maxlength="30" pattern="^[a-zA-Z0-9_]{3,30}$" autofocus>
                        <div class="invalid-feedback">Vui lòng nhập tên tài khoản (3-30 ký tự chữ cái, số hoặc gạch dưới)!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên đầy đủ: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                        <input type="text" name="fullname" class="form-control" placeholder="Ví dụ: Lê Đàm Nguyên" 
                               value="${fullname_val}" required minlength="2">
                        <div class="invalid-feedback">Vui lòng nhập họ và tên (tối thiểu 2 ký tự)!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="Ví dụ: nguyendm@gmail.com" 
                               value="${email_val}" required>
                        <div class="invalid-feedback">Vui lòng nhập email hợp lệ!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                        <input type="tel" name="phone" class="form-control" placeholder="Ví dụ: 0912345678" 
                               value="${phone_val}" required pattern="^0[0-9]{9}$">
                        <div class="invalid-feedback">Vui lòng nhập số điện thoại Việt Nam hợp lệ (10 chữ số, bắt đầu bằng 0)!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-key"></i></span>
                        <input type="password" name="password" id="regPassword" class="form-control" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                        <div class="invalid-feedback">Mật khẩu phải có độ dài tối thiểu 6 ký tự!</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                        <input type="password" name="repassword" id="regRePassword" class="form-control" placeholder="Nhập lại mật khẩu trên" required minlength="6" data-match="regPassword">
                        <div class="invalid-feedback">Mật khẩu xác nhận phải trùng khớp và tối thiểu 6 ký tự!</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2 fw-bold">
                    <i class="bi bi-check-circle"></i> ĐĂNG KÝ NGAY
                </button>
            </form>

            <div class="text-center mt-3 pt-3 border-top">
                <span>Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Đăng nhập ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
