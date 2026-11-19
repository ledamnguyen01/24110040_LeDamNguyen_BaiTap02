<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - User Profile</title>
</head>
<body>
<div class="container py-2">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Header card -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-4 bg-primary text-white rounded-3">
                    <div class="d-flex align-items-center flex-wrap gap-3">
                        <div class="position-relative">
                            <c:choose>
                                <c:when test="${user.avatar != null && user.avatar.startsWith('http')}">
                                    <img id="profileAvatarPreview" src="${user.avatar}" alt="Avatar" class="rounded-circle border border-3 border-white shadow-sm bg-white" style="width: 100px; height: 100px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img id="profileAvatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.avatar != null ? user.avatar : 'avata.png'}" 
                                         alt="Avatar" class="rounded-circle border border-3 border-white shadow-sm bg-white" style="width: 100px; height: 100px; object-fit: cover;"
                                         onerror="this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png'">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="flex-grow-1">
                            <h3 class="fw-bold mb-1">${user.fullName}</h3>
                            <p class="mb-1 opacity-75">
                                <i class="bi bi-person-fill"></i> <strong>@${user.userName}</strong>
                                &nbsp;|&nbsp; <i class="bi bi-envelope-fill"></i> ${user.email}
                            </p>
                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <span class="badge ${user.roleid == 1 ? 'bg-warning text-dark' : 'bg-info text-dark'}">
                                    <i class="bi bi-shield-check"></i> ${user.roleid == 1 ? 'Quản Trị Viên (Admin)' : 'Thành Viên'}
                                </span>
                                <c:choose>
                                    <c:when test="${user.avatar != null && user.avatar.startsWith('http')}">
                                        <a href="${user.avatar}" target="_blank" rel="noopener" class="badge bg-success text-decoration-none">
                                            <i class="bi bi-cloud-check-fill"></i> Ảnh Cloudinary CDN
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-dark">
                                            <i class="bi bi-hdd-fill"></i> Ảnh Local Server
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Alerts -->
            <c:if test="${alert != null}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                    <div>${alert}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${message != null}">
                <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                    <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                    <div>${message}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- OTP Verification Card if user changed email -->
            <c:if test="${requireOtp}">
                <div class="card shadow-sm border-warning mb-4">
                    <div class="card-header bg-warning text-dark fw-bold d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-shield-lock-fill"></i> XÁC NHẬN MÃ OTP CẬP NHẬT EMAIL MỚI</span>
                        <span class="badge bg-dark text-warning">Hiệu lực 10 phút</span>
                    </div>
                    <div class="card-body p-4">
                        <p class="mb-3">
                            Hệ thống đã gửi một mã OTP gồm 6 chữ số đến địa chỉ email mới: 
                            <strong class="text-primary">${pending_email != null ? pending_email : sessionScope.pending_email}</strong>.
                            Vui lòng kiểm tra hộp thư đến (hoặc thư rác/spam) và nhập mã vào bên dưới để xác nhận cập nhật:
                        </p>
                        <form action="${pageContext.request.contextPath}/profile" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="verify_email_otp">
                            <div class="row g-2 align-items-start mb-3">
                                <div class="col-sm-6">
                                    <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold" 
                                           style="letter-spacing: 6px;" placeholder="000000" maxlength="6" pattern="[0-9]{6}" required autofocus>
                                    <div class="invalid-feedback">Vui lòng nhập đúng 6 chữ số mã OTP!</div>
                                </div>
                                <div class="col-sm-6">
                                    <button type="submit" class="btn btn-warning btn-lg w-100 fw-bold">
                                        <i class="bi bi-check2-circle"></i> Xác Nhận Cập Nhật Email
                                    </button>
                                </div>
                            </div>
                        </form>
                        <div class="d-flex flex-wrap gap-2 pt-2 border-top">
                            <form action="${pageContext.request.contextPath}/profile" method="post" class="d-inline">
                                <input type="hidden" name="action" value="resend_email_otp">
                                <button type="submit" class="btn btn-sm btn-outline-primary fw-semibold">
                                    <i class="bi bi-arrow-clockwise"></i> Gửi lại mã OTP
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/profile" method="post" class="d-inline">
                                <input type="hidden" name="action" value="cancel_email_change">
                                <button type="submit" class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-x-circle"></i> Hủy đổi email
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Main Profile Edit Form -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-pencil-square text-primary me-2"></i> Cập Nhật Thông Tin Cá Nhân
                    </h5>
                    <span class="badge ${cloudinaryReady ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary border'}">
                        <i class="bi bi-cloud-upload"></i> ${cloudinaryReady ? 'Cloudinary Sẵn Sàng' : 'Cloudinary Local Fallback'}
                    </span>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="update_info">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập (Username):</label>
                            <input type="text" class="form-control bg-light" value="${user.userName}" readonly disabled>
                            <div class="form-text">Tên đăng nhập được cố định và không thể thay đổi.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên: <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                                <input type="text" name="fullname" class="form-control" value="${fullname_val != null ? fullname_val : user.fullName}" required minlength="2" maxlength="100">
                                <div class="invalid-feedback">Vui lòng nhập họ và tên (từ 2 đến 100 ký tự)!</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại: <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                <input type="tel" name="phone" class="form-control" value="${phone_val != null ? phone_val : user.phone}" pattern="^0[0-9]{9}$" required>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10 chữ số, bắt đầu bằng số 0)!</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Địa chỉ Email: <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="email" class="form-control" value="${email_val != null ? email_val : user.email}" required>
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ!</div>
                            </div>
                            <div class="form-text text-warning-emphasis">
                                <i class="bi bi-info-circle"></i> Nếu thay đổi email, hệ thống sẽ gửi mã OTP 6 số đến email mới để bạn xác nhận trước khi cập nhật.
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Ảnh đại diện (Upload Cloudinary bằng Multipart):</label>
                            <div class="input-group">
                                <input type="file" name="avatar" class="form-control" accept=".jpg,.jpeg,.png,.gif,.webp,image/*" id="avatarInput">
                            </div>
                            <div class="form-text">
                                Hỗ trợ JPG, PNG, GIF, WebP (tối đa 10MB). Xem trước ảnh trực tiếp phía trên sau khi chọn tệp.
                            </div>
                            <c:if test="${user.avatar != null && user.avatar.startsWith('http')}">
                                <div class="small text-muted mt-1 text-truncate">
                                    <i class="bi bi-link-45deg"></i> URL hiện tại: <a href="${user.avatar}" target="_blank" rel="noopener">${user.avatar}</a>
                                </div>
                            </c:if>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Về Trang Chủ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="bi bi-save"></i> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    (function () {
        var avatarInput = document.getElementById('avatarInput');
        var previewImg = document.getElementById('profileAvatarPreview');
        if (!avatarInput || !previewImg) return;
        avatarInput.addEventListener('change', function (e) {
            var file = e.target.files && e.target.files[0];
            if (!file) return;
            if (file.size > 10 * 1024 * 1024) {
                alert('Ảnh đại diện vượt quá dung lượng tối đa 10MB!');
                avatarInput.value = '';
                return;
            }
            var reader = new FileReader();
            reader.onload = function (ev) {
                previewImg.src = ev.target.result;
            };
            reader.readAsDataURL(file);
        });
    })();
</script>
</body>
</html>
