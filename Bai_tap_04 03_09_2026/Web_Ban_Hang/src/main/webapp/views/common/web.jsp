<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi" class="h-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>

    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons 1.11.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        :root {
            --bs-font-sans-serif: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            --primary-color: #4f46e5;
            --primary-hover: #4338ca;
        }

        body {
            font-family: var(--bs-font-sans-serif);
            background-color: #f8fafc;
            color: #1e293b;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        .text-primary {
            color: var(--primary-color) !important;
        }

        .bg-primary {
            background-color: var(--primary-color) !important;
        }

        /* Card enhancements */
        .card {
            border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 0.85rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card-product:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.15) !important;
        }

        .card-header {
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
            background-color: #ffffff;
            font-weight: 600;
        }

        /* Form validation styling */
        .was-validated .form-control:invalid, .form-control.is-invalid {
            border-color: #ef4444;
            background-image: none;
        }
        .was-validated .form-control:valid, .form-control.is-valid {
            border-color: #10b981;
            background-image: none;
        }
        .invalid-feedback {
            font-size: 0.82rem;
            color: #ef4444;
            margin-top: 0.35rem;
            display: block;
        }

        .hover-text-primary:hover {
            color: #818cf8 !important;
            transition: color 0.2s ease;
        }
    </style>

    <sitemesh:write property='head'/>
</head>
<body class="d-flex flex-column h-100">

    <!-- Header / Navbar -->
    <jsp:include page="/views/common/web/header.jsp" />

    <!-- Main Content Area -->
    <main class="flex-shrink-0 my-4">
        <div class="container">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/views/common/web/footer.jsp" />

    <!-- Bootstrap 5.3.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Global Client-side Bootstrap Form Validation Enabler -->
    <script>
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                const forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>