<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Shopping & Video MVC</title>

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: #333;
        }
        main {
            flex: 1 0 auto;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .auth-card {
            border-radius: 1rem;
            overflow: hidden;
            border: none;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.3);
            background: #ffffff;
        }
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
    <header class="py-3 text-center">
        <a href="${pageContext.request.contextPath}/home" class="text-white text-decoration-none fs-4 fw-bold">
            <i class="bi bi-play-circle-fill text-warning"></i> Shopping & Video MVC
        </a>
    </header>

    <main>
        <sitemesh:write property="body"/>
    </main>

    <footer class="text-white-50 text-center py-3 small">
        &copy; 2026 Lê Đàm Nguyên - 24110040 - Lập trình Web ThS. Nguyễn Hữu Trung - HCMUTE
    </footer>

    <!-- Bootstrap 5.3.3 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Client-side Bootstrap Form Validation Script -->
    <script>
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>
