<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .category-img { width: 100px; height: 100px; object-fit: cover; border-radius: 8px; border: 1px solid #ddd; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark"><i class="bi bi-folder2-open text-primary"></i> Quản lý Danh mục (Category)</h2>
                <p class="text-muted mb-0">Bài tập Servlet JDBC CRUD theo kiến trúc 3 tầng</p>
            </div>
            <div>
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-success fw-bold shadow-sm">
                    <i class="bi bi-plus-circle"></i> Thêm danh mục mới
                </a>
            </div>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-center" style="width: 80px;">STT</th>
                                <th class="text-center" style="width: 140px;">Hình ảnh</th>
                                <th>Tên danh mục</th>
                                <th class="text-center" style="width: 180px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty cateList}">
                                    <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                        <tr>
                                            <td class="text-center fw-bold">${STT.index + 1}</td>
                                            <td class="text-center">
                                                <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                                                <img class="category-img shadow-sm" src="${imgUrl}" alt="${cate.name}" onerror="this.src='https://placehold.co/100x100?text=No+Image';">
                                            </td>
                                            <td class="fs-5 fw-semibold text-primary">${cate.name}</td>
                                            <td class="text-center">
                                                <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-warning btn-sm me-2">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" 
                                                   class="btn btn-danger btn-sm" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-2 d-block"></i> Chưa có danh mục nào trong hệ thống.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
