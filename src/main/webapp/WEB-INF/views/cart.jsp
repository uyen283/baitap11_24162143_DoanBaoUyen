<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng Của Bạn</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-5">
    <h3 class="fw-bold mb-4 text-primary"><i class="fa-solid fa-cart-shopping me-2"></i>Giỏ Hàng Của Bạn</h3>

    <c:choose>
        <c:when test="${empty sessionScope.cart}">
            <div class="alert alert-info text-center py-4">
                <h5>Giỏ hàng đang trống!</h5>
                <a href="<c:url value='/home'/>" class="btn btn-primary mt-2">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-md-8">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-0">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Sản Phẩm</th>
                                        <th>Đơn Giá</th>
                                        <th style="width: 140px;">Số Lượng</th>
                                        <th>Thành Tiền</th>
                                        <th class="text-center">Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.cart.values()}" var="item">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${item.video.poster}" style="width: 70px; height: 50px; object-fit: cover;" class="rounded me-3" onerror="this.src='https://via.placeholder.com/70x50?text=No+Image';">
                                                    <span class="fw-semibold">${item.video.title}</span>
                                                </div>
                                            </td>
                                            <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ"/></td>
                                            <td>
                                                <form action="<c:url value='/cart/update'/>" method="post" class="d-flex">
                                                    <input type="hidden" name="id" value="${item.video.videoId}">
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" 
                                                           class="form-control form-control-sm text-center" onchange="this.form.submit()">
                                                </form>
                                            </td>
                                            <td class="fw-bold text-success"><fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="đ"/></td>
                                            <td class="text-center">
                                                <a href="<c:url value='/cart/remove?id=${item.video.videoId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa sản phẩm này?')">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <a href="<c:url value='/home'/>" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục chọn đồ</a>
                </div>

                <!-- TỔNG QUAN ĐƠN HÀNG & PHÍ SHIP -->
                <div class="col-md-4">
                    <div class="card shadow-sm border-0 p-3">
                        <h5 class="fw-bold border-bottom pb-2">Tóm Tắt Đơn Hàng</h5>
                        <div class="d-flex justify-content-between my-2">
                            <span>Tiền hàng:</span>
                            <span class="fw-semibold"><fmt:formatNumber value="${sessionScope.subtotal}" type="currency" currencySymbol="đ"/></span>
                        </div>
                        <div class="d-flex justify-content-between my-2">
                            <span>Phí vận chuyển (Ship):</span>
                            <span class="fw-semibold text-primary">
                                <c:choose>
                                    <c:when test="${sessionScope.shippingFee == 0}">
                                        <span class="badge bg-success">Miễn phí ship</span>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${sessionScope.shippingFee}" type="currency" currencySymbol="đ"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between my-2 fs-5 fw-bold">
                            <span>Tổng thanh toán:</span>
                            <span class="text-danger"><fmt:formatNumber value="${sessionScope.grandTotal}" type="currency" currencySymbol="đ"/></span>
                        </div>
                        <a href="<c:url value='/checkout'/>" class="btn btn-success w-100 mt-3 py-2 fw-bold">
                            <i class="fa-solid fa-credit-card me-1"></i> Tiến Hành Thanh Toán COD
                        </a>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>