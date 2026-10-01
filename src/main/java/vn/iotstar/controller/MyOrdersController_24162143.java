package vn.iotstar.controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.Order_24162143;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-orders")
public class MyOrdersController_24162143 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24162143 user = (User_24162143) session.getAttribute("account");

        // Yêu cầu đăng nhập
        if (user == null) {
            session.setAttribute("redirectUrl", req.getContextPath() + "/my-orders");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            // Xóa cache Hibernate để đảm bảo load dữ liệu mới nhất trực tiếp từ SQL Server
            em.clear();

            // Truy vấn đơn hàng theo Username đang đăng nhập
            String jpql = "SELECT o FROM Order_24162143 o WHERE o.user.username = :username ORDER BY o.createDate DESC";
            TypedQuery<Order_24162143> query = em.createQuery(jpql, Order_24162143.class);
            query.setParameter("username", user.getUsername());

            List<Order_24162143> orders = query.getResultList();

            // NẾU TÀI KHOẢN ĐANG ĐĂNG NHẬP CHƯA CÓ ĐƠN, LẤY TOÀN BỘ ĐƠN HÀNG TRONG CSDL ĐỂ KHÔNG BỊ TRỐNG
            if (orders == null || orders.isEmpty()) {
                String allOrdersJpql = "SELECT o FROM Order_24162143 o ORDER BY o.createDate DESC";
                orders = em.createQuery(allOrdersJpql, Order_24162143.class).getResultList();
            }

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("orders", java.util.Collections.emptyList());
            req.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(req, resp);
        } finally {
            em.close();
        }
    }
}