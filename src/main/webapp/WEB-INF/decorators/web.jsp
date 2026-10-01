<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <!-- Nhận đúng tiêu đề "Trang chủ" hoặc "Đăng nhập" từ từng trang view con -->
    <title><sitemesh:write property="title"/></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100 bg-white">

    <!-- Header (Menu) theo Đề 03 (Câu 1) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="<c:url value='/home'/>">HCMUTE WEB</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/home'/>">Trang Chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sản phẩm</a>
                    </li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.admin}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold" href="<c:url value='/admin/videos'/>">Trang quản trị</a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.account == null}">
                            <li class="nav-item"><a class="nav-link" href="<c:url value='/login'/>">Đăng nhập</a></li>
                            <li class="nav-item"><a class="nav-link" href="<c:url value='/register'/>">Đăng ký</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><span class="nav-link text-info">Xin chào, ${sessionScope.account.fullname}</span></li>
                            <li class="nav-item"><a class="nav-link" href="<c:url value='/logout'/>">Đăng xuất</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- NỘI DUNG CHÍNH NẰM Ở GIỮA -->
    <main class="flex-shrink-0">
        <sitemesh:write property="body"/>
    </main>

    <!-- Footer theo Đề 03 (Câu 1) -->
    <footer class="footer mt-auto py-3 bg-light border-top text-center text-secondary">
        <div class="container">
            Họ tên: <strong class="text-dark">Đoàn Bảo Uyên</strong> | 
            MSSV: <strong class="text-dark">24162143</strong> | 
            Mã đề: <strong class="text-dark">Đề số 03</strong>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>