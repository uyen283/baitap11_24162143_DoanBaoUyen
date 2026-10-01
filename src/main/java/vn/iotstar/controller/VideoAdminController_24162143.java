package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.service.IVideoService_24162143;
import vn.iotstar.service.impl.VideoServiceImpl_24162143;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/videos", "/admin/video/add", "/admin/video/edit", "/admin/video/delete", "/admin/video/save"})
public class VideoAdminController_24162143 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IVideoService_24162143 videoService = new VideoServiceImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/videos".equals(path)) {
            int page = 1;
            int pageSize = 6; // Đề bài yêu cầu 6 video / trang
            if (req.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(req.getParameter("page"));
                } catch (Exception ignored) {}
            }
            List<Video_24162143> list = videoService.findAll(page, pageSize);
            int total = videoService.count();
            int maxPage = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("videos", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("maxPage", maxPage);
            req.getRequestDispatcher("/WEB-INF/views/admin/video-list.jsp").forward(req, resp);
        } else if ("/admin/video/delete".equals(path)) {
            String id = req.getParameter("id");
            videoService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } else if ("/admin/video/edit".equals(path)) {
            String id = req.getParameter("id");
            Video_24162143 v = videoService.findById(id);
            req.setAttribute("video", v);
            req.getRequestDispatcher("/WEB-INF/views/admin/video-form.jsp").forward(req, resp);
        } else if ("/admin/video/add".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/video-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/video/save".equals(path)) {
            String videoId = req.getParameter("videoId");
            String title = req.getParameter("title");
            String poster = req.getParameter("poster");
            String description = req.getParameter("description");
            boolean active = Boolean.parseBoolean(req.getParameter("active"));

            // ĐỌC VÀ ÉP KIỂU GIÁ BÁN TỪ FORM (MẶC ĐỊNH 50,000 NẾU ĐỂ TRỐNG)
            String priceStr = req.getParameter("price");
            double price = 50000.0;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    price = Double.parseDouble(priceStr);
                } catch (Exception ignored) {}
            }

            Video_24162143 v = videoService.findById(videoId);
            boolean isNew = false;
            if (v == null) {
                v = new Video_24162143();
                v.setVideoId(videoId);
                v.setViews(0);
                isNew = true;
            }
            v.setTitle(title);
            v.setPrice(price); // SET GIÁ BÁN CHO VIDEO
            v.setPoster(poster);
            v.setDescription(description);
            v.setActive(active);

            if (isNew) {
                videoService.insert(v);
            } else {
                videoService.update(v);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }
}