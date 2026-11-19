<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
</head>
<body>
    <div class="card shadow-sm border-0" style="max-width: 650px; margin: 20px auto;">
        <div class="card-header bg-warning text-dark py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square"></i> CẬP NHẬT DANH MỤC</h4>
        </div>
        <div class="card-body p-4">
            <c:if test="${error != null}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>${error}</div>
                </div>
            </c:if>

            <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="id" value="${category.id}">
                <input type="hidden" name="oldIcon" value="${category.icon}">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã danh mục (ID):</label>
                    <input type="text" class="form-control bg-light" value="${category.id}" readonly disabled>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục: <span class="text-danger">*</span></label>
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-tag-fill"></i></span>
                        <input type="text" name="catename" class="form-control" value="${category.name}" required minlength="2" maxlength="100" autofocus>
                        <div class="invalid-feedback">Vui lòng nhập tên danh mục (tối thiểu 2 ký tự)!</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Ảnh đại diện hiện tại:</label>
                    <div class="mb-2">
                        <c:choose>
                            <c:when test="${category.icon != null && category.icon.startsWith('http')}">
                                <img src="${category.icon}" alt="Icon" class="img-thumbnail" style="max-height: 80px;">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/image?fname=${category.icon}'/>" alt="Icon" class="img-thumbnail" style="max-height: 80px;"
                                     onerror="this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png'">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <label class="form-label fw-semibold">Chọn ảnh mới (nếu muốn đổi):</label>
                    <input type="file" name="icon" class="form-control" accept="image/*">
                </div>

                <div class="d-flex justify-content-between">
                    <a href="<c:url value='/admin/category/list'/>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-warning fw-bold text-dark">
                        <i class="bi bi-check-circle"></i> Cập nhật danh mục
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
