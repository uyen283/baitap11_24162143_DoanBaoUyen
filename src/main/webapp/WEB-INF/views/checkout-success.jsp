<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-auto text-center py-5">
    <div class="card shadow-sm border-0 p-5 mx-auto" style="max-width: 500px;">
        <div class="text-success display-1 mb-3"><i class="fa-solid fa-circle-check"></i></div>
        <h3 class="fw-bold text-dark mb-2">ĐẶT HÀNG THÀNH CÔNG!</h3>
        <p class="text-muted">Mã đơn hàng của bạn là: <strong class="text-primary">#${orderId}</strong></p>
        <p class="small text-secondary">Cảm ơn bạn đã trải nghiệm dịch vụ. Đơn hàng sẽ sớm được giao đến bạn theo hình thức COD.</p>
        <a href="<c:url value='/home'/>" class="btn btn-primary mt-3">Quay về Trang Chủ</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>