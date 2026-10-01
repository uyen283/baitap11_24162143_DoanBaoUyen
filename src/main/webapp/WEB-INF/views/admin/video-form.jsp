<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Video - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<!-- Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-5" style="max-width: 700px;">
    <div class="card shadow border-0">
        <div class="card-header bg-primary text-white py-3">
            <h5 class="mb-0 fw-bold">
                <c:choose>
                    <c:when test="${video != null}">Cập Nhật Thông Tin Video</c:when>
                    <c:otherwise>Thêm Video Mới</c:otherwise>
                </c:choose>
            </h5>
        </div>
        <div class="card-body p-4">
            <form action="<c:url value='/admin/video/save'/>" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã Video</label>
                    <input type="text" name="videoId" value="${video.videoId}" 
                           class="form-control" ${video != null ? 'readonly' : ''} required placeholder="Nhập mã video...">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tiêu Đề</label>
                    <input type="text" name="title" value="${video.title}" 
                           class="form-control" required placeholder="Nhập tiêu đề video...">
                </div>

                <!-- BỔ SUNG TRƯỜNG NHẬP GIÁ BÁN -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Giá Bán (VNĐ)</label>
                    <input type="number" step="1000" name="price" value="${video.price != null ? video.price : 50000}" 
                           class="form-control" required placeholder="Nhập giá bán video (mặc định 50.000)...">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Đường Dẫn Poster (URL Ảnh)</label>
                    <input type="text" name="poster" value="${video.poster}" 
                           class="form-control" placeholder="https://example.com/image.jpg">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mô Tả (Description)</label>
                    <textarea name="description" class="form-control" rows="4" 
                              placeholder="Nhập mô tả chi tiết về video...">${video.description}</textarea>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" name="active" value="true" 
                           id="activeCheck" ${video == null || video.active ? 'checked' : ''}>
                    <label class="form-check-label fw-semibold" for="activeCheck">
                        Kích Hoạt (Active)
                    </label>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="<c:url value='/admin/videos'/>" class="btn btn-secondary px-4">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">Lưu Lại</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>