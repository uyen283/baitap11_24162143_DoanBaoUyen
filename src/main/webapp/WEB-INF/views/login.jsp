<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <!-- Bootstrap 5 CSS & FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .login-card {
            border: none;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
        .btn-login {
            border-radius: 8px;
            padding: 10px;
            font-weight: 600;
            transition: all 0.2s ease-in-out;
        }
        .btn-login:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<!-- Header chứa Menu Navigation (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-auto py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card login-card p-4 p-md-4">
                
                <div class="text-center mb-4">
                    <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px;">
                        <i class="fa-solid fa-right-to-bracket fs-3"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-1">ĐĂNG NHẬP HỆ THỐNG</h4>
                    <p class="text-muted small mb-0">Vui lòng nhập tài khoản để tiếp tục</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show text-center py-2 small" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="<c:url value='/login'/>" method="post">
                    <div class="mb-3">
                        <label class="form-label text-secondary fw-semibold small">
                            <i class="fa-solid fa-user me-1"></i> Tài khoản
                        </label>
                        <input type="text" name="username" class="form-control form-control-lg fs-6" placeholder="Tên đăng nhập" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-secondary fw-semibold small">
                            <i class="fa-solid fa-key me-1"></i> Mật khẩu
                        </label>
                        <input type="password" name="password" class="form-control form-control-lg fs-6" placeholder="Mật khẩu" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-login w-100 fs-6">
                        <i class="fa-solid fa-arrow-right-to-bracket me-1"></i> Đăng nhập
                    </button>
                </form>

                <div class="text-center mt-3 pt-3 border-top">
                    <span class="small text-muted">Chưa có tài khoản? </span>
                    <a href="<c:url value='/register'/>" class="small text-primary fw-bold text-decoration-none">
                        Đăng ký ngay
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Footer chứa thông tin sinh viên (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>