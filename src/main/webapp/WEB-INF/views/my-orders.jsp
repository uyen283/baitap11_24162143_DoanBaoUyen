<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đơn Hàng Của Tôi</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container my-5">
		<h3 class="fw-bold mb-4 text-primary">
			<i class="fa-solid fa-box-archive me-2"></i>Lịch Sử Đơn Hàng Đã Đặt
		</h3>

		<c:choose>
			<c:when test="${empty orders}">
				<div class="alert alert-info text-center py-4">
					<h5>Bạn chưa có đơn hàng nào!</h5>
					<a href="<c:url value='/home'/>" class="btn btn-primary mt-2">Đi
						mua sắm ngay</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="card shadow-sm border-0">
					<div class="card-body p-0">
						<table class="table table-hover align-middle mb-0">
							<thead class="table-dark">
								<tr>
									<th>Mã Đơn</th>
									<th>Ngày Đặt</th>
									<th>Địa Chỉ</th>
									<th>Số Điện Thoại</th>
									<th>Phương Thức</th>
									<th>Tổng Tiền</th>
									<th>Trạng Thái</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orders}" var="o">
									<tr>
										<td><strong class="text-primary">#${o.orderId}</strong></td>
										<td><fmt:formatDate value="${o.createDate}"
												pattern="dd/MM/yyyy HH:mm" /></td>
										<td>${o.address}</td>
										<td>${o.phone}</td>
										<td><span class="badge bg-info text-dark">${o.paymentMethod}</span></td>
										<td class="fw-bold text-danger"><fmt:formatNumber
												value="${o.totalAmount}" type="currency" currencySymbol="đ" /></td>
										<td><span class="badge bg-warning text-dark">
												${o.status == 'PENDING' ? 'Chờ xử lý' : o.status} </span>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>