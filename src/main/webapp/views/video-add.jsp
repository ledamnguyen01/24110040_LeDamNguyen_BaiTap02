<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Video Mới - Upload Multipart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .form-card { max-width: 680px; margin: 30px auto; border-radius: 12px; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card form-card shadow-sm border-0 bg-white">
            <div class="card-header bg-success text-white py-3 rounded-top">
                <h4 class="mb-0 fw-bold"><i class="bi bi-cloud-upload"></i> ĐĂNG TẢI VIDEO MỚI (MULTIPART UPLOAD)</h4>
            </div>
            <div class="card-body p-4">
                <p class="text-muted small mb-4">
                    Áp dụng cơ chế <b>@MultipartConfig</b> trong Jakarta Servlet để tải lên hình ảnh poster và tệp tin video.
                </p>

                <form action="${pageContext.request.contextPath}/video/add" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Hình ảnh Poster (Thumbnail):</label>
                        <input type="file" name="poster" class="form-control" accept="image/*">
                        <div class="form-text">Hỗ trợ các định dạng ảnh: PNG, JPG, JPEG, GIF.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tệp tin Video (MP4):</label>
                        <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
                        <div class="form-text">Hỗ trợ tệp tin định dạng MP4 phát trên trình duyệt HTML5.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả nội dung Video:</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập thông tin chi tiết về video này..."></textarea>
                    </div>

                    <div class="mb-4 form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="active" id="activeSwitch" checked>
                        <label class="form-check-label fw-semibold" for="activeSwitch">Hiển thị video công khai (Active)</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Hủy bỏ
                        </a>
                        <button type="submit" class="btn btn-success px-4 fw-bold">
                            <i class="bi bi-check-circle"></i> Lưu & Đăng Tải Video
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
