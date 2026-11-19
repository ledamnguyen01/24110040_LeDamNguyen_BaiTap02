<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${video.title} - Xem Video Chi Tiết</title>
    <style>
        .player-wrapper {
            background-color: #000;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }
        video {
            width: 100%;
            max-height: 520px;
            display: block;
        }
        .sidebar-item {
            transition: background-color 0.2s;
            border-radius: 8px;
            padding: 8px;
        }
        .sidebar-item:hover {
            background-color: #f1f3f5;
        }
        .sidebar-thumb {
            width: 110px;
            height: 70px;
            object-fit: cover;
            border-radius: 6px;
        }
        .sidebar-title {
            color: #212529;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .sidebar-title:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-3">
        <div class="row g-4">
            <!-- CỘT TRÁI: TRÌNH PHÁT VIDEO & THÔNG TIN CHI TIẾT -->
            <div class="col-lg-8">
                <!-- YÊU CẦU: PLAY 01 VIDEO KHI BẤM CHUỘT VÀO TIÊU ĐỀ -->
                <div class="player-wrapper mb-3">
                    <video controls poster="${pageContext.request.contextPath}/image?fname=${video.poster}" autoplay>
                        <source src="${pageContext.request.contextPath}/image?fname=${video.videoFile}" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                    </video>
                </div>

                <!-- Tiêu đề & Thông tin bổ trợ -->
                <div class="bg-white p-4 rounded-3 shadow-sm border mb-4">
                    <h3 class="fw-bold text-dark mb-2">${video.title}</h3>

                    <div class="d-flex justify-content-between align-items-center flex-wrap pb-3 mb-3 border-bottom text-muted small">
                        <div class="d-flex align-items-center gap-3">
                            <span><i class="bi bi-eye-fill text-danger fs-6"></i> <strong>${video.views}</strong> lượt xem</span>
                            <span><i class="bi bi-calendar-event"></i> Ngày đăng: <fmt:formatDate value="${video.createDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                            <span class="badge ${video.active ? 'bg-success' : 'bg-secondary'}">
                                ${video.active ? 'Hoạt động' : 'Tạm ẩn'}
                            </span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-person-circle fs-5 text-primary"></i>
                            <div>
                                <span class="fw-bold text-dark">${video.user != null ? video.user.fullName : 'Quản Trị Viên'}</span>
                                <span class="text-secondary">(@${video.user != null ? video.user.userName : 'admin'})</span>
                            </div>
                        </div>
                    </div>

                    <!-- Mô tả chi tiết video -->
                    <h5 class="fw-bold text-secondary mb-2"><i class="bi bi-file-earmark-text"></i> Mô tả video:</h5>
                    <div class="p-3 bg-light rounded text-dark" style="white-space: pre-line; line-height: 1.6;">
                        ${video.description != null && !video.description.isEmpty() ? video.description : 'Người đăng chưa cập nhật phần mô tả cho video này.'}
                    </div>

                    <!-- Các nút tương tác -->
                    <div class="mt-4 d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách Video
                        </a>
                        <c:if test="${sessionScope.account != null && (sessionScope.account.id == video.userId || sessionScope.account.roleid == 1)}">
                            <div>
                                <a href="${pageContext.request.contextPath}/video/edit?id=${video.videoId}" class="btn btn-warning me-2 fw-semibold">
                                    <i class="bi bi-pencil-square"></i> Chỉnh sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/video/delete?id=${video.videoId}" class="btn btn-danger fw-semibold"
                                   onclick="return confirm('Bạn có chắc muốn xóa video này?');">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- CỘT PHẢI: VIDEO ĐỀ XUẤT / TOP VIDEO MỚI NHẤT -->
            <div class="col-lg-4">
                <div class="bg-white p-3 rounded-3 shadow-sm border">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-collection-play"></i> Video Đề Xuất</h5>

                    <div class="d-flex flex-column gap-2">
                        <c:forEach items="${relatedVideos}" var="rv">
                            <c:if test="${rv.videoId != video.videoId}">
                                <div class="d-flex gap-2 sidebar-item">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${rv.videoId}" class="flex-shrink-0">
                                        <img src="${pageContext.request.contextPath}/image?fname=${rv.poster}" alt="${rv.title}" class="sidebar-thumb">
                                    </a>
                                    <div class="d-flex flex-column justify-content-between">
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${rv.videoId}" class="sidebar-title">
                                            ${rv.title}
                                        </a>
                                        <div class="text-muted small">
                                            <div><i class="bi bi-eye"></i> ${rv.views} lượt xem</div>
                                            <div><i class="bi bi-person"></i> ${rv.user != null ? rv.user.fullName : 'Admin'}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
