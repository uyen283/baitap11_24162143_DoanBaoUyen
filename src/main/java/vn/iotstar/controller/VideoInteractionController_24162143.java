package vn.iotstar.controller;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.dao.IVideoDao_24162143;
import vn.iotstar.dao.impl.VideoDaoImpl_24162143;
import vn.iotstar.entity.Favorite_24162143;
import vn.iotstar.entity.Share_24162143;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

import java.io.IOException;
import java.util.Date;

@WebServlet("/video/like-share")
public class VideoInteractionController_24162143 extends HttpServlet {
    private IVideoDao_24162143 videoDao = new VideoDaoImpl_24162143();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=UTF-8");

        String action = req.getParameter("action");
        String videoId = req.getParameter("videoId");

        HttpSession session = req.getSession();
        User_24162143 currentUser = (User_24162143) session.getAttribute("account");

        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();
            Video_24162143 video = em.find(Video_24162143.class, videoId);

            // Nếu người dùng chưa đăng nhập, lấy tài khoản "admin" hoặc "user1" sẵn có trong CSDL để lưu
            if (currentUser == null) {
                currentUser = em.find(User_24162143.class, "admin");
                if (currentUser == null) {
                    currentUser = em.find(User_24162143.class, "user1");
                }
            }

            if ("like".equals(action)) {
                Favorite_24162143 fav = new Favorite_24162143();
                fav.setVideo(video);
                fav.setUser(currentUser);
                fav.setLikedDate(new Date());
                em.persist(fav);
            } else if ("share".equals(action)) {
                Share_24162143 share = new Share_24162143();
                share.setVideo(video);
                share.setUser(currentUser);
                share.setEmails(currentUser != null ? currentUser.getEmail() : "user@gmail.com");
                share.setSharedDate(new Date());
                em.persist(share);
            }

            em.getTransaction().commit();

            // Truy vấn lại để đếm số lượng mới nhất
            Video_24162143 updatedVideo = videoDao.findById(videoId);
            int count = 0;
            if ("like".equals(action) && updatedVideo.getFavorites() != null) {
                count = updatedVideo.getFavorites().size();
            } else if ("share".equals(action) && updatedVideo.getShares() != null) {
                count = updatedVideo.getShares().size();
            }

            resp.getWriter().print(count);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            resp.getWriter().print("ERROR");
        } finally {
            em.close();
        }
    }
}