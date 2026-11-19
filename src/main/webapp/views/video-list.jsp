<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Video - Phân trang 6sp/trang</title>
    <style>
        .video-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 10px;
            overflow: hidden;
        }
        .video-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12) !important;
        }
        .poster-container {
            position: relative;
            background-color: #111;
            height: 200px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .poster-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .play-btn {
            position: absolute;
            font-size: 48px;
            color: rgba(255,255,255,0.85);
            pointer-events: none;
            transition: transform 0.2s, color 0.2s;
        }
        .video-card:hover .play-btn {
            transform: scale(1.15);
            color: #ffc107;
        }
        .video-title {
            color: #212529;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.05rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 52px;
        }
        .video-title:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-3">
        <!-- Tiêu đề trang & Nút điều hướng -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4 p-3 bg-white rounded shadow-sm border">
            <div>
                <h3 class="fw-bold text-primary mb-1">
                    <i class="bi bi-collection-play-fill text-danger"></i> Quản Lý & Khám Phá Videos
                </h3>
                <span class="text-muted small">
                    Yêu cầu bài tập: Phân trang chuẩn <b>6 sản phẩm / trang</b> trên URL <code>/video</code>.
                </span>
            </div>
            <div class="d-flex gap-2">
                <c:if test="${sessionScope.account != null}">
                    <a href="${pageContext.request.contextPath}/video/add" class="btn btn-success fw-bold">
                        <i class="bi bi-plus-circle"></i> Đăng Video Mới (CRUD)
                    </a>
                </c:if>
            </div>
        </div>

        <!-- Bộ lọc Tabs: Video của tôi vs Tất cả Video -->
        <ul class="nav nav-pills mb-4 bg-white p-2 rounded shadow-sm border">
            <c:if test="${sessionScope.account != null}">
                <li class="nav-item">
                    <a class="nav-link ${filterType == 'my' ? 'active bg-primary' : ''} fw-semibold" 
                       href="${pageContext.request.contextPath}/video?type=my&page=1">
                        <i class="bi bi-person-badge"></i> Video của tôi (${sessionScope.account.userName})
                    </a>
                </li>
            </c:if>
            <li class="nav-item">
                <a class="nav-link ${filterType == 'all' ? 'active bg-primary' : ''} fw-semibold" 
                   href="${pageContext.request.contextPath}/video?type=all&page=1">
                    <i class="bi bi-grid-fill"></i> Tất cả Video hệ thống
                </a>
            </li>
        </ul>

        <!-- Lưới hiển thị 6 video mỗi trang -->
        <c:choose>
            <c:when test="${not empty videoList}">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
                    <c:forEach items="${videoList}" var="v">
                        <div class="col">
                            <div class="card h-100 video-card shadow-sm border-0 bg-white">
                                <div class="poster-container">
                                    <c:choose>
                                        <c:when test="${v.poster != null && !v.poster.isEmpty()}">
                                            <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" alt="${v.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-white text-center"><i class="bi bi-camera-video fs-1"></i></div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="play-btn"><i class="bi bi-play-circle-fill"></i></div>
                                </div>

                                <div class="card-body p-3 d-flex flex-column justify-content-between">
                                    <div>
                                        <!-- YÊU CẦU: BẤM VÀO TIÊU ĐỀ ĐỂ PHÁT VÀ XEM CHI TIẾT VIDEO -->
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" 
                                           class="video-title mb-2" title="${v.title}">
                                            ${v.title}
                                        </a>

                                        <p class="text-muted small mb-2 text-truncate">
                                            ${v.description != null && !v.description.isEmpty() ? v.description : 'Chưa có mô tả cho video này.'}
                                        </p>
                                    </div>

                                    <div class="pt-2 border-top mt-2">
                                        <div class="d-flex justify-content-between text-muted small mb-2">
                                            <span><i class="bi bi-eye-fill text-info"></i> ${v.views} lượt xem</span>
                                            <span><i class="bi bi-person-fill text-secondary"></i> ${v.user != null ? v.user.fullName : 'Hệ thống'}</span>
                                        </div>

                                        <!-- Các nút CRUD dành cho chủ sở hữu video hoặc Admin -->
                                        <c:if test="${sessionScope.account != null && (sessionScope.account.id == v.userId || sessionScope.account.roleid == 1)}">
                                            <div class="d-flex gap-2 mt-2">
                                                <a href="${pageContext.request.contextPath}/video/edit?id=${v.videoId}" 
                                                   class="btn btn-sm btn-outline-warning w-50 fw-semibold">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/video/delete?id=${v.videoId}" 
                                                   class="btn btn-sm btn-outline-danger w-50 fw-semibold"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa video này không?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- PHÂN TRANG 6 SẢN PHẨM / TRANG -->
                <nav aria-label="Phân trang video" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/video?type=${filterType}&page=${currentPage - 1}">
                                <i class="bi bi-chevron-left"></i> Trang trước
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/video?type=${filterType}&page=${i}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/video?type=${filterType}&page=${currentPage + 1}">
                                Trang sau <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center p-5 rounded shadow-sm border-0 bg-white">
                    <i class="bi bi-inbox fs-1 text-warning d-block mb-3"></i>
                    <h5>Chưa có video nào trong danh mục này!</h5>
                    <p class="text-muted">Bạn có thể là người đầu tiên đăng tải video lên hệ thống.</p>
                    <c:if test="${sessionScope.account != null}">
                        <a href="${pageContext.request.contextPath}/video/add" class="btn btn-primary fw-bold mt-2">
                            <i class="bi bi-plus-lg"></i> Đăng Video Ngay
                        </a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
