<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP</title>
    <!-- Bootstrap 5 CSS & FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .otp-card {
            border: none;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 1.5rem;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<!-- Header chứa Menu Navigation (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-auto py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card otp-card p-4 p-md-5">
                
                <div class="text-center mb-4">
                    <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px;">
                        <i class="fa-solid fa-shield-halved fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">XÁC THỰC MÃ OTP</h3>
                    <p class="text-muted small mb-0">Mã OTP kích hoạt đã được khởi tạo thành công.</p>
                    <small class="text-danger fw-semibold">
                        <i class="fa-solid fa-bug me-1"></i>(Trong lúc chấm bài, hãy kiểm tra cửa sổ <strong>Console</strong> của STS/Eclipse để lấy mã)
                    </small>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show text-center py-2" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="<c:url value='/verify-otp'/>" method="post">
                    <div class="mb-4">
                        <label class="form-label text-secondary fw-semibold small text-center d-block">Nhập 6 chữ số OTP từ Console</label>
                        <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold text-success otp-input" placeholder="000000" maxlength="6" required autocomplete="off">
                    </div>
                    
                    <button type="submit" class="btn btn-success btn-lg w-100 fw-bold fs-6 py-2 shadow-sm">
                        <i class="fa-solid fa-check-double me-1"></i> Kích Hoạt Tài Khoản
                    </button>
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