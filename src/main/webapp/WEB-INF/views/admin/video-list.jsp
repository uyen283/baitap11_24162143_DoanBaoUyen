<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Video - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<!-- Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-4">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center py-3">
            <h5 class="mb-0 fw-bold"><i class="bi bi-film me-2"></i>Danh Sách Video (Admin)</h5>
            <a href="<c:url value='/admin/video/add'/>" class="btn btn-light text-primary fw-semibold btn-sm">
                <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
            </a>
        </div>
        <div class="card-body p-0">
            <!-- Table Bảng hiển thị -->
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" style="width: 100px;">Mã Video</th>
                            <th class="text-center" style="width: 120px;">Poster</th>
                            <th>Tiêu Đề</th>
                            <th class="text-center" style="width: 130px;">Giá Bán</th>
                            <th class="text-center" style="width: 100px;">Lượt Xem</th>
                            <th class="text-center" style="width: 110px;">Trạng Thái</th>
                            <th class="text-center" style="width: 160px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${videos}" var="v">
                            <tr>
                                <td class="text-center fw-bold text-secondary">${v.videoId}</td>
                                <td class="text-center">
                                    <img src="${v.poster}" class="img-thumbnail" style="height: 60px; width: 90px; object-fit: cover;" alt="poster" onerror="this.src='https://via.placeholder.com/90x60?text=No+Image';">
                                </td>
                                <td class="fw-semibold text-dark">${v.title}</td>
                                
                                <!-- HIỂN THỊ CỘT GIÁ BÁN -->
                                <td class="text-center fw-bold text-danger">
                                    <fmt:formatNumber value="${v.price}" type="currency" currencySymbol="đ"/>
                                </td>

                                <td class="text-center"><span class="badge bg-info text-dark">${v.views}</span></td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${v.active}">
                                            <span class="badge bg-success">Hiển thị</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Ẩn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>" class="btn btn-sm btn-outline-warning me-1">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" 
                                       class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Phân Trang 6 Video / Trang -->
        <div class="card-footer bg-white d-flex justify-content-center py-3">
            <nav>
                <ul class="pagination pagination-sm mb-0">
                    <c:forEach begin="1" end="${maxPage}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/admin/videos?page=${i}'/>">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>