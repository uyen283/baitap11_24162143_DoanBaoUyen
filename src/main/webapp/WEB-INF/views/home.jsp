<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .category-header {
            color: #0d6efd;
            font-weight: 700;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 8px;
            margin-top: 25px;
            margin-bottom: 15px;
        }

        .video-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background: #ffffff;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .video-poster {
            height: 180px;
            object-fit: cover;
            border-top-left-radius: 7px;
            border-top-right-radius: 7px;
        }

        .video-info-label {
            font-size: 0.88rem;
            color: #333333;
            margin-bottom: 3px;
        }

        .btn-detail-link {
            border: 1px solid #b6d4fe;
            color: #0d6efd;
            background-color: #ffffff;
            font-size: 0.8rem;
            padding: 3px 10px;
            border-radius: 4px;
            text-decoration: none;
        }

        .btn-detail-link:hover {
            background-color: #0d6efd;
            color: #ffffff;
        }

        .badge-share {
            background-color: #6c757d;
            font-weight: normal;
        }

        .badge-like {
            background-color: #dc3545;
            font-weight: normal;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<!-- 1. NHÚNG HEADER CHỨA MENU (CÂU 1) -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-3">
    <c:forEach items="${categories}" var="cat">
        <!-- Tên Category + Số lượng video (Câu 4 & 5) -->
        <h5 class="category-header">
            ${cat.categoryname} (${mapVideoCounts[cat.categoryId]})
        </h5>

        <!-- Khung hiển thị 3 video nằm ngang đúng chuẩn mẫu đề thi -->
        <div class="row">
            <c:forEach items="${mapVideos[cat.categoryId]}" var="v">
                <div class="col-md-4 mb-4">
                    <div class="card video-card h-100">
                        <img src="${v.poster}" class="card-img-top video-poster" alt="Poster" onerror="this.src='https://via.placeholder.com/300x180?text=No+Image';">
                        <div class="card-body p-3 d-flex flex-column">
                            <div class="video-info-label"><strong>Tiêu đề:</strong> ${v.title}</div>
                            <div class="video-info-label"><strong>Mã video:</strong> ${v.videoId}</div>
                            <div class="video-info-label"><strong>Category name:</strong> ${cat.categoryname}</div>
                            <div class="video-info-label"><strong>View:</strong> ${v.views}</div>

                            <!-- Thêm hiển thị Giá bán -->
                            <div class="video-info-label mb-3 mt-1">
                                <strong>Giá bán:</strong> 
                                <span class="fw-bold text-danger fs-6">
                                    <fmt:formatNumber value="${v.price != null ? v.price : 50000}" type="currency" currencySymbol="đ"/>
                                </span>
                            </div>

                            <div class="mt-auto pt-2 border-top">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div>
                                        <span class="badge badge-share">Share(${v.shares != null ? v.shares.size() : 0})</span>
                                        <span class="badge badge-like">Like(${v.favorites != null ? v.favorites.size() : 0})</span>
                                    </div>
                                    <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="btn-detail-link">
                                        Xem chi tiết
                                    </a>
                                </div>
                                <!-- Nút Thêm vào giỏ hàng -->
                                <a href="<c:url value='/cart/add?id=${v.videoId}'/>" class="btn btn-sm btn-success w-100 fw-semibold">
                                    <i class="fa-solid fa-cart-plus me-1"></i> Thêm Giỏ Hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Thanh phân trang dạng <<< 1 2 >>> chuẩn động theo tham số URL -->
        <c:set var="currentCatPage" value="${param['cat_'.concat(cat.categoryId)] != null ? param['cat_'.concat(cat.categoryId)] : 1}" />
        <div class="d-flex justify-content-center my-2">
            <nav>
                <ul class="pagination pagination-sm">
                    <li class="page-item ${currentCatPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/home?cat_${cat.categoryId}=${currentCatPage - 1}'/>">&lt;&lt;&lt;</a>
                    </li>
                    <c:forEach begin="1" end="${mapMaxPages[cat.categoryId]}" var="p">
                        <li class="page-item ${p == currentCatPage ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/home?cat_${cat.categoryId}=${p}'/>">${p}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentCatPage >= mapMaxPages[cat.categoryId] ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/home?cat_${cat.categoryId}=${currentCatPage + 1}'/>">&gt;&gt;&gt;</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:forEach>
</div>

<!-- 2. NHÚNG FOOTER CHỨA THÔNG TIN SINH VIÊN (CÂU 1) -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>