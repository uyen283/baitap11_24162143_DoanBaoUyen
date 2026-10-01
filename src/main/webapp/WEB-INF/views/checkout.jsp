<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng (COD)</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-5" style="max-width: 700px;">
    <div class="card shadow border-0 p-4">
        <h4 class="fw-bold text-success mb-3 text-center">THANH TOÁN ĐƠN HÀNG (COD)</h4>

        <!-- TÓM TẮT CHI PHÍ -->
        <div class="bg-light p-3 rounded mb-4 border">
            <div class="d-flex justify-content-between mb-1">
                <span>Tiền hàng:</span>
                <span class="fw-semibold"><fmt:formatNumber value="${sessionScope.subtotal}" type="currency" currencySymbol="đ"/></span>
            </div>
            <div class="d-flex justify-content-between mb-1">
                <span>Phí ship:</span>
                <span class="fw-semibold text-primary">
                    <c:choose>
                        <c:when test="${sessionScope.shippingFee == 0}">Miễn phí</c:when>
                        <c:otherwise><fmt:formatNumber value="${sessionScope.shippingFee}" type="currency" currencySymbol="đ"/></c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="d-flex justify-content-between fw-bold fs-5 text-danger border-top pt-2 mt-2">
                <span>TỔNG CONG:</span>
                <span><fmt:formatNumber value="${sessionScope.grandTotal}" type="currency" currencySymbol="đ"/></span>
            </div>
        </div>

        <form action="<c:url value='/checkout'/>" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Địa chỉ giao hàng</label>
                <input type="text" name="address" class="form-control" required placeholder="Nhập địa chỉ cụ thể...">
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Số điện thoại liên hệ</label>
                <input type="tel" name="phone" class="form-control" required placeholder="Nhập số điện thoại nhận hàng...">
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Ghi chú đơn hàng</label>
                <textarea name="note" class="form-control" rows="2" placeholder="Ghi chú cho shipper (nếu có)..."></textarea>
            </div>
            <div class="mb-4 form-check bg-light p-3 rounded">
                <input class="form-check-input ms-1" type="radio" checked id="codRadio">
                <label class="form-check-label fw-bold ms-2" for="codRadio">
                    Thanh toán bằng tiền mặt khi nhận hàng (COD)
                </label>
            </div>
            <button type="submit" class="btn btn-success w-100 py-2 fw-bold fs-5">
                Xác Nhận Đặt Hàng COD
            </button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>