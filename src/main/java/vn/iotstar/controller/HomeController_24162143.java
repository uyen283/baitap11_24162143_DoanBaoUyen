package vn.iotstar.controller;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.Category_24162143;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.service.IVideoService_24162143;
import vn.iotstar.service.impl.VideoServiceImpl_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {"/home"})
public class HomeController_24162143 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IVideoService_24162143 videoService = new VideoServiceImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        List<Category_24162143> categories = em.createQuery("SELECT c FROM Category_24162143 c", Category_24162143.class).getResultList();

        int pageSize = 3; // Đề bài yêu cầu 3 video / trang ở trang Home[cite: 9]

        Map<Integer, List<Video_24162143>> mapVideos = new HashMap<>();
        Map<Integer, Integer> mapMaxPages = new HashMap<>();
        Map<Integer, Integer> mapVideoCounts = new HashMap<>();

        for (Category_24162143 cat : categories) {
            int page = 1;
            String pStr = req.getParameter("cat_" + cat.getCategoryId());
            if (pStr != null) {
                try {
                    page = Integer.parseInt(pStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<Video_24162143> vList = videoService.findByCategoryId(cat.getCategoryId(), page, pageSize);
            int total = videoService.countByCategoryId(cat.getCategoryId());
            int maxPage = (int) Math.ceil((double) total / pageSize);

            mapVideos.put(cat.getCategoryId(), vList);
            mapMaxPages.put(cat.getCategoryId(), maxPage);
            mapVideoCounts.put(cat.getCategoryId(), total); // Câu 5: Đếm số lượng video theo từng Category[cite: 9]
        }

        req.setAttribute("categories", categories);
        req.setAttribute("mapVideos", mapVideos);
        req.setAttribute("mapMaxPages", mapMaxPages);
        req.setAttribute("mapVideoCounts", mapVideoCounts);

        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}