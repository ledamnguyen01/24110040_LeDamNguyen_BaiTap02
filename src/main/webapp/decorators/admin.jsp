<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Admin Panel</title>

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            font-size: .875rem;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
        }
        .sidebar {
            min-height: calc(100vh - 48px);
        }
        .sidebar .nav-link {
            font-weight: 500;
            color: #333;
            transition: all 0.2s;
        }
        .sidebar .nav-link:hover {
            color: #0d6efd;
            background-color: #e9ecef;
        }
        main {
            flex: 1 0 auto;
        }
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
    <!-- Admin Header -->
    <%@ include file="/common/admin/header.jsp" %>

    <div class="container-fluid">
        <div class="row">
            <!-- Admin Left Sidebar -->
            <%@ include file="/common/admin/left.jsp" %>

            <!-- Admin Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <sitemesh:write property="body"/>
            </main>
        </div>
    </div>

    <!-- Admin Footer -->
    <c:import url="/common/admin/footer.jsp" />

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
