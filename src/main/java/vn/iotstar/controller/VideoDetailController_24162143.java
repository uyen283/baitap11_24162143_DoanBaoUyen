package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.service.IVideoService_24162143;
import vn.iotstar.service.impl.VideoServiceImpl_24162143;

import java.io.IOException;

@WebServlet("/video/detail")
public class VideoDetailController_24162143 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IVideoService_24162143 videoService = new VideoServiceImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Video_24162143 video = videoService.findById(id);

        req.setAttribute("video", video);
        req.getRequestDispatcher("/WEB-INF/views/video-detail.jsp").forward(req, resp);
    }
}