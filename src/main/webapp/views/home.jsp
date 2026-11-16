<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Shopping & Video MVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .video-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 10px;
            overflow: hidden;
        }
        .video-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12) !important;
        }
        .video-poster-box {
            position: relative;
            background-color: #000;
            height: 180px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .video-poster-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.9;
        }
        .play-overlay {
            position: absolute;
            font-size: 40px;
            color: rgba(255,255,255,0.85);
            pointer-events: none;
            transition: transform 0.2s;
        }
        .video-card:hover .play-overlay {
            transform: scale(1.15);
            color: #ffc107;
        }
        .video-title-link {
            color: #212529;
            text-decoration: none;
            font-weight: 600;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 48px;
        }
        .video-title-link:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/topbar.jsp"></jsp:include>

    <div class="container py-3">
        <!-- Banner chào mừng -->
        <div class="p-4 mb-4 bg-white rounded-3 shadow-sm border">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div>
                    <h2 class="fw-bold text-primary mb-1">
                        <i class="bi bi-play-btn-fill text-danger"></i> Hệ Thống Video & Shopping MVC
                    </h2>
                    <p class="text-muted mb-0">
                        Bài tập 02 - Lập trình Web HCMUTE (ThS. Nguyễn Hữu Trung) - Kiến trúc MVC 3 tầng & Quản lý Video.
                    </p>
                </div>
                <div>
                    <c:if test="${sessionScope.account != null}">
                        <a href="${pageContext.request.contextPath}/video/add" class="btn btn-success fw-semibold">
                            <i class="bi bi-cloud-arrow-up-fill"></i> Đăng Video Mới
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-primary fw-semibold ms-2">
                        <i class="bi bi-collection-play"></i> Xem Tất Cả Video
                    </a>
                </div>
            </div>
        </div>

        <!-- MỤC YÊU CẦU: HIỂN THỊ 10 VIDEO MỚI NHẤT -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="fw-bold text-dark mb-0">
                <i class="bi bi-fire text-danger"></i> 10 Video Mới Nhất
            </h4>
            <span class="badge bg-danger rounded-pill px-3 py-2">Mới cập nhật</span>
        </div>

        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-3 mb-5">
            <c:forEach items="${top10Videos}" var="v" varStatus="loop">
                <div class="col">
                    <div class="card h-100 video-card shadow-sm border-0 bg-white">
                        <div class="video-poster-box">
                            <c:choose>
                                <c:when test="${v.poster != null && !v.poster.isEmpty()}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" alt="${v.title}">
                                </c:when>
                                <c:otherwise>
                                    <div class="text-white text-center"><i class="bi bi-film fs-1"></i></div>
                                </c:otherwise>
                            </c:choose>
                            <div class="play-overlay"><i class="bi bi-play-circle-fill"></i></div>
                        </div>

                        <div class="card-body p-2 d-flex flex-column justify-content-between">
                            <!-- Bấm vào tiêu đề để xem chi tiết và phát video -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-link mb-2" title="${v.title}">
                                ${v.title}
                            </a>

                            <div class="small text-muted mt-auto">
                                <div class="d-flex justify-content-between">
                                    <span><i class="bi bi-eye"></i> ${v.views} lượt xem</span>
                                    <span>#${loop.index + 1}</span>
                                </div>
                                <div class="text-truncate mt-1 text-secondary">
                                    <i class="bi bi-person"></i> ${v.user != null ? v.user.fullName : 'Admin'}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Thông tin tài khoản đăng nhập nếu có -->
        <c:if test="${sessionScope.account != null}">
            <div class="card shadow-sm border-0 p-3 mb-4 bg-white">
                <h6 class="fw-bold text-secondary mb-2"><i class="bi bi-info-circle"></i> Thông tin tài khoản của bạn:</h6>
                <div class="row text-muted small">
                    <div class="col-md-3"><strong>Tài khoản:</strong> ${sessionScope.account.userName}</div>
                    <div class="col-md-3"><strong>Họ tên:</strong> ${sessionScope.account.fullName}</div>
                    <div class="col-md-3"><strong>Email:</strong> ${sessionScope.account.email}</div>
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/video?type=my" class="text-primary fw-bold text-decoration-none">
                            <i class="bi bi-camera-video"></i> Xem video đã đăng (${sessionScope.account.userName})
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
