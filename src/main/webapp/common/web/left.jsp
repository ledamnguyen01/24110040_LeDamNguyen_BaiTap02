<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="card shadow-sm mb-4">
    <div class="card-header bg-dark text-white fw-bold">
        <i class="bi bi-list-stars me-2"></i> Danh mục nhanh
    </div>
    <div class="list-group list-group-flush">
        <a href="${pageContext.request.contextPath}/home" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span><i class="bi bi-house-door me-2 text-primary"></i> Trang chủ</span>
        </a>
        <a href="${pageContext.request.contextPath}/video" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span><i class="bi bi-play-btn-fill me-2 text-danger"></i> Tất cả Video</span>
        </a>
        <c:if test="${sessionScope.account != null}">
            <a href="${pageContext.request.contextPath}/video?type=my" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span><i class="bi bi-person-video me-2 text-info"></i> Video của tôi</span>
            </a>
            <a href="${pageContext.request.contextPath}/video/add" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span><i class="bi bi-cloud-upload-fill me-2 text-success"></i> Upload Video mới</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span><i class="bi bi-person-circle me-2 text-warning"></i> Thông tin Profile</span>
            </a>
        </c:if>
        <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
            <a href="${pageContext.request.contextPath}/admin/category/list" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center list-group-item-warning">
                <span><i class="bi bi-shield-lock-fill me-2 text-danger"></i> Quản trị Category</span>
            </a>
        </c:if>
    </div>
</div>
