<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Video - Shopping MVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .form-card { max-width: 680px; margin: 30px auto; border-radius: 12px; }
        .preview-thumb { width: 140px; height: 90px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card form-card shadow-sm border-0 bg-white">
            <div class="card-header bg-warning text-dark py-3 rounded-top">
                <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square"></i> CẬP NHẬT THÔNG TIN VIDEO</h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/video/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="videoId" value="${video.videoId}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control" value="${video.title}" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Poster hiện tại:</label>
                        <div class="d-flex align-items-center gap-3 mb-2">
                            <img src="${pageContext.request.contextPath}/image?fname=${video.poster}" alt="Poster" class="preview-thumb border">
                            <span class="text-muted small">${video.poster}</span>
                        </div>
                        <label class="form-label fw-semibold">Thay đổi Poster mới (Nếu muốn):</label>
                        <input type="file" name="poster" class="form-control" accept="image/*">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tệp tin Video hiện tại:</label>
                        <div class="text-muted small mb-2"><i class="bi bi-file-earmark-play"></i> ${video.videoFile}</div>
                        <label class="form-label fw-semibold">Thay đổi File Video mới (Nếu muốn):</label>
                        <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả nội dung Video:</label>
                        <textarea name="description" class="form-control" rows="4">${video.description}</textarea>
                    </div>

                    <div class="mb-4 form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="active" id="activeSwitch" ${video.active ? 'checked' : ''}>
                        <label class="form-check-label fw-semibold" for="activeSwitch">Hiển thị video công khai (Active)</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Hủy bỏ
                        </a>
                        <button type="submit" class="btn btn-warning px-4 fw-bold text-dark">
                            <i class="bi bi-save"></i> Cập Nhật Video
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
