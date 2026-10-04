<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đơn Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .nav-tabs .nav-link {
            color: #495057;
            font-weight: 600;
            font-size: 0.9rem;
            white-space: nowrap;
        }
        .nav-tabs .nav-link.active {
            color: #0d6efd;
            border-bottom: 3px solid #0d6efd;
            background-color: transparent;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-4">
    <h3 class="fw-bold text-primary mb-3">
        <i class="fa-solid fa-boxes-packing me-2"></i>Lịch Sử Đơn Hàng Đã Đặt
    </h3>

    <!-- THANH NÚT LỌC TRẠNG THÁI (NAV TABS) -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-2 overflow-auto">
            <ul class="nav nav-tabs nav-fill flex-nowrap border-0">
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'ALL' ? 'active' : ''}" href="<c:url value='/my-orders?status=ALL'/>">Tất cả</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'NEW' ? 'active' : ''}" href="<c:url value='/my-orders?status=NEW'/>">Đơn hàng mới</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'CONFIRMED' ? 'active' : ''}" href="<c:url value='/my-orders?status=CONFIRMED'/>">Đã xác nhận</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'PREPARING' ? 'active' : ''}" href="<c:url value='/my-orders?status=PREPARING'/>">Chuẩn bị hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'SHIPPING' ? 'active' : ''}" href="<c:url value='/my-orders?status=SHIPPING'/>">Vận chuyển</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'DELIVERING' ? 'active' : ''}" href="<c:url value='/my-orders?status=DELIVERING'/>">Giao hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'DELIVERED' ? 'active' : ''}" href="<c:url value='/my-orders?status=DELIVERED'/>">Đã giao</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'CANCELLED' ? 'active' : ''}" href="<c:url value='/my-orders?status=CANCELLED'/>">Đơn hàng hủy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'RETURNED' ? 'active' : ''}" href="<c:url value='/my-orders?status=RETURNED'/>">Đơn hàng hoàn</a>
                </li>
            </ul>
        </div>
    </div>

    <!-- BẢNG ĐƠN HÀNG -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="text-center py-5 text-muted">
                        <i class="fa-solid fa-receipt fa-3x mb-3 text-secondary"></i>
                        <h5>Không có đơn hàng nào trong trạng thái này!</h5>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-center">Mã Đơn</th>
                                    <th>Ngày Đặt</th>
                                    <th>Địa Chỉ</th>
                                    <th>Số Điện Thoại</th>
                                    <th class="text-center">Phương Thức</th>
                                    <th class="text-end">Tổng Tiền</th>
                                    <th class="text-center">Trạng Thái</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td class="text-center fw-bold text-primary">#${o.orderId}</td>
                                        <td><fmt:formatDate value="${o.createDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>${o.address}</td>
                                        <td>${o.phone}</td>
                                        <td class="text-center">
                                            <span class="badge bg-info text-dark">${o.paymentMethod}</span>
                                        </td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="đ"/>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${o.status == 'NEW' || o.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark">Đơn hàng mới</span>
                                                </c:when>
                                                <c:when test="${o.status == 'CONFIRMED'}">
                                                    <span class="badge bg-primary">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${o.status == 'PREPARING'}">
                                                    <span class="badge bg-info text-dark">Chuẩn bị hàng</span>
                                                </c:when>
                                                <c:when test="${o.status == 'SHIPPING'}">
                                                    <span class="badge bg-secondary">Vận chuyển</span>
                                                </c:when>
                                                <c:when test="${o.status == 'DELIVERING'}">
                                                    <span class="badge bg-primary">Đang giao hàng</span>
                                                </c:when>
                                                <c:when test="${o.status == 'DELIVERED'}">
                                                    <span class="badge bg-success">Đã giao</span>
                                                </c:when>
                                                <c:when test="${o.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${o.status == 'RETURNED'}">
                                                    <span class="badge bg-dark">Đã hoàn</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${o.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:if test="${o.status == 'NEW' || o.status == 'PENDING' || o.status == 'CONFIRMED'}">
                                                <a href="<c:url value='/my-orders/cancel?id=${o.orderId}'/>" 
                                                   class="btn btn-sm btn-outline-danger fw-semibold"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?');">
                                                    Hủy đơn
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>