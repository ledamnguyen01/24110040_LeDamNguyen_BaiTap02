<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .form-card { max-width: 600px; margin: 40px auto; border-radius: 12px; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="card form-card shadow-sm border-0">
            <div class="card-header bg-success text-white py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-plus-circle"></i> THÊM DANH MỤC MỚI</h4>
            </div>
            <div class="card-body p-4">
                <form action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên danh mục:</label>
                        <input type="text" name="catename" class="form-control" placeholder="Nhập tên danh mục (vd: Quần Jean Nam)" required autofocus>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Ảnh đại diện (Icon):</label>
                        <input type="file" name="icon" class="form-control" accept="image/*">
                        <div class="form-text">Hỗ trợ các định dạng .png, .jpg, .jpeg. Nếu không chọn sẽ dùng ảnh mặc định.</div>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="<c:url value='/admin/category/list'/>" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                        <div>
                            <button type="reset" class="btn btn-outline-secondary me-2">Hủy</button>
                            <button type="submit" class="btn btn-success fw-bold">
                                <i class="bi bi-save"></i> Thêm mới
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
