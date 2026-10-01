<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Video</title>
    <!-- Bootstrap 5 CSS & FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .detail-card {
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .poster-img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .info-label {
            font-size: 1rem;
            color: #495057;
            margin-bottom: 8px;
        }

        .badge-share {
            background-color: #6c757d;
            font-size: 0.9rem;
            padding: 8px 16px;
            transition: all 0.2s ease-in-out;
        }
        .badge-share:hover {
            background-color: #5c636a;
        }

        .badge-like {
            background-color: #dc3545;
            font-size: 0.9rem;
            padding: 8px 16px;
            transition: all 0.2s ease-in-out;
        }
        .badge-like:hover {
            background-color: #bb2d3b;
        }

        .description-box {
            background-color: #f8f9fa;
            border-left: 4px solid #0d6efd;
            border-radius: 4px;
            padding: 15px;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<!-- Header chứa Menu Navigation (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-5">
    <!-- Nút quay lại trang chủ -->
    <div class="mb-3">
        <a href="<c:url value='/home'/>" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Trang Chủ
        </a>
    </div>

    <!-- Khung thông tin chi tiết video dạng Layout 2 Cột -->
    <div class="card detail-card p-4">
        <div class="row align-items-center">
            <!-- Cột bên trái: Poster Ảnh -->
            <div class="col-md-5 mb-3 mb-md-0">
                <c:choose>
                    <c:when test="${not empty video.poster && video.poster.startsWith('http')}">
                        <img src="${video.poster}" class="poster-img" alt="Poster Video">
                    </c:when>
                    <c:otherwise>
                        <img src="<c:url value='/images/${video.poster}'/>" class="poster-img" alt="Poster Video" 
                             onerror="this.src='https://via.placeholder.com/300x280?text=No+Image';">
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Cột bên phải: Các trường thông tin -->
            <div class="col-md-7 ps-md-4">
                <h3 class="fw-bold text-primary mb-3">
                    <i class="fa-solid fa-film me-2"></i>Tiêu đề: ${video.title}
                </h3>
                
                <div class="info-label">
                    <strong>Mã video:</strong> <span class="badge bg-secondary">${video.videoId}</span>
                </div>
                
                <div class="info-label">
                    <strong>Category name:</strong> <span class="fw-semibold text-dark">${video.category != null ? video.category.categoryname : 'N/A'}</span>
                </div>
                
                <div class="info-label">
                    <strong>View:</strong> <span class="fw-bold text-success">${video.views}</span>
                </div>

                <!-- Thêm hiển thị Giá bán -->
                <div class="info-label mb-3 mt-1">
                    <strong>Giá bán:</strong> 
                    <span class="fw-bold text-danger fs-5">
                        <fmt:formatNumber value="${video.price != null ? video.price : 50000}" type="currency" currencySymbol="đ"/>
                    </span>
                </div>

                <!-- Các nút thao tác: Share, Like và Thêm Giỏ Hàng -->
                <div class="d-flex flex-wrap gap-2 mt-4">
                    <button type="button" class="btn badge-share text-white rounded-2 border-0" onclick="handleInteraction('share', '${video.videoId}')">
                        <i class="fa-solid fa-share-nodes me-1"></i> Share (<span id="shareCount">${video.shares != null ? video.shares.size() : 0}</span>)
                    </button>
                    <button type="button" class="btn badge-like text-white rounded-2 border-0" onclick="handleInteraction('like', '${video.videoId}')">
                        <i class="fa-solid fa-thumbs-up me-1"></i> Like (<span id="likeCount">${video.favorites != null ? video.favorites.size() : 0}</span>)
                    </button>
                    <a href="<c:url value='/cart/add?id=${video.videoId}'/>" class="btn btn-success rounded-2 fw-bold">
                        <i class="fa-solid fa-cart-plus me-1"></i> Thêm Giỏ Hàng
                    </a>
                </div>
            </div>
        </div>

        <hr class="my-4 text-muted">

        <!-- Phần Description bên dưới -->
        <div>
            <h5 class="fw-bold text-secondary mb-2">Description:</h5>
            <div class="description-box text-dark fs-6">
                ${not empty video.description ? video.description : 'Chưa có mô tả cho video này.'}
            </div>
        </div>
    </div>
</div>

<!-- Footer chứa thông tin sinh viên (Câu 1) -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<!-- JavaScript xử lý bấm Like/Share không bị load lại trang -->
<script>
function handleInteraction(action, videoId) {
    var params = "action=" + encodeURIComponent(action) + "&videoId=" + encodeURIComponent(videoId);
    
    fetch('${pageContext.request.contextPath}/video/like-share', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: params
    })
    .then(response => response.text())
    .then(data => {
        var cleanData = data.trim();
        if (cleanData === 'LOGIN_REQUIRED') {
            alert('Bạn vui lòng đăng nhập để thực hiện chức năng này!');
            window.location.href = '${pageContext.request.contextPath}/login';
        } else if (cleanData !== 'ERROR' && !isNaN(cleanData) && cleanData !== '') {
            if (action === 'like') {
                document.getElementById('likeCount').innerText = cleanData;
            } else if (action === 'share') {
                document.getElementById('shareCount').innerText = cleanData;
            }
        } else {
            alert('Thao tác không thành công! Vui lòng kiểm tra lại kết nối CSDL.');
        }
    })
    .catch(error => {
        console.error('Lỗi hệ thống:', error);
    });
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>