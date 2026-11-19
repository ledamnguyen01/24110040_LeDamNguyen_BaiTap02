<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Video</title>
</head>
<body>
    <div class="container py-2">
        <div class="card shadow-sm border-0 bg-white" style="max-width: 700px; margin: 20px auto;">
            <div class="card-header bg-warning text-dark py-3 rounded-top">
                <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square"></i> CẬP NHẬT THÔNG TIN VIDEO</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${error != null}">
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/video/edit" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <input type="hidden" name="videoId" value="${video.videoId}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mã Video (ID):</label>
                        <input type="text" class="form-control bg-light" value="${video.videoId}" readonly disabled>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
                        <div class="input-group has-validation">
                            <span class="input-group-text"><i class="bi bi-type-h1"></i></span>
                            <input type="text" name="title" class="form-control" value="${video.title}" required minlength="3" maxlength="255" autofocus>
                            <div class="invalid-feedback">Vui lòng nhập tiêu đề video (tối thiểu 3 ký tự)!</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Hình ảnh Poster hiện tại:</label>
                        <div class="mb-2">
                            <c:choose>
                                <c:when test="${video.poster != null && video.poster.startsWith('http')}">
                                    <img src="${video.poster}" alt="Poster" class="img-thumbnail" style="max-height: 120px;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image?fname=${video.poster}" 
                                         alt="Poster" class="img-thumbnail" style="max-height: 120px;"
                                         onerror="this.src='https://cdn-icons-png.flaticon.com/512/1179/1179069.png'">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <label class="form-label fw-semibold">Thay đổi hình ảnh Poster mới:</label>
                        <input type="file" name="poster" class="form-control" accept="image/*">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tệp tin Video hiện tại:</label>
                        <p class="text-muted small mb-1">Tệp hiện tại: <code>${video.videoFile}</code></p>
                        <label class="form-label fw-semibold">Thay đổi tệp tin Video mới (MP4):</label>
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
                            <i class="bi bi-check-circle"></i> Cập Nhật Video
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
