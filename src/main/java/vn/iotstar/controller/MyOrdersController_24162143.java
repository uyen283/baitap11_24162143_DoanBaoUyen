package vn.iotstar.controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.Order_24162143;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/my-orders", "/my-orders/cancel"})
public class MyOrdersController_24162143 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        // Xử lý Hủy đơn hàng
        if ("/my-orders/cancel".equals(path)) {
            cancelOrder(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        User_24162143 user = (User_24162143) session.getAttribute("account");

        if (user == null) {
            session.setAttribute("redirectUrl", req.getContextPath() + "/my-orders");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String statusFilter = req.getParameter("status");
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            statusFilter = "ALL";
        }

        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.clear();

            String jpql;
            TypedQuery<Order_24162143> query;

            if ("ALL".equalsIgnoreCase(statusFilter)) {
                jpql = "SELECT o FROM Order_24162143 o WHERE o.user.username = :username ORDER BY o.createDate DESC";
                query = em.createQuery(jpql, Order_24162143.class);
                query.setParameter("username", user.getUsername());
            } else {
                jpql = "SELECT o FROM Order_24162143 o WHERE o.user.username = :username AND o.status = :status ORDER BY o.createDate DESC";
                query = em.createQuery(jpql, Order_24162143.class);
                query.setParameter("username", user.getUsername());
                query.setParameter("status", statusFilter);
            }

            List<Order_24162143> orders = query.getResultList();

            req.setAttribute("orders", orders);
            req.setAttribute("currentStatus", statusFilter);
            req.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("orders", java.util.Collections.emptyList());
            req.setAttribute("currentStatus", statusFilter);
            req.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(req, resp);
        } finally {
            em.close();
        }
    }

    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String orderIdStr = req.getParameter("id");
        if (orderIdStr != null) {
            EntityManager em = JpaConfig_24162143.getEntityManager();
            EntityTransaction trans = em.getTransaction();
            try {
                trans.begin();
                int orderId = Integer.parseInt(orderIdStr);
                Order_24162143 order = em.find(Order_24162143.class, orderId);
                
                // Chỉ cho phép hủy nếu đơn chưa giao đi
                if (order != null && ("NEW".equals(order.getStatus()) || "PENDING".equals(order.getStatus()) || "CONFIRMED".equals(order.getStatus()))) {
                    order.setStatus("CANCELLED");
                    em.merge(order);
                }
                trans.commit();
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/my-orders?status=CANCELLED");
    }
}