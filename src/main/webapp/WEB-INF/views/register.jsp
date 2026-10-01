<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản</title>
    <!-- Bootstrap 5 CSS & FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .register-card {
            border: none;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .btn-register {
            border-radius: 8px;
            padding: 10px;
            font-weight: 600;
            transition: all 0.2s ease-in-out;
        }

        .btn-register:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<!-- Header chứa Menu (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-auto py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card register-card p-4 p-md-5">
                
                <!-- Tiêu đề trang đăng ký -->
                <div class="text-center mb-4">
                    <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px;">
                        <i class="fa-solid fa-user-plus fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">ĐĂNG KÝ TÀI KHOẢN</h3>
                    <p class="text-muted small">Tạo tài khoản mới để trải nghiệm dịch vụ</p>
                </div>

                <!-- Thông báo lỗi (nếu có) -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Form Nhập Thông Tin Đăng Ký -->
                <form action="<c:url value='/register'/>" method="post">
                    
                    <!-- Username -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fa-solid fa-user me-1"></i> Tên đăng nhập (Username)
                        </label>
                        <input type="text" name="username" class="form-control form-control-lg fs-6" placeholder="Nhập tên đăng nhập..." required>
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fa-solid fa-lock me-1"></i> Mật khẩu
                        </label>
                        <input type="password" name="password" class="form-control form-control-lg fs-6" placeholder="Nhập mật khẩu..." required>
                    </div>

                    <!-- Fullname -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fa-solid fa-id-card me-1"></i> Họ và tên
                        </label>
                        <input type="text" name="fullname" class="form-control form-control-lg fs-6" placeholder="Nhập họ và tên đầy đủ..." required>
                    </div>

                    <!-- Email -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fa-solid fa-envelope me-1"></i> Địa chỉ Email
                        </label>
                        <input type="email" name="email" class="form-control form-control-lg fs-6" placeholder="nhapemail@domain.com" required>
                    </div>

                    <!-- Nút Gửi OTP Đăng ký -->
                    <button type="submit" class="btn btn-primary btn-register w-100 fs-6 mb-3">
                        <i class="fa-solid fa-paper-plane me-1"></i> Gửi Mã OTP Đăng Ký
                    </button>

                    <!-- Chuyển sang Đăng nhập -->
                    <div class="text-center mt-3 pt-3 border-top">
                        <span class="text-muted">Đã có tài khoản?</span> 
                        <a href="<c:url value='/login'/>" class="text-primary fw-bold text-decoration-none ms-1">
                            Đăng nhập ngay
                        </a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- Footer chứa thông tin sinh viên (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>