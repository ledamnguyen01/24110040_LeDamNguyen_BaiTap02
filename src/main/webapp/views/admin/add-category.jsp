<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
</head>
<body>
    <div class="card shadow-sm border-0" style="max-width: 650px; margin: 20px auto;">
        <div class="card-header bg-success text-white py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-plus-circle"></i> THÊM DANH MỤC MỚI</h4>
        </div>
        <div class="card-body p-4">
            <c:if test="${error != null}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>${error}</div>
                </div>
            </c:if>

            <form action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-tag-fill"></i></span>
                        <input type="text" name="catename" class="form-control" placeholder="Nhập tên danh mục (vd: Quần Jean Nam)" 
                               value="${catename}" required minlength="2" maxlength="100" autofocus>
                        <div class="invalid-feedback">Vui lòng nhập tên danh mục (tối thiểu 2 ký tự)!</div>
                    </div>
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
</body>
</html>
