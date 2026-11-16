<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .form-card { max-width: 600px; margin: 40px auto; border-radius: 12px; }
        .preview-img { width: 120px; height: 120px; object-fit: cover; border-radius: 8px; border: 2px solid #0d6efd; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card form-card shadow-sm border-0">
            <div class="card-header bg-warning text-dark py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square"></i> CẬP NHẬT DANH MỤC</h4>
            </div>
            <div class="card-body p-4">
                <c:url value="/admin/category/edit" var="editUrl"></c:url>
                <form action="${editUrl}" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${category.id}">
                    <input type="hidden" name="cateid" value="${category.id}">
                    <input type="hidden" name="oldIcon" value="${category.icon}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên danh mục:</label>
                        <input type="text" name="catename" value="${category.name}" class="form-control" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold d-block">Ảnh đại diện hiện tại:</label>
                        <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
                        <img class="preview-img shadow-sm mb-2" src="${imgUrl}" alt="${category.name}" onerror="this.src='https://placehold.co/120x120?text=No+Image';">
                        <div class="text-muted small">Tên file: <code>${category.icon}</code></div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Thay đổi ảnh mới (Tùy chọn):</label>
                        <input type="file" name="icon" class="form-control" accept="image/*">
                        <div class="form-text">Nếu không chọn ảnh mới, hệ thống sẽ giữ nguyên ảnh cũ.</div>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="<c:url value='/admin/category/list'/>" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                        <div>
                            <button type="reset" class="btn btn-outline-secondary me-2">Khôi phục</button>
                            <button type="submit" class="btn btn-warning fw-bold">
                                <i class="bi bi-check2-circle"></i> Cập nhật
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
