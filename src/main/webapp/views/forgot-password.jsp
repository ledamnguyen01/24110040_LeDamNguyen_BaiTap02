<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 440px; margin: 60px auto; border: none; border-radius: 12px; }
    </style>
</head>
<body>
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card auth-card shadow-lg">
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

                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Địa chỉ Email:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" name="email" class="form-control" placeholder="Ví dụ: nguyendm@gmail.com" required autofocus>
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
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
