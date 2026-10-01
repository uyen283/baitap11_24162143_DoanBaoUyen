<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="<c:url value='/home'/>">VideoPortal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link text-white" href="<c:url value='/home'/>">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="#">Sản phẩm</a></li>
                <c:if test="${sessionScope.account != null && sessionScope.account.admin}">
                    <li class="nav-item"><a class="nav-link text-warning fw-bold" href="<c:url value='/admin/videos'/>">Trang quản trị</a></li>
                </c:if>
            </ul>
            
            <ul class="navbar-nav align-items-center">
                <!-- 1. NÚT XEM HÀNG ĐANG BỎ TRONG GIỎ (Có đếm số lượng) -->
                <li class="nav-item me-2">
                    <a class="btn btn-outline-warning btn-sm position-relative" href="<c:url value='/cart'/>">
                        <i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            ${sessionScope.cart != null ? sessionScope.cart.size() : 0}
                        </span>
                    </a>
                </li>

                <!-- 2. NÚT XEM ĐƠN HÀNG ĐÃ MUA (Lịch sử COD) -->
                <li class="nav-item me-3">
                    <a class="btn btn-outline-info btn-sm" href="<c:url value='/my-orders'/>">
                        <i class="fa-solid fa-box-archive me-1"></i> Đơn hàng đã đặt
                    </a>
                </li>

                <!-- ĐĂNG NHẬP / ĐĂNG XUẤT -->
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item me-2"><a class="btn btn-outline-light btn-sm" href="<c:url value='/'/>">Đăng nhập</a></li>
                        <li class="nav-item"><a class="btn btn-primary btn-sm" href="<c:url value='/register'/>">Đăng ký</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-3 text-white align-self-center">Xin chào, ${sessionScope.account.fullname}</li>
                        <li class="nav-item"><a class="btn btn-outline-danger btn-sm" href="<c:url value='/logout'/>">Đăng xuất</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>